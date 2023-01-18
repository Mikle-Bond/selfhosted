# Bridge access to the docker containers

### Why

I want docker container to be a DNS server, availible to host.
Similar to `systemd-resolved`, it should listen on static IP 
address (`169.254.0.53`) and not rely on docker-created interfaces.

### How

These files are supposed to be placed to 
`/etc/systemd/network`. 
Set up the `dockerdns` interface for docker to hookup to.
Set up the `dockerdns2` interface with static IP address.
We hookup it as macvlan interface, similar to how docker will
do it for containers.

### What's next

In docker-compose add this network config:

```yaml
netowrks:
  dns:
    name: dns
    driver: macvlan
    driver_opts:
      parent: dockerdns
    ipam:
      config:
        - subnet: "169.254.0.0/24"
          ip_range: "169.254.0.32/27"
    
```

... or setup network manually and point to it as external

```sh
docker network create --driver macvlan --subnet 169.254.0.0/24 -o parent=dockerdns dns
```

And for the bridged service add network with static address

```yaml
services:
  dns:
    networks:
      dns:
      ipv4_address: "169.254.0.53"
    # ... the rest of definitions...
```

### References

https://major.io/2015/10/26/systemd-networkd-and-macvlan-interfaces/

https://itsecforu.ru/2022/02/01/%F0%9F%90%B3-%D0%BA%D0%B0%D0%BA-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D1%82%D1%8C-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D1%82%D1%8C-%D1%81%D0%B5%D1%82%D1%8C-macvlan-%D0%B2-docke/

https://www.hippolab.ru/virtualnyy-setevoy-interfeys-v-linux-tap-vs-tun

