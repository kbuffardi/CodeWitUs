#!/bin/bash

sudo chown -R $USER:$USER .

# clear remnants
if [ -d ./tmp/rdbms ]
  then
    mv -f ./tmp/rdbms rdbms_old
fi


docker-compose build --no-cache && docker-compose run web bundle update --all
