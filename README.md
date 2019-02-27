# A Helper to Set SOCKS Proxy for Linux User on Login

Initially used with Centos 7.

### How to use?

1. Copy `configure-proxy.sh` to `/usr/local/bin/` and make it executable.

2. Edit lines bellow, log in to user account and run.

```
tee -a ~/.bash_profile <<EOF
# Configure HTTP proxy
export PROXY_SERVER=10.10.10.12
export PROXY_PORT=15688

. /usr/local/bin/configure-proxy.sh
EOF
```

3. On next login script will set SOCKS proxy for you. 
Also you can call `proxy_off` func to disable proxy settings.


### Author

Eugene Zyatev (eu@zyatev.ru)