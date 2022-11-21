#!/bin/bash

set -e

if [ -n "${RUBY_VERSION}" ]; then
	which ruby
	INST_RUBY_VER=$(ruby --version | awk '{print $2}' | sed 's/p.*$//')
	echo "${RUBY_VERSION} = ${INST_RUBY_VER}"
	test ${RUBY_VERSION} = ${INST_RUBY_VER}
fi

if [ -n "${NODE_VERSION}" ]; then
	which node
	INST_NODE_VER=$(node --version | sed 's/v//')
	echo "${NODE_VERSION} = ${INST_NODE_VER}"
	test ${NODE_VERSION} = ${INST_NODE_VER}
fi

if [ -n "${GO_VERSION}" ]; then
	which go
	INST_GO_VER=$(go version | awk '{print $3}' | sed 's/go//')
	echo "${GO_VERSION} = ${INST_GO_VER}"
	test ${GO_VERSION} = ${INST_GO_VER}
fi

if [ -n "${IMAGE_TAG}" ]; then
	echo "IMAGE_TAG: ${IMAGE_TAG}"
fi

if [ -n "${NODE_COUNT}" ]; then
	mkdir ${JUNIT_REPORT_DIR_NEW}
	touch ${JUNIT_REPORT_DIR_NEW}/rspec-${NODE_COUNT}.xml
fi

if [ -n "${GITHUB_TOKEN}" ]; then
	test "${GITHUB_TOKEN}" = dummy
fi

if [ -z "${ALL_CHANGED_FILES}" ]; then
	echo "ALL_CHANGED_FILES: ${ALL_CHANGED_FILES}"
	exit 1
else
	echo "ALL_CHANGED_FILES: ${ALL_CHANGED_FILES}"
fi
