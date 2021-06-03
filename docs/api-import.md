### tl,dr; Api Import

1) Generate a sync file, that contains the mapping of OrgID in snyk to github/github enterprise Org name
- this also includes the intergration ID's in that org (snykctl api org/ie-playground/integrations | jq)

2) in this setup we are using the github as github enterprise configuration option, where you put `https://api.github.com` as the API endpoint