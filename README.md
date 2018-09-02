# Host a dedicated dst server using Docker

## Sample usage:
docker run -it \
           -v <\/path/to/your/dst/config/folder>:/data \
           -v <\/path/to/mods/folder>:/mods \
           fredwanghuan:dst-server

Config folder should (at least) have these files:
```
.
|____Cluster_1
| |____cluster_token.txt
| |____Master
| | |____server.ini
| |____Caves
| | |____server.ini
| |____cluster.ini
```

Mods folder should (at least) have these files:
```
.
|____dedicated_server_mods_setup.lua
```