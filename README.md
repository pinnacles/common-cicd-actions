# common-cicd-actions

common-cicd-actions provides reusable workflows for CI/CD that has Makefile interfaces.

features:
- call make init, lint, test, build and post-process in CI
- parallel testing in CI
- AWS OIDC authentication in CD
- build docker image and push image to Amazon ECR in CD

## add Makefile to your repo

add Makefile included specified targets:

- lint (used in CI only)
- test (used in CI only)
- build
- post-process

## CI example

```yaml
# .github/workflows/ci.yml
name: CI

on:
  pull_request:
    branches:
      - "*"

jobs:
  workflow:
    uses: pinnacles/common-cicd-actions/.github/workflows/ci.yml@v0.1.0
    with:
      use_ruby: true
      ruby_version: 3.1.0
      use_node: true
      node_version: 17.4.0
      node_package_manager: "yarn"
      use_go: false
      go_version: ""
      test_in_parallel: true
```

## CD example

```yaml
# .github/workflows/cd.yml
name: CD

on:
  pull_request:
    branches:
      - "main"

jobs:
  workflow:
    uses: pinnacles/common-cicd-actions/.github/workflows/cd.yml@v0.1.0
    with:
      use_ruby: true
      ruby_version: 3.1.0
      use_node: true
      node_version: 17.4.0
      node_package_manager: "yarn"
      use_go: false
      go_version: ""
    secrets:
      aws_region: ${{ secrets.AWS_REGION }}
      aws_iam_role: ${{ secrets.AWS_IAM_ROLE }}
      aws_ecr_repository: ${{ secrets.AWS_ECR_REPOSITORY }}
```

## How do I recognize the calling context (CI or CD) in Makefile?

`ACTION_TYPE` environement variable will be set by GitHub Actions.

ACTION_TYPE:
- `CI`
- `CD`

## parallel test using mtsmfm/split-test

You can test in parallel to set `test_in_parallel` true, and modify `test` target to your Makefile like following:

```
.PHONY: test
test:
	RAILS_ENV=test bundle exec rspec \
		--format progress \
		--format RspecJunitFormatter \
		--out ${JUNIT_REPORT_DIR_NEW}/rspec-${NODE_INDEX}.xml \
		$(./split-test --junit-xml-report-dir ${JUNIT_REPORT_DIR_OLD} --node-index ${NODE_INDEX} --node-total ${NODE_COUNT} --tests-glob 'spec/**/*_spec.rb' --debug)
```

`JUNIT_REPORT_DIR_NEW`, `JUNIT_REPORT_DIR_OLD`, `NODE_INDEX` and `NODE_COUNT` environment variables will be set by GitHub Actions.

see also: https://github.com/mtsmfm/split-test
