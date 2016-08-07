#!/usr/bin/env bash
# setup-repo.sh
# Used to configure a repo for formatting, and adds a precommit hook to check formatting.
# Copyright 2015 Square, Inc

set -ex
export CDPATH=""
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pre_commit_file='.git/hooks/pre-commit';

pre_commit_bind_file='.git/hooks/pre-commit.bind';
function ensure_pre_commit_file_exists() {
  if [ -e "$pre_commit_file" ]; then
          mv "$pre_commit_file" "$pre_commit_bind_file"
  fi 
  if [ -h "$pre_commit_file" ]; then
          mv "$pre_commit_file" "$pre_commit_bind_file"
  fi 

  if [ -d ".git" ]; then
    $(mkdir -p ".git/hooks");
  elif [ -e ".git" ]; then

    git_dir=$(grep gitdir .git | cut -d ' ' -f 2)
    pre_commit_file="$git_dir/hooks/pre-commit"
  else
    $(mkdir -p ".git/hooks");
  fi

  $(touch $pre_commit_file)
}

function ensure_pre_commit_file_is_executable() {
  $(chmod +x "$pre_commit_file")
}

function ensure_hook_is_installed() {
  # check if this repo is referenced in the precommit hook already
  repo_path=$(git rev-parse --show-toplevel)
  if ! grep -q "$repo_path" "$pre_commit_file"; then
    echo "#!/usr/bin/env bash" >> $pre_commit_file
    echo "current_repo_path=\$(git rev-parse --show-toplevel)" >> $pre_commit_file
    echo "repo_to_format=\"$repo_path\"" >> $pre_commit_file
    echo 'if [ "$current_repo_path" == "$repo_to_format" ]'" && [ -e \"$DIR\"/format-objc-hook ]; then \"$DIR\"/format-objc-hook || exit 1; fi" >> $pre_commit_file
  fi
}

function ensure_git_ignores_clang_format_file() {

  grep -q ".clang-format" ".gitignore" &&  echo "" || echo ".clang-format" >> ".gitignore" 
}
function ensure_git_ignores_spacecommander_file() {

  grep -q "spacecommander" ".gitignore" &&  echo "" || echo "spacecommander" >> ".gitignore" 
}

function symlink_clang_format() {
  $(ln -sf "$DIR/.clang-format" ".clang-format")
}

function copy_hooks() {
  $(cp -rf "$DIR/hooks/" ".git/hooks/" )
}

ensure_pre_commit_file_exists && ensure_pre_commit_file_is_executable && ensure_hook_is_installed && ensure_git_ignores_clang_format_file && symlink_clang_format && ensure_git_ignores_spacecommander_file #&& copy_hooks

