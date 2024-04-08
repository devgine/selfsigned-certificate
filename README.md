# Self-signed certificate

https://github.com/jsha/minica


domain

wildcard

multiple certificates
docker run --rm --name ca-test -ti -v $PWD/certs:/certs ca -d WWW.DOMAIN.COM -d

