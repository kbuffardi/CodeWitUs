#!/bin/bash
# set permissions
sudo chown -R $USER:$USER .

# clear remnants
if [ -f yarn.lock ]
  then
    mv -f yarn.lock yarn.lock.old
fi
if [ -d ./tmp/rdbms ]
  then
    if [ -d ./tmp/rdbms_old ]
      then
        rm -rf ./tmp/rdbms_old
    fi
    mv -f ./tmp/rdbms ./tmp/rdbms_old
fi

docker-compose build
docker-compose up
