#!/bin/bash

trap 'mcrcon stop' SIGTERM

# Any command
if [ "$1" != '-jar' ]; then
  exec "$@"
  exit $?
fi

# Remove core file
rm -f core.*

# Wait database
echo "Waiting for mysql"
until mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h database -e 'show databases;' > /dev/null; do
  echo -n "." 1>&2
  sleep 1    
done
echo "MySQL is up - executing command" 1>&2

# EULA
sed -e 's/^eula=.*/eula='${EULA:-false}'/g' ../eula.txt > eula.txt

# Config
export DOLLAR='$'

test -f ../server.properties && envsubst < ../server.properties > server.properties
test -f ../spigot.yml && envsubst < ../spigot.yml > spigot.yml
test -f ../bukkit.yml && envsubst < ../bukkit.yml > bukkit.yml
test -f /root/my.cnf && envsubst < /root/my.cnf > /root/.my.cnf
test -f /root/.aws/credentials.template && envsubst < /root/.aws/credentials.template > /root/.aws/credentials

cat << EOF > /opt/env
BUCKET=${BUCKET}
EOF

# Plugins
if [ ! -d plugins ]; then
  mkdir plugins
  initial=true
else
  # 初回起動でなければ設定書き換えて配置
  test -d ../plugins.config && cp -fpR ../plugins.config/* ../plugins/
  for config in `find ../plugins/ -type f -not -name '*.jar' -not -name '*.schematic'`; do
    envsubst < ${config} > ${config/#?/}
  done
  for config in `find ../plugins/ -type f -name '*.schematic'`; do
    cp ${config} ${config/#?/}
  done
fi

# プラグインのリンク作成
find plugins -type l -name '*.jar' | xargs rm -f 
for plugin in `find ../plugins/ -type f -name '*.jar'`; do
  test -L plugins/${plugin} || ln -s ../${plugin} plugins/
done

# Run
screen -AmdS minecraft java ${JAVA_OPTS} "$@"

echo "Waiting for spigot"
mcrcon pl > /dev/null 2>&1
until [ $? -le 1 ]; do
  echo -n "." 1>&2
  sleep 5
  mcrcon pl > /dev/null 2>&1
done
echo "Spigot is up - executing command" 1>&2

if [ "${initial}" = true ]; then
  test -d ../plugins.config && cp -fpR ../plugins.config/* ../plugins/
  for config in `find ../plugins/ -type f -not -name '*.jar' -not -name '*.schematic'`; do
    envsubst < ${config} > ${config/#?/}
  done
  for config in `find ../plugins/ -type f -name '*.schematic'`; do
    cp ${config} ${config/#?/}
  done

  sleep 5
  mcrcon stop
else
  /usr/local/spigot/bin/mcinit
fi

crond

while pgrep java > /dev/null ; do
  sleep 1
done

killall crond

