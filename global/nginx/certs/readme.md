From https://gist.github.com/jed/6147872
Run in this `certs` directory

```bash
cat > YOUR.DOMAIN.cnf <<-EOF
  [req]
  distinguished_name = req_distinguished_name
  x509_extensions = v3_req
  prompt = no
  [req_distinguished_name]
  CN = *.YOUR.DOMAIN
  [v3_req]
  keyUsage = keyEncipherment, dataEncipherment
  extendedKeyUsage = serverAuth
  subjectAltName = @alt_names
  [alt_names]
  DNS.1 = *.YOUR.DOMAIN
  DNS.2 = YOUR.DOMAIN
EOF

openssl req \
  -new \
  -newkey rsa:2048 \
  -sha1 \
  -days 3650 \
  -nodes \
  -x509 \
  -keyout YOUR.DOMAIN.key \
  -out YOUR.DOMAIN.crt \
  -config YOUR.DOMAIN.cnf

rm YOUR.DOMAIN.cnf
```