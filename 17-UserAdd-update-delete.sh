#!/bin/bash
#!/bin/bash

set -euo pipefail

LOG_FILE="/var/log/user_mgmt_script.log"
ACTION="${1:-}"
USERNAME="${2:-}"

# Create log file if it doesn't exist
touch "$LOG_FILE" 2>/dev/null || { echo "ERROR: Cannot write to $LOG_FILE. Use sudo or choose another location."; exit 1; }

# Logging function
log() {
    echo "[$(date +'%F %T')] $1" | tee -a "$LOG_FILE"
}

# Usage function
usage() {
    echo "Usage: $0 {add|modify|delete} username"
    exit 1
}

# Input validation
if [[ -z "$ACTION" || -z "$USERNAME" ]]; then
    usage
fi

# Main logic
case "$ACTION" in
    add)
        if id "$USERNAME" &>/dev/null; then
            log "User '$USERNAME' already exists. Skipping add."
        else
            if useradd -m -s /bin/bash "$USERNAME"; then
                log "User '$USERNAME' added successfully."
            else
                log "Failed to add user '$USERNAME'."
                exit 1
            fi
        fi
        ;;
    modify)
        if id "$USERNAME" &>/dev/null; then
            if usermod -s /bin/bash "$USERNAME"; then
                log "Shell for user '$USERNAME' changed to /bin/bash."
            else
                log "Failed to modify user '$USERNAME'."
                exit 1
            fi
        else
            log "User '$USERNAME' does not exist. Cannot modify."
            exit 1
        fi
        ;;
    delete)
        if id "$USERNAME" &>/dev/null; then
            if userdel -r "$USERNAME"; then
                log "User '$USERNAME' deleted successfully."
            else
                log "Failed to delete user '$USERNAME'."
                exit 1
            fi
        else
            log "User '$USERNAME' does not exist. Cannot delete."
            exit 1
        fi
        ;;
    *)
        usage
        ;;
esac

