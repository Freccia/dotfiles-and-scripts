#!/bin/sh

git filter-branch --env-filter '

CORRECT_NAME="Freccia"
CORRECT_EMAIL="Freccia@users.noreply.github.com"

if [ "$GIT_COMMITTER_EMAIL" != "$CORRECT_EMAIL" ]
then
	export GIT_COMMITTER_NAME="$CORRECT_NAME"
	export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" != "$CORRECT_EMAIL" ]
then
	export GIT_AUTHOR_NAME="$CORRECT_NAME"
	export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
