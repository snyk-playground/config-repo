# Example Snyk Config Repo

This is a repository preconfigured to run the github actions workflows that drive a [Snyk Sync](https://github.com/snyk-playground/snyk-sync) import / synchronization of all the repositories in a given GitHub Organization (cloud or enterprise) into one or more Snyk Organizations.

This repository is an example of how to setup Snyk Sync.

## GitHub and Snyk Configuration

1) Create a GitHub Access Token that contains the needed permissions for Snyk to import and add webhooks to Github repositories

    - `repo (all), admin:read:org, and admin:repo_hooks (read & write)`

    <br>
2) Add a new [GitHub Enterprise integration](https://docs.snyk.io/features/integrations/git-repository-scm-integrations/github-enterprise-integration) to an existing Snyk Organization that is the intended catch all organization.All projects from all repositories will end up in this organization unless otherwise specified via an [import.yaml](https://github.com/snyk-playground/org-project-import/blob/main/.snyk.d/import.yaml) override.

    - **Disable All Disruptive Actions** ensure all options on the GitHub Enterprise Integrations page are disabled, with the exception of "Auto-detect Dockerfiles"
    - use the new GitHub Token you've just created

<br>

3) Create a Snyk [service account](https://docs.snyk.io/features/integrations/managing-integrations/service-accounts#set-up-a-service-account) with Admin permissions. This needs to be Group level because Sync is expected to import repositories across organizations.


## Repo Creation

Create a new repository in Github called config-repo (or snyk-config-repo)

Clone this repository to a local machine, remove the the current origin and *remove the current origin*. The below steps is a quick and dirty way to do this (and to drop all the history from the development of this example repo)
```
git clone https://github.com/snyk-playground/config-repo
cd config-repo
rm -rf .git/*
git init .
git remote add origin git@github.com:my-org/snyk-config-repo.git
git add .
```

## Configuration

Edit snyk-sync.yaml:
1) Replace "snyk-playground" under `github_orgs` with your github organization
2) Replace "36863d40-ba29-491f-af63-7a1a7d79e411" under `snyk:group:` with your Snyk Group ID (it is in your group settings page but also in your group pages: `https://app.snyk.io/group/GROUP-ID/reports/`)
3) Replace "ie-playground" in `default:orgName` with the Snyk shortname (or slug) of the organization you want to have as default. It is the URL of an organization's page in Snyk: `https://app.snyk.io/org/<org slug>`

Edit snyk-orgs.yaml:
1) Remove "cse-ownership" and everything below it
2) Replace "ie-playground" with the slug of the default orgName
3) Replace "39ddc762-b1b9-41ce-ab42-defbe4575bd6" under `orgId` with the ID from the org's settings page: `https://app.snyk.io/org/<org slug>/manage/settings`
4) Replace "b87e1473-37ab-4f09-a4e3-a0139a50e81e" under `github-enterprise` with the ID from Snyk's GitHub Enterprise integration page: `https://app.snyk.io/org/<org slug>/manage/integrations/github-enterprise`

## Test Configuration

In your local environment you can perform a local test and this is reccomended before trying to perform a full import via GitHub Actions.

Set `GITHUB_TOKEN` and `SNYK_TOKEN` as environment variables and run `scripts/test.sh` and the output should look like something below:
```
❯ bash scripts/test.sh
Sync forced, ignoring cache status
Sync starting
Getting all GitHub repos
Processing:   [####################################]  100%
Scanning repos for import.yaml
Scanning:   [####################################]  100%
Scanning Snyk for projects originating from GitHub Repos
Scanning:   [####################################]  100%          
Sync completed
Total Repos: 27
Writing targets to /runtime/import-targets.json
Write Successful
```
If you get `Write Successful`, you've successfully setup the configuration for snyk sync to run. Skip to "Optional: Local Sync" if you want to perform a full local sync.

## Perform a full local sync

Depending on the size of the `import-targets.json` created from the last step, it may take a long time for the import task to complete. If the total number of repos Sync scanned is more than 50, we suggest executing this locally first before having it run as a GitHub Action. To do that, run `bash scripts/full-sync.sh`.

Once it completes, log in to the default Organization and check for projects under the GitHub Enterprise project filter.

```
Sync forced, ignoring cache status
Sync starting
Getting all GitHub repos
Processing:   [####################################]  100%
Scanning repos for import.yaml
Scanning:   [####################################]  100%
Scanning Snyk for projects originating from GitHub Repos
Scanning:   [####################################]  100%          
Sync completed
Total Repos: 27
Writing targets to /runtime/import-targets.json
Write Successful
Loaded 5 target(s) to import | Thu, 14 Oct 2021 19:53:48 GMT
Filtering out previously imported targets, this might be slow | Thu, 14 Oct 2021 19:53:48 GMT
Could not load previously imported targets file: imported-targets.log.
This could be because it doesn't exist or it is malformed. Either way continuing without checking for previously imported targets.
Checking status for import job id: e33e8ffe-4278-4522-8b01-5f4c80e0d07c
Checking status for import job id: 65e2d478-c814-4bc4-8c51-911f349d4ce4
Discovered 0 projects from import job id: 65e2d478-c814-4bc4-8c51-911f349d4ce4
Discovered 0 projects from import job id: e33e8ffe-4278-4522-8b01-5f4c80e0d07c
⚠ No projects imported!
Processed 5 out of a total of 5 targets
Check the logs for any failures located at: cache/log/*
Sync forced, ignoring cache status
Sync starting
Getting all GitHub repos
Processing:   [####################################]  100%
Scanning repos for import.yaml
Scanning:   [####################################]  100%
Scanning Snyk for projects originating from GitHub Repos
Scanning:   [####################################]  100%          
Sync completed
Total Repos: 27
Updating tags for projects
```

## Enable GitHub Actions

1) Following the instructions from GitHub to [add repository secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository), add two encrypted secrets: `SNYK_TOKEN` that you created earlier as a service account and `SNYK_GITHUB_TOKEN` which was the github token you created for the Snyk GitHub Enterprise integration.

2) Commit and push these changes to the main branch of the repository

```
git commit -m "first commit"
git branch -M main
git push -u origin main
```
3) From the "actions" tab of the repository select the "create-import-data" and select the "run workflow" option that appears to the right, choosing "branch:main"
4) Reload the page and a new workflow should appear as running, select the workflow and view the logs, if it completes successfully, you should see that the repository how has a pull request.
5) Merge the pull request labeled Updated Repo List
6) Run a workflow again, this time selecting the "perform-import" workflow. This import may take some time if you did not perform a full sync locally first.
