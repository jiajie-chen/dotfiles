# Git Repo Template Builder

This contains code for building a Git repo template, for usage by `init.templateDir`.

The primary use is to configure Git hooks that should always be enabled in your local repos.

## Requirements

You must have Git installed and Pre-commit.
To install Pre-commit, it's recommended to use Homebrew, `pipx` or `uv tool install`

## Git Hooks

Git hooks are managed by `pre-commit`: https://pre-commit.com/index.html

The hooks to be used in templates are configured in `./.pre-commit-config.yaml`: https://pre-commit.com/index.html#plugins

### Local Pre-commit Hooks

Local pre-commit hook source code is located in `./local-hooks/`, each hook package in their own subdirectory.

This allows for custom pre-commit hooks that aren't already packaged by third-parties.

The hook entrypoints must be registered in the ``./.pre-commit-config.yaml` using the `repo: local` flag and associated configs: https://pre-commit.com/#repository-local-hooks

Additionally, custom hook packages can include an executable `build.sh` to help do any build/setup needed for final installation by pre-commit.

## Build Output

The builder script (`./build.sh`) in this folder should output to the `../build/` directory.
It must be run from this directory, as relative paths are used.

This makes use of `pre-commit init-templatedir` to build Git hooks: https://pre-commit.com/#pre-commit-init-templatedir

All non-dot files in here will be copied into the `.git` folder (or respective dir) for `git init`/`git clone`s, depending on Git configuration.

## Git Template Directory Configuration

To enable this by default for all new `git init`/`git clone`, set your global Git config's `init.templateDir` to the build folder.

You can also explicitly define template dirs for specific repos, see: https://git-scm.com/docs/git-init#_template_directory

### Retroactively applying templates

You can also rerun `git init` in an existing repo to apply any configured templates to an already created/checked out repo.

### Opt-out of template usage

If the global `init.templateDir` is configured, you can opt out and just use the default `.git` template for specific repos.

Do this by passing in the `--template /usr/share/git-core/templates` flag to your `git init`/`git clone`s (Assuming this is the default template path as installed by Git on your system).

## Non-templated Pre-commit Hooks

For repo-specific hooks, you can use pre-commit to configure a repo-local `.pre-commit-config.yaml`: https://pre-commit.com/#plugins

These are not handled by this builder.

# TODOs

- Integrate with `yadm`'s bootstrap feature
  - Make root `build.sh` location agnostic (`HERE="$(cd "$(dirname "$0")" && pwd)"`)
