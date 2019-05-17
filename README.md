## Build the Image

```
docker build -t primiano/docker-webvirtmgr .
```

## Webvirtmgr Dockerfile

1. Install [Docker](https://www.docker.com/).

2. Pull the image from Docker Hub

```
docker pull primiano/docker-webvirtmgr
sudo groupadd -g 1010 webvirtmgr
sudo useradd -u 1010 -g webvirtmgr -s /sbin/nologin -d /data/vm webvirtmgr
sudo mkdir -p /data/vm
sudo chown -R webvirtmgr:webvirtmgr /data/vm
```

### Usage

```
docker run -d -p 8080:8080 -p 6080:6080 --name webvirtmgr -v /data/vm:/data/vm primiano/docker-webvirtmgr
```

or

```
cp .env.sample .env # Edit with your information
docker-compose up -d
```

### libvirtd configuration on the host

```
cat /etc/default/libvirtd
# start_libvirtd="yes"
# libvirtd_opts="-l"
```

```
cat /etc/libvirt/libvirtd.conf
# listen_tls = 0
# listen_tcp = 1
# listen_addr = "172.17.0.1"  ## Address of docker0 veth on the host
# unix_sock_group = "libvirt"
# unix_sock_ro_perms = "0777"
# unix_sock_rw_perms = "0770"
# auth_unix_ro = "none"
# auth_unix_rw = "none"
# auth_tcp = "none"
# auth_tls = "none"
```

```
cat /etc/libvirt/qemu.conf
# # This is obsolete. Listen addr specified in VM xml.
# # vnc_listen = "0.0.0.0"
# vnc_tls = 0
# vnc_password = ""
```

### Environment Variables

```
HTPASSWD=admin:$apr1$WpRDoj1j$e9us9.pGVtspEsW9qbMbL/
DOMAIN=example.com
ADMIN_USER=admin
ADMIN_PASSWORD=1234
ADMIN_EMAIL=admin@localhost
DOCKER_GATEWAY_IP=172.17.0.1
WS_PUBLIC_HOST=192.168.1.2
WS_PORT=6080
QEMU_CONSOLE_DEFAULT_TYPE=spice
```
