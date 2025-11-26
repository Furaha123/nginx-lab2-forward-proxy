#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

PROXY_HOST="127.0.0.1"
PROXY_PORT="8888"

echo "========================================="
echo "   Forward Proxy Testing Script"
echo "========================================="
echo ""

# Test 1: Example.com
echo -e "${YELLOW}Test 1: Fetching example.com${NC}"
echo "Command: curl -x http://${PROXY_HOST}:${PROXY_PORT} http://example.com"
response=$(curl -s -o /dev/null -w "%{http_code}" -x http://${PROXY_HOST}:${PROXY_PORT} http://example.com)
if [ "$response" = "200" ]; then
    echo -e "${GREEN}✓ Success - Status Code: $response${NC}"
else
    echo -e "${RED}✗ Failed - Status Code: $response${NC}"
fi
echo ""

# Test 2: httpbin.org IP check
echo -e "${YELLOW}Test 2: Checking IP via httpbin.org${NC}"
echo "Command: curl -x http://${PROXY_HOST}:${PROXY_PORT} http://httpbin.org/ip"
curl -x http://${PROXY_HOST}:${PROXY_PORT} http://httpbin.org/ip
echo ""

# Test 3: Google.com HEAD request
echo -e "${YELLOW}Test 3: HEAD request to Google${NC}"
echo "Command: curl -I -x http://${PROXY_HOST}:${PROXY_PORT} http://www.google.com"
response=$(curl -s -o /dev/null -w "%{http_code}" -I -x http://${PROXY_HOST}:${PROXY_PORT} http://www.google.com)
if [ "$response" = "200" ]; then
    echo -e "${GREEN}✓ Success - Status Code: $response${NC}"
else
    echo -e "${RED}✗ Failed - Status Code: $response${NC}"
fi
echo ""

# Test 4: icanhazip.com
echo -e "${YELLOW}Test 4: Getting public IP${NC}"
echo "Command: curl -x http://${PROXY_HOST}:${PROXY_PORT} http://icanhazip.com"
curl -x http://${PROXY_HOST}:${PROXY_PORT} http://icanhazip.com
echo ""

# Test 5: Verbose test
echo -e "${YELLOW}Test 5: Verbose connection test${NC}"
echo "Command: curl -v -x http://${PROXY_HOST}:${PROXY_PORT} http://example.com"
curl -v -x http://${PROXY_HOST}:${PROXY_PORT} http://example.com 2>&1 | head -20
echo ""

echo "========================================="
echo "   Testing Complete"
echo "========================================="
