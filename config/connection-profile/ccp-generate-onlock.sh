#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ccp-template-onlock.json
}


ORG=1
P0PORT=30110
CAPORT=30054
PEERPEM=../crypto-config/peerOrganizations/org1.vault.com/tlsca/tlsca.org1.vault.com-cert.pem
CAPEM=../crypto-config/peerOrganizations/org1.vault.com/ca/ca.org1.vault.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org1.json