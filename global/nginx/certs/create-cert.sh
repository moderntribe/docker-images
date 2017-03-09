#!/bin/bash


CERTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DOMAIN=$1

if [ $# -lt 1 ]; then
  echo 1>&2 "Usage: $0 domain.name"
  exit 2
fi

cd ${CERTDIR}

cat > ${DOMAIN}.cnf <<-EOF
  [req]
  distinguished_name = req_distinguished_name
  x509_extensions = v3_req
  prompt = no
  [req_distinguished_name]
  CN = *.${DOMAIN}
  [v3_req]
  keyUsage = keyEncipherment, dataEncipherment
  extendedKeyUsage = serverAuth
  subjectAltName = @alt_names
  [alt_names]
  DNS.1 = *.${DOMAIN}
  DNS.2 = ${DOMAIN}
EOF

openssl req \
  -new \
  -newkey rsa:2048 \
  -sha1 \
  -days 3650 \
  -nodes \
  -x509 \
  -keyout ${DOMAIN}.key \
  -out ${DOMAIN}.crt \
  -config ${DOMAIN}.cnf

rm ${DOMAIN}.cnf

if [[ $OSTYPE == darwin* ]]; then
  sudo security add-trusted-cert -d -r trustRoot -k $HOME/Library/Keychains/login.keychain ${DOMAIN}.crt
fi