#!/bin/bash
# This script is used to generate a private key, a CA, a CSR, and a CRT for the webhook service.
openssl genpkey -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out certs/operator.key
openssl req -new -nodes -key certs/operator.key -config certs/csrconfig.txt -nameopt utf8 -utf8 -out certs/operator.csr
openssl x509 -req -sha256 -days 10000 -in certs/operator.csr -signkey certs/operator.key -out certs/operator.crt -copy_extensions=copyall
echo <<"DOC"
Run:
$> cat certs/operator.csr | base64 | tr -d '\n' | pbcopy
Paste into certs.yaml in the request field.
Copy the certs/operator.key and certs/operator.crt into certs.yaml tls.key and tls.cert fields of the configmap.
Run:
$> cat certs/operator.crt | base64 | tr -d '\n' | pbcopy
Paste into operator.yaml under caBundle field.
DOC