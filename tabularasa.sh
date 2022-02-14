#!/bin/bash
# set permissions
sudo chown -R $USER:$USER .

# clear remnants
if [ -a yarn.lock ]
  then
    mv -f yarn.lock yarn.lock.old
fi
if [ -d ./tmp/rdbms ]
  then
    mv -f ./tmp/rdbms rdbms_old
fi

docker-compose build
docker-compose up
