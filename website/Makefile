websites_dir=/var/www

rsync-excludes = --exclude=*.sh --exclude=.gitignore

update:
	@echo "Updating website..."
	git pull
	rsync -av --delete $(rsync-excludes) freddit.net/* $(websites_dir)/freddit.net/

