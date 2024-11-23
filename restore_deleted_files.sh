#!/bin/bash

# List of deleted files
FILES=(
  "guitar/repertoire/one string off standard/eadabe/jose-gonzales-horizons.txt"
  "guitar/repertoire/one string off standard/eadabe/jose-gonzales-the-void.txt"
  "originals/finished (or close)/birdsong.txt"
  "originals/lollypop man.txt"
  "guitar/new/beatles_Here_Comes_The_Sun_fingerstyle.pdf"
  "guitar/incomplete tabs/feist-redwing.txt"
  "guitar/bibio-valley-wulf.txt"
  "guitar/kings-of-convience-rocky-trail.txt"
  "guitar/Claude Debussy - Clair de Lune Tab.pdf"
  "guitar/Daniel Rossen - Shadow in the Frame.png"
  "guitar/LIOR SULITHA tab neil kelly.pdf"
  "guitar/beatles - blackbird.pdf"
  "guitar/bibio - valley wulf.pdf"
  "guitar/daniel-rossen-untitled.txt"
  "gustavo-santaolalla-alma-ronroco-a.txt"
)

# Loop through each file and restore
for FILE in "${FILES[@]}"; do
  # Find the commit where the file was deleted
  COMMIT_HASH=$(git log --diff-filter=D --summary -- "$FILE" | grep -m 1 "commit" | awk '{print $2}')
  
  # Check if the file and commit hash exist
  if [ -n "$COMMIT_HASH" ]; then
    echo "Restoring $FILE from commit $COMMIT_HASH"
    git checkout "${COMMIT_HASH}^" -- "$FILE"
  else
    echo "Could not find deletion commit for $FILE"
  fi
done

# Stage all restored files
echo "Staging restored files..."
git add .

# Commit the restored files
echo "Creating commit for restored files..."
git commit -m "Restore accidentally deleted files"

echo "Restoration complete!"
