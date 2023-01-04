#!/bin/bash

db_host=db
db_name=glpi
db_user=glpi
db_password=glpi
db_port=3306

if php bin/console db:install -vvv --default-language=pt_BR --db-host=$db_host --db-port=$db_port --db-name=$db_name --db-user=$db_user --db-password=glpi --no-interaction --no-telemetry --force
then
    echo "Instalação Realizada com Sucesso!"
elif php bin/console db:install -vvv --default-language=pt_BR --db-host=$db_host --db-port=$db_port --db-name=$db_name --db-user=$db_user --db-password=glpi --no-interaction --no-telemetry --force --reconfigure
then
    echo "Instalação Realizada com Sucesso!"
else
    echo "Não foi possível concluir a instalação"
fi