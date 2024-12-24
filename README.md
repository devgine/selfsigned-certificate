# Self-signed certificate

## About
This a docker image useful to generate self-signed certificates<br>
This library is based on [minica](https://github.com/jsha/minica)<br>


[View available packages](https://github.com/devgine/selfsigned-certificate/pkgs/container/selfsigned-certificate)
Below is the list of docker images available by PHP versions:

| **Docker image tags**                         |
|-----------------------------------------------|
| ghcr.io/devgine/selfsigned-certificate:latest |
| ghcr.io/devgine/selfsigned-certificate:1.0.0  |

## How to use
This image will create the certificates in the directory `/certs`, so to have these certificate in you host machine you need to bind a volume between your target directory and the container directory `/certs`.


### Generate a certificate
#### For a specific domain or wildcard
> To generate a certificate for a host domain or a wildcard, use the `-d` option
```shell
docker run --rm -v HOST_DIRECTORY:/certs ghcr.io/devgine/selfsigned-certificate:1.0.0 -d WWW.YOUR-DOMAIN.COM
```

```shell
docker run --rm -v HOST_DIRECTORY:/certs ghcr.io/devgine/selfsigned-certificate:1.0.0 -d *.YOUR-DOMAIN.COM
```

#### For an ip address
/!\ EXPERIMENTAL : This feature is not available yet /!\
> To generate a certificate for an ip address, use the `-i` option
```shell
docker run --rm -v HOST_DIRECTORY:/certs ghcr.io/devgine/selfsigned-certificate:1.0.0 -i IP_ADDRESS
```

#### Generate multiple certificates
It's also possible to generate multiple certificates in one shot
```shell
docker run --rm -v HOST_DIRECTORY:/certs ghcr.io/devgine/selfsigned-certificate:1.0.0 \
  -d WWW.YOUR-DOMAIN.COM \
  -d *.WILDCARD.COM \
  -i IP_ADDRESS
```

### Available options
/!\ EXPERIMENTAL : This feature is not available yet /!\

| Option   | Type   | Default        | Description                             |
|----------|--------|----------------|-----------------------------------------|
| -ca-cert | string | minica.pem     | Root certificate filename, PEM encoded. |
| -ca-key  | string | minica-key.pem | Root private key filename, PEM encoded. |


### Checking for certificates
```shell
openssl x509 -in PATH_TO_YOUR_CERTIFICATE -text -noout
```

## References
* [minica](https://github.com/jsha/minica)
* [check certificate openssl](https://linuxhandbook.com/check-certificate-openssl/)
