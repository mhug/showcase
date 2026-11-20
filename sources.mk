# list all targets here
SYNC_TARGETS := showcase.sync

# EHD: edition humboldt digital
#
# These texts are within a git checkout in ~/src/edition-humboldt-digital.
# 
# Before building new HTML and index files, do a "git pull" and link the
# XML files in "~/src/edition-humboldt-digital/data" to "input/edition"
showcase.src := ~/Desktop/showcase
showcase.columns := [{"title":"Corpus"},{"title":"Text"},{"title":"XML"},{"title":"Derivates"},{"title":"Tools"}]

showcase.sync:
	$(call check-dir,$(showcase.src))
	$(call check-dir,$(showcase.src)/data)
	ln -sfn $(showcase.src)/data input/showcase

# No need to change this.
define check-dir
@test -d $(1) || { echo "Error: directory $(1) does not exist."; exit 1; }
endef
