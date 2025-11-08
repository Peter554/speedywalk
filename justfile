[default]
_default:
    @just --list

check: test lint

compile:
    @uv run maturin develop

compile-release:
    @uv run maturin develop --release

fmt:
    @cargo fmt
    @uv run ruff format

[group('test')]
test: compile test-rs test-py

[group('test')]
test-rs:
    @cargo test --all-features

[group('test')]
test-py:
    @uv run pytest

[group('lint')]
lint: lint-rs lint-py

[group('lint')]
lint-rs:
    @cargo clippy --all-targets --all-features -- -D warnings
    @cargo fmt -- --check

[group('lint')]
lint-py:
    @uv run ty check
    @uv run ruff check
    @uv run ruff format --check

[group('fix')]
fix: fix-rs fix-py

[group('fix')]
fix-rs:
    @cargo clippy --all-targets --all-features --fix --allow-staged
    @just fmt

[group('fix')]
fix-py:
    @uv run ruff check --fix
    @just fmt

# Publish a new version. Usage: just publish patch|minor|major.
[group('publish')]
publish MODE:
    just _publish-check-mode "{{MODE}}"
    just check
    just _check-uncommitted-changes
    cargo bump {{MODE}}
    git add --all
    git commit -m "Bump version v`just _get-version`"
    git tag "v`just _get-version`"
    git push
    git push --tags

_publish-check-mode MODE:
    @[[ "{{MODE}}" =~ ^(patch|minor|major)$ ]] || (echo "Error: MODE must be patch, minor, or major" && exit 1)

_check-uncommitted-changes:
    @test -z "$(git status -s)" || (echo "Error: There are uncommitted changes" && exit 1)

_get-version:
    @cargo metadata --format-version=1 --no-deps | jq -r '.packages[0].version'
