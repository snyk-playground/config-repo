### tl,dr; Api Import

API import takes a json file 

1) Generate a sync file, that contains the mapping of OrgID in snyk to github/github enterprise Org name
- this also includes the intergration ID's in that org (snykctl api org/ie-playground/integrations | jq)
- in this setup we are using the github as github enterprise configuration option, where you put `https://api.github.com` as the API endpoint

2) create the import template - this is the list of repos to be imported, but we don't actually run this yet 