# centos-ssh-dnsmasq

WIP: Not Ready for General Use.

Local caching DNS that proxies DNSCrypt queries to dnscrypt-proxy.

## DNSCrypt

 - https://dnscrypt.org/
 - https://github.com/jedisct1/dnscrypt-proxy/wiki
 - List of [resolvers](https://github.com/jedisct1/dnscrypt-resolvers/blob/master/v1/dnscrypt-resolvers.csv)
 - Recommended [OSX Client](https://github.com/alterstep/dnscrypt-osxclient)

Note: Requires a loopback alias on 127.0.0.54 which will be provided if installing [dnscrypt-osxclient](https://github.com/alterstep/dnscrypt-osxclient) on OSX - `brew cask install dnscrypt`

## Run Standard DNS

```
$ make install start
```

## Run with dnscrypt-proxy Resolvers

```
$ DNSMASQ_DNSCRYPT_PROXY=true \
  DNSMASQ_RESOLVER_1=dnscrypt.org-fr \
  DNSMASQ_RESOLVER_2=dnscrypt.eu-nl \
  make install start
```

Check the correct IP address is returned for the resolver name `DNSMASQ_RESOLVER_1`.

```
$ dig @127.0.0.54 resolver.dnscrypt.org
```

## TODO

- [ ] Add Docker healthcheck.
- [ ] Add functional tests.
- [ ] Replace WIP README with content for Docker Hub.
