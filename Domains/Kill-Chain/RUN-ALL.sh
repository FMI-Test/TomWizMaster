#!/bin/bash
# Kill-Chain/RUN-ALL.sh
# EXECUTION PROTOCOL

LOG_FILE="Kill-Chain/LOG.txt"
INVENTORY="Kill-Chain/INVENTORY.md"

echo "Running Kill Chain Execution Protocol..." | tee -a "$LOG_FILE"
date | tee -a "$LOG_FILE"

# Ensure executable permissions
echo "Setting executable permissions..." | tee -a "$LOG_FILE"
chmod +x code/sh/*.sh
chmod +x code/python/*.py

while IFS= read -r script; do
    # Skip empty lines
    [[ -z "$script" ]] && continue
    
    echo "--------------------------------------------------" | tee -a "$LOG_FILE"
    echo "EXECUTING: $script" | tee -a "$LOG_FILE"
    
    # Check extension
    if [[ "$script" == *.sh ]]; then
        bash "$script" 2>&1 | tee -a "$LOG_FILE"
    elif [[ "$script" == *.py ]]; then
        python3 "$script" 2>&1 | tee -a "$LOG_FILE"
    else
        echo "Unknown file type: $script" | tee -a "$LOG_FILE"
    fi
    
    EXIT_CODE=$?
    echo "EXIT CODE: $EXIT_CODE" | tee -a "$LOG_FILE"
    
    if [ $EXIT_CODE -eq 0 ]; then
        echo "STATUS: SUCCESS" | tee -a "$LOG_FILE"
    else
        echo "STATUS: FAILED" | tee -a "$LOG_FILE"
    fi
    
    # Wait/Sleep if needed (e.g., 2 seconds)
    sleep 2

done < "$INVENTORY"

echo "Kill Chain Execution Complete." | tee -a "$LOG_FILE"
