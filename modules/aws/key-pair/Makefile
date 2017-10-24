SHELL := /bin/bash

FILES ?= $(shell find . -type f -name '*.sh')

.SUFFIXES:

.PHONY: help test static

all: static

help:
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@echo '    help               Show this help screen.'
	@echo '    test               Run unit tests.'
	@echo '    static             Run shellcheck.'
	@echo ''
	@echo 'Target run by default is static.'
	@echo ''

print-%:
	@echo $* = $($*)

test:
	@$(MAKE) -C ./test all

static:
	$(eval QUIET := $(shell test "$(MAKECMDGOALS)" == "static" || echo 1))
	@shellcheck -s bash $(FILES) $(shell test -z "$(QUIET)" || echo '&>/dev/null'); \
	if (( $$? > 0 )); then \
		if [[ -n "$(QUIET)" ]]; then \
			echo "shellcheck found number of issues. Run 'make static' to check directly."; \
		else \
			exit $$?; \
		fi; \
	fi
