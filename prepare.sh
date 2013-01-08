#!/usr/bin/env bash
set -e

mv sub sb

NAME="$1"
if [ -z "$NAME" ]; then
  echo "usage: prepare.sh NAME_OF_YOUR_SUB" >&2
  exit 1
fi

SUBNAME=$(echo $NAME | tr '[A-Z]' '[a-z]')
ENVNAME="$(echo $NAME | tr '[a-z-]' '[A-Z_]')_ROOT"

echo "Preparing your '$SUBNAME' sub!"

if [ "$NAME" != "sub" ]; then
  rm sb/bin/sub
  mv sb/share/sub sb/share/$SUBNAME

  for file in *sb/*/sub*; do
    sed "s/sub/$SUBNAME/g;s/SUB_ROOT/$ENVNAME/g" "$file" > $(echo $file | sed "s/sub/$SUBNAME/")
    rm $file
  done
exit
  for file in sb/libexec/*; do
    chmod a+x $file
  done

  ln -s sb/../libexec/$SUBNAME sb/bin/$SUBNAME
fi

rm sb/README.md
rm sb/prepare.sh

mv sb sub

echo "Done! Enjoy your new sub! If you're happy with your sub, run:"
echo
echo "    rm -rf .git"
echo "    git init"
echo "    git add ."
echo "    git commit -m 'Starting off $SUBNAME'"
echo "    ./bin/$SUBNAME init"
echo
echo "Made a mistake? Want to make a different sub? Run:"
echo
echo "    git add ."
echo "    git checkout -f"
echo
echo "Thanks for making a sub!"
