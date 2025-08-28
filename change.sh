allowed_dirs=(
  "$HOME/Coding"
  "$HOME/.config"
  "$HOME/notes-and-guides"
)

for dir in "${allowed_dirs[@]}"; do
  find "$dir" -type d -name ".git" -print
done | while read -r gitdir; do
  repo=$(dirname "$gitdir")
  if [ -n "$(git -C "$repo" status --porcelain)" ]; then
    echo "$repo has uncommitted changes"
  fi
done

