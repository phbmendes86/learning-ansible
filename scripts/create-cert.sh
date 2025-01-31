#!/bin/bash

#the C locale only conducts a simple bytewise comparison,
#so it will also perform better than the others.
export LANG=C

# Set the name of the local user that will have the key mapped to
USERNAME="vagrant"

#create openssl.conf
cat >openssl.conf <<EOL
distinguished_name = req_distinguished_name
[req_distinguished_name]
[v3_req_client]
extendedKeyUsage = clientAuth
subjectAltName = otherName:1.3.6.1.4.1.311.20.2.3;UTF8:$USERNAME@localhost
EOL

#generate and key
export OPENSSL_CONF=openssl.conf
openssl req -x509 \
    -nodes -days 3650 \
    -newkey rsa:2048 \
    -out cert.pem \
    -outform PEM \
    -keyout cert_key.pem \
    -subj "/CN=$USERNAME" \
    -extensions v3_req_client

#remove openssl.conf
rm openssl.conf
