#!/usr/bin/env bash

set -Eeuo pipefail

BACKUP_FILE="${1:-}"
BACKUP_TYPE="${2:-}"

if [[ -z "${BACKUP_FILE}" || -z "${BACKUP_TYPE}" ]]; then
    echo "[ERROR] Usage: upload-cloud.sh /path/to/backup.tar.gz weekly|monthly"
    exit 1
fi

###############################################################################
# rclone configuration
###############################################################################

RCLONE_TRANSFERS=4
RCLONE_CHECKERS=8
RCLONE_STATS_INTERVAL="30s"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOMELAB_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

RCLONE_CONFIG_FILE="${HOMELAB_ROOT}/secrets/rclone/rclone.conf"
RCLONE_REMOTE="encrypted:${BACKUP_TYPE}"

LOG_DIR="${HOMELAB_ROOT}/logs/backups"
mkdir -p "${LOG_DIR}"

LOG_FILE="${LOG_DIR}/cloud-upload-${BACKUP_TYPE}-$(date +"%Y-%m-%d_%H-%M-%S").log"

log() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $*" | tee -a "${LOG_FILE}"
}

if [[ ! -f "${BACKUP_FILE}" ]]; then
    log "[ERROR] Backup file not found: ${BACKUP_FILE}"
    exit 1
fi

if [[ ! -f "${RCLONE_CONFIG_FILE}" ]]; then
    log "[ERROR] rclone config not found: ${RCLONE_CONFIG_FILE}"
    exit 1
fi

export RCLONE_CONFIG="${RCLONE_CONFIG_FILE}"

log "Starting cloud upload"
log "Backup file: ${BACKUP_FILE}"
log "Backup type: ${BACKUP_TYPE}"
log "Remote: ${RCLONE_REMOTE}"

###############################################################################
# Display progress differently for interactive runs vs cron
###############################################################################

if [[ -t 1 ]]; then
    PROGRESS="--progress"
else
    PROGRESS="--stats=${RCLONE_STATS_INTERVAL} --stats-one-line"
fi

###############################################################################
# Upload backup
###############################################################################

rclone copy \
    "${BACKUP_FILE}" \
    "${RCLONE_REMOTE}" \
    ${PROGRESS} \
    --checksum \
    --transfers="${RCLONE_TRANSFERS}" \
    --checkers="${RCLONE_CHECKERS}" \
    --log-file="${LOG_FILE}"

log "Verifying cloud upload"

rclone check \
    "$(dirname "${BACKUP_FILE}")" \
    "${RCLONE_REMOTE}" \
    --include "$(basename "${BACKUP_FILE}")" \
    --one-way \
    --log-file="${LOG_FILE}"

log "Cloud upload completed successfully"
