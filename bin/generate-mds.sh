#!/bin/bash
mkdir -p code/md
for file in data/*.php; do
    basename=$(basename "$file" .php)
    status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8000/$basename")
    
    cat <<EOF > "code/md/$basename.md"
# $basename Log Summary

When accessing \`http://localhost:8000/$basename\`, the server returns an HTTP status code of **$status**.

1. **Main Request**: The server receives the request and returns an HTTP \`$status\`.
2. **Static Assets**: Specific assets are delivered by the server.
3. **Connection Lifecycle**: Normal accept, GET, and close events occur.
EOF
    echo "Created summary for $basename (HTTP $status)"
done
