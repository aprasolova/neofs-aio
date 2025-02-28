#!/usr/bin/env bash

# NeoGo binary path.
NEOGO="${NEOGO:-docker exec -it morph neo-go}"
# NNS contract script hash
NNS_ADDR=`curl -s --data '{ "id": 1, "jsonrpc": "2.0", "method": "getcontractstate", "params": [1] }' http://localhost:30333/ | jq -r '.result.hash'`

${NEOGO} contract testinvokefunction \
-r http://localhost:30333 \
${NNS_ADDR} resolve string:${1} int:16 | jq -r '.stack[0].value' | base64 -d
