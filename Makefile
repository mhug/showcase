INPUT_DIR := input
OUTPUT_DIR := output

XSL := wrapper.xsl

XSL_DEPS := $(wildcard *.xsl)
XML_FILES = $(shell find -L $(INPUT_DIR) -type f -name '*.xml' ! -name '__cts__.xml' ! -name '*.odd.xml' ! -path '* *')
HTML_FILES = $(patsubst $(INPUT_DIR)/%.xml,$(OUTPUT_DIR)/%.html,$(XML_FILES))

COLLECTIONS := $(shell find -L $(INPUT_DIR) -mindepth 1 -maxdepth 1 \( -type d -o -type l \) | xargs -I{} basename {})

# metadata indexes as JSON
COLLECTION_INDEXES := $(patsubst %,$(OUTPUT_DIR)/%/index.json,$(COLLECTIONS))

# metadata indexes in HTML
COLLECTION_HTML_INDEXES := $(patsubst %,$(OUTPUT_DIR)/%/index.html,$(COLLECTIONS))

SOURCES_MK := sources.mk
$(if $(wildcard $(SOURCES_MK)),,$(error file '$(SOURCES_MK)' not found. Please create (template: sources.mk.example)))
include $(SOURCES_MK)

all: input sync $(HTML_FILES) index
html: $(HTML_FILES)
index: $(COLLECTION_INDEXES) $(COLLECTION_HTML_INDEXES)

input:
	mkdir -p input

#$(OUTPUT_DIR)/%.html: $(INPUT_DIR)/%.xml $(XSL_DEPS)
#	@mkdir -p "$(dir $@)"
#	xsltproc -o "$@" "$(XSL)" "$<"

HEADERS_DIR := $(abspath headers)

$(OUTPUT_DIR)/%.html: $(INPUT_DIR)/%.xml $(XSL_DEPS) $(wildcard headers/*.xml)
	@mkdir -p "$(dir $@)"
	xsltproc \
	  --stringparam dirname "$(word 1, $(subst /, ,$(patsubst $(INPUT_DIR)/%,%,$<)))" \
	  --stringparam headers-dir "$(HEADERS_DIR)" \
	  -o "$@" "$(XSL)" "$<"

$(OUTPUT_DIR)/%/index.json: index.xsl | $(OUTPUT_DIR)
	@echo "Generating JSON index for $*..."
	@mkdir -p $(OUTPUT_DIR)/$*
	find -L $(INPUT_DIR)/$* -type f -name '*.xml' ! -name '__cts__.xml' ! -name '*.odd.xml' ! -path '* *' | \
	while read f; do \
		echo "  processing $$f" >&2; \
	    b=$$(basename "$$f" .xml); \
	    xsltproc --stringparam filename "$$b" --stringparam dirname "$*" index.xsl "$$f"; \
	done | \
	jq -c -R -s --argjson columns '$($*.columns)' \
		'sub("\n$$";"") | split("\n") | map(select(length > 0)) | { "columns": $$columns, "data": map(split("\t")) }' > $@

$(OUTPUT_DIR)/%/index.html: index-wrapper.xsl $(XSL_DEPS) $(wildcard headers/*.xml) index-dummy.xml
	@echo "Generating HTML index for $*..."
	@mkdir -p $(OUTPUT_DIR)/$*
	xsltproc \
	  --stringparam dirname "$*" \
	  --stringparam headers-dir "$(HEADERS_DIR)" \
	  -o "$@" index-wrapper.xsl index-dummy.xml

clean:
	rm -rf $(OUTPUT_DIR)
	rm $(INPUT_DIR)/*

.PHONY: all html sync input clean index
sync: $(SYNC_TARGETS)

.PHONY: publish
publish:
	rsync -az --info=progress2 output/ kaskade:/var/www/teikiss/html
	ssh kaskade 'cd /var/www/teikiss && git pull'