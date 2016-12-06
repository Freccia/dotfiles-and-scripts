find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
# find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;
