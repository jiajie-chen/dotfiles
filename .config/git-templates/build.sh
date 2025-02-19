#!/bin/bash
# This script is used to build the project.
# Must be run from the root of the project directory.

# Ensure glob syntax properly handles edge cases
shopt -s nullglob

# First, scan for all local hook build scripts:
# Done via Bash glob sytanx - only looks in direct subdirectories of `./local-hooks/`
for build_script in ./local-hooks/*/build.sh; do
    if [ -f "$build_script" ]; then
        # Build script must be executable, check and print warning if not
        if [ ! -x "$build_script" ]; then
            echo "Warning: $build_script is not executable, skipping..."
            continue
        fi
        echo "Running local build script: $build_script"
        # On build failure, exit immediately
        if ! "$build_script"; then
            echo "Error: $build_script failed, exiting..."
            exit 1
        fi
    fi
done

# Perform pre-commit autoupdate, exit if it fails
# TODO: only works if this project is an independent git repo
# if ! pre-commit autoupdate; then
#     echo 'Error: `pre-commit autoupdate` failed, exiting...'
#     exit 1
# fi

# Build the init templatedir to `./build`, exit on failure
# This must set an absolute path to the config file so it's portable between local repos
# Any additional args passed to this script are passed through to this
if ! pre-commit init-templatedir --config="$(pwd)/.pre-commit-config.yaml" "$@" './build'; then
    echo 'Error: `pre-commit init-templatedir` failed, exiting...'
    exit 1
fi

# Done, exit with success
exit 0
