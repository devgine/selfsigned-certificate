#!/bin/sh

set -eu -o pipefail

# if the first argument is not an option so exec the command
if [ "${1#-}" = "$1" ]; then
	exec "$@"
fi

# ======================================================================================================================
# Global variables
# ======================================================================================================================

COLOR_RESET='\033[0m'
COLOR_GREEN='\033[0;32m'

CERTS_DIR=/certs

# ======================================================================================================================
# Help
# ======================================================================================================================
Help()
{
  echo "Script to generate self-signed certificate based on minica library."
  echo
  echo "Syntax: docker-certs [-d|h|V]"
  echo "options:"
  echo "d     The domain or wildcard."
  echo "h     Print this Help."
  echo "V     Print software version and exit."
  echo
  echo -e "${COLOR_GREEN}Example : docker run --rm -v /certs:/certs selfsigned-certificate -d sub.domain.one -d \"*.domain.two\"${COLOR_RESET}"
  echo
}

Cert()
{
  domain="$1"

  if [ -d "${CERTS_DIR}" ]; then
    GENERATION_DIRNAME="${CERTS_DIR}/$(echo "$domain" | cut -d, -f1 | sed -e 's/*/_/g')"

    if [ ! -d "${GENERATION_DIRNAME}" ]; then
      echo ":: Generating Certificates for the following domain: $domain ::"
      mkdir -p "${GENERATION_DIRNAME}"
      cd "${CERTS_DIR}"
      minica --ca-cert "$CERTS_DIR/minica.pem" --ca-key="$CERTS_DIR/minica-key.pem" --domains="$domain"

      cat "${GENERATION_DIRNAME}/key.pem" "${GENERATION_DIRNAME}/cert.pem" > "${GENERATION_DIRNAME}/ck.pem"

      echo ":: Certificates Generated in the directory ${GENERATION_DIRNAME} ::"
    fi
  fi
}

while getopts ":hVd:" option; do
  case $option in
    h)
      Help
      exit 0;;
    V)
      echo 'v1.0.0'
      exit 0;;
    d)
      Cert "$OPTARG";;
    \?) # Invalid option
      echo "Error: Invalid option"
  esac
done

# todo: add ip address option -i
