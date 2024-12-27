#!/bin/bash
# This script is used to generate a private key, a CA, a CSR, and a CRT for the webhook service.
openssl genpkey -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out test/operator.key
openssl req -new -nodes -key test/operator.key -config csrconfig.txt -nameopt utf8 -utf8 -out test/operator.csr
openssl x509 -req -sha256 -days 10000 -in test/operator.csr -signkey test/operator.key -out test/operator.crt -copy_extensions=copyall
echo <-DOC
Run:
$> cat test/operator.csr | base64 | tr -d '\n' | pbcopy
Paste into certs.yaml in the request field.
Copy the test/operator.key and test/operator.crt into certs.yaml tls.key and tls.cert fields of the configmap.
Run:
$> cat test/operator.crt | base64 | tr -d '\n' | pbcopy
Paste into operator.yaml under caBundle field.
DOC