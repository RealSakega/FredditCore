websites_dir=/var/www

rsync-excludes = --exclude=*.sh --exclude=.gitignore

update:
	@echo "Updating website..."
	git pull
	rsync -av --delete $(rsync-excludes) freddit.com/* $(websites_dir)/freddit.com/

