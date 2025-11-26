#!/bin/bash

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "========================================="
echo "   Forward Proxy Logs Viewer"
echo "========================================="
echo ""

# Access Log
echo -e "${BLUE}=== Access Log ===${NC}"
echo "Total requests: $(sudo wc -l /var/log/nginx/forward-proxy-access.log | awk '{print $1}')"
echo ""
echo "Recent requests:"
sudo tail -20 /var/log/nginx/forward-proxy-access.log
echo ""

# Error Log
echo -e "${BLUE}=== Error Log ===${NC}"
if [ -s /var/log/nginx/forward-proxy-error.log ]; then
    sudo tail -20 /var/log/nginx/forward-proxy-error.log
else
    echo "No errors logged (Good!)"
fi
echo ""

# Statistics
echo -e "${BLUE}=== Request Statistics ===${NC}"
echo "Requests by Status Code:"
sudo awk '{print $9}' /var/log/nginx/forward-proxy-access.log | sort | uniq -c | sort -rn
echo ""

echo "Top Domains Accessed:"
sudo awk '{print $7}' /var/log/nginx/forward-proxy-access.log | cut -d'/' -f3 | sort | uniq -c | sort -rn
echo ""

echo "========================================="
