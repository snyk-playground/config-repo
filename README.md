Ensure that Snyk is configured properly and collecting information on Snyk Playground properly
# config-repo
This project is a collection of workflows to automate the Snyk platform for different use cases.

## Automated Snyk Project Imports
These workflows will detect and import any new repositories into Snyk that are created in the same Github org where this lives.

| workflow | Description |
| --- | ----------- |
| [create-import-data.yml](.github/workflows/create-import-data.yaml) | generate an import file for snyk-api-import to consume |
| [perform-import.yml](.github/workflows/perform-import.yaml) | import all repositories from the import file into Snyk (skipping previously seen ones) |
