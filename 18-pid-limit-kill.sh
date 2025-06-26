#!/bin/bash

set -euo pipefail

# === Configuration ===
PROCESS_NAME="my_process"
MAX_MEMORY_KB=1000000  # 1 GB in kilobytes
LOG_FILE="/var/log/process_monitor.log"

# === Functions ===
log() {
    echo "[$(date +'%F %T')] $1" | tee -a "$LOG_FILE"
}

monitor_process() {
    local pids
    pids=$(pgrep "$PROCESS_NAME" || true)

    if [[ -z "$pids" ]]; then
        log "No running process found for '$PROCESS_NAME'."
        return
    fi

    for pid in $pids; do
        mem_usage_kb=$(ps -p "$pid" -o rss= | tr -d ' ')
        if [[ "$mem_usage_kb" -gt "$MAX_MEMORY_KB" ]]; then
            log "⚠️ Process $PROCESS_NAME (PID: $pid) using ${mem_usage_kb}KB > ${MAX_MEMORY_KB}KB. Killing..."
            kill -9 "$pid" && log "✅ Killed process $pid due to high memory usage."
        else
            log "✔️ Process $PROCESS_NAME (PID: $pid) is within memory limits (${mem_usage_kb}KB)."
        fi
    done
}

# === Main ===
monitor_process
