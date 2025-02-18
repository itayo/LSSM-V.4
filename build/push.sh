# Get amount of changed files and the branch we're working on
CHANGED_FILES=$(git status -s | wc -l)
BRANCH=$(git branch --show-current)
# if more than one file modified or we're on master -> Pushback
if [ "$CHANGED_FILES" -gt 1 ] || [ "$BRANCH" = "master" ]
then
  # Get current Build Version
  PACKAGE_VERSION=$(grep '"version":' "$WORK_DIR"/package.json | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[:space:]')
  echo "Pushback Version $PACKAGE_VERSION on $BRANCH"
  # Prepare SSH-Connection to Github
  ssh -o StrictHostKeyChecking=no -T $GIT_URL
  # Set Origin URL
  git remote set-url origin $GIT_URL:$GIT_PROJECT
  # Prepare and push a new commit
  git config user.email "$GIT_MAIL"
  git config user.name "$GIT_USERNAME"
  # Add new yarn releases, generated after auto-updates
  git add .yarn/releases/yarn-*.cjs
  git commit -am "📦 Version $PACKAGE_VERSION [tc-push]"
  git push
fi
