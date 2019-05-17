#!/bin/bash

pushd /webvirtmgr

DOCKER_GATEWAY_IP=${DOCKER_GATEWAY_IP:-172.17.0.1}
ADMIN_USER=${ADMIN_USER:-admin}
ADMIN_PASSWORD=${ADMIN_PASSWORD:-1234}
ADMIN_EMAIL=${ADMIN_EMAIL:-admin@localhost}
WS_PUBLIC_HOST=${WS_PUBLIC_HOST:-None}
WS_PORT=${WS_PORT:-6080}
QEMU_CONSOLE_DEFAULT_TYPE=${QEMU_CONSOLE_DEFAULT_TYPE:-'spice'}

sed -i "s/0.0.0.0/$DOCKER_GATEWAY_IP/g" vrtManager/create.py
sed -i "s/WS_PUBLIC.*/WS_PUBLIC_HOST = '$WS_PUBLIC_HOST'/" webvirtmgr/settings.py
sed -i "s/WS_PORT.*/WS_PORT = $WS_PORT/" webvirtmgr/settings.py
sed -i "s/QEMU_CONSOLE_DEFAULT_TYPE.*/QEMU_CONSOLE_DEFAULT_TYPE = '$QEMU_CONSOLE_DEFAULT_TYPE'/" webvirtmgr/settings.py
chown webvirtmgr /var/run/libvirt/libvirt-sock


if [ ! -f "/data/vm/webvirtmgr.sqlite3" ]; then
    /usr/bin/python manage.py syncdb --noinput
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('$ADMIN_USER', '$ADMIN_EMAIL', '$ADMIN_PASSWORD')" | /usr/bin/python manage.py shell
fi
