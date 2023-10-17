.PHONY: backup

backup:
ifeq ($(server_name),)
	$(error server_name is not set)
else
	bash ${FREDDITCORE_DIR}/scripts/BACKUP.sh ${FREDDITCORE_DIR}/minecraft/backups/BackupList_${server_name}.txt ${FREDDITCORE_DIR}/minecraft/backups/${server_name}
endif