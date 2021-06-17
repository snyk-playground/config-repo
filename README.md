Ensure that Snyk is configured properly and collecting information on Snyk Playground properly
# config-repo
This project is a collection of workflows to automate the Snyk platform for different use cases.

## Automated Snyk Project Imports (SCM Integration)
These workflows will detect and import any new repositories into Snyk that are created in the same Github org where this lives.

| workflow | Description |
| --- | ----------- |
| [create-import-data.yml](https://github.com/snyk-playground/config-repo/tree/main/.github/workflows/create-import-data.yml) | generate an import file on a new branch for snyk-api-import to consume and raise a pull request |
| [perform-import.yml](https://github.com/snyk-playground/config-repo/tree/main/.github/workflows/perform-import.yml) | import all repositories from the import file into Snyk (skipping previously seen ones) upon merge of the pull request |
