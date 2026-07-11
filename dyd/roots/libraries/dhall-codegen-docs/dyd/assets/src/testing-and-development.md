# Testing and Development

This page is for contributors working on `dhall-codegen` itself: the schema grammar, renderers, transformers, tests, and docs.

## Dryad

This project is managed using [Dryad](https://github.com/somesocks/dryad), a package manager and reproducible build tool for complex monorepo codebases.

## Repo Structure

The repo is a Dryad garden. Source packages live under `dyd/roots/`, and generated build outputs are linked under `dyd/sprouts/`.

The main roots are:

- `dyd/roots/libraries/dhall-codegen` — the pure-Dhall library, renderers, and transformers.
- `dyd/roots/libraries/dhall-codegen-test-fixtures` — generated renderer outputs for fixture and target variants.
- `dyd/roots/libraries/dhall-codegen-snapshot-tests` — checked-in generated-output snapshot comparisons.
- `dyd/roots/libraries/dhall-codegen-smoke-tests` — target-toolchain smoke tests for generated outputs.
- `dyd/roots/libraries/dhall-codegen-docs` — the mdBook docs site.
- `dyd/roots/tools/dhall/dhall` — the pinned Dhall interpreter used by the library root.
- `dyd/roots/tools/go` — the pinned Go toolchain used by Go smoke tests.
- `dyd/roots/tools/mdbook` — the pinned mdBook binary used by the docs root.
- `dyd/roots/tools/caddy` — the pinned Caddy binary used to serve the docs locally.

## Building

Set the active scope to `dev` with:

```bash
dryad scope use dev
```

Then you have access to the following scoped commands:

- `dryad run build` builds the library package and archive variants, docs, and local docs server tool.
- `dryad run test` builds the development scope, then runs snapshot and smoke test sprouts.
- `dryad run open-docs` serves the generated docs site with Caddy.
- `dryad run publish-release-tag` creates and pushes the `release-<version>` git tag.

Build the project roots used during development:

```bash
dryad run build
```

This builds the `dhall-codegen` library package and archive variants, the docs site, and the local Caddy tool used to serve the docs.

To build only the library root:

```bash
dryad root build dyd/roots/libraries/dhall-codegen --scope=none
```

The library root has two output variants:

- `output=package` bundles the reusable Dhall source package.
- `output=archive` bundles the reusable Dhall source package as `dhall-codegen-<version>.tar.gz`.

To build only the release archive:

```bash
dryad root build dyd/roots/libraries/dhall-codegen --scope=none --variant=output=archive
```

To publish the release tag for the current version trait:

```bash
dryad run publish-release-tag
```

This requires a clean worktree, creates an annotated `release-<version>` tag, and pushes it to `origin`.

## Development Commands

Dryad builds run in isolated, disposable build environments. That isolation is useful for reproducible builds, but it also means some development scripts need to run inside the same prepared environment instead of directly from the host shell.

`dryad root develop start` creates that environment for a root, wires in its dependencies, and then runs the command you provide.

Most package-level commands should be run through `dryad root develop start`:

```bash
dryad root develop start dyd/roots/libraries/dhall-codegen~output=package --on-exit=discard -- <command>
```

The `~output=package` selector keeps development commands tied to the package variant.

Use `--on-exit=save` for commands that intentionally modify files.

Format source files under `dyd/assets/src/`:

```bash
dryad root develop start dyd/roots/libraries/dhall-codegen~output=package --on-exit=save -- z-format-src
```

Run the full scoped test command:

```bash
dryad run test
```

This builds the development scope, then runs `dryad run snapshot-test` and `dryad run smoke-test`.

## Testing

Testing is split into fixture rendering, snapshot comparisons, and smoke tests.

Fixture rendering lives in `dyd/roots/libraries/dhall-codegen-test-fixtures`. Each valid `fixture=<name>+target=<name>` variant renders exactly one output file from a schema document and renderer expression.

- `document.dhall` defines the schema document for a test case.
- `out.<ext>.dhall` invokes a renderer and evaluates to generated `Text`.

Snapshot comparisons live in `dyd/roots/libraries/dhall-codegen-snapshot-tests`. Each valid `fixture=<name>+target=<name>` variant depends on the matching generated fixture output with `fixture=inherit&target=inherit`.

- `expected.<ext>` is the checked-in snapshot output.
- `dyd-stem-run` compares generated output against the snapshot output with `diff`.

Smoke tests live in `dyd/roots/libraries/dhall-codegen-smoke-tests`. They consume generated fixture output and run target-specific toolchain checks, such as `go test` for generated Go code.

When a renderer, transformer, or grammar change intentionally changes generated output, update the matching snapshot output files and review the diffs.

## Adding a Test Case

The fastest way to add a new test case is to copy an existing fixture variant. `fixture=person` is a small, representative example.

Typical workflow:

1. Add a fixture option under `dhall-codegen-test-fixtures/dyd/variants/fixture/` and `dhall-codegen-snapshot-tests/dyd/variants/fixture/`.
2. Add concrete `assets~fixture=<name>/` fixture inputs.
3. Add matching snapshot output as `dhall-codegen-snapshot-tests/dyd/assets~fixture=<name>+target=<target>/expected.<ext>`.
4. Add `_exclude` entries for unsupported fixture and target pairs.
5. Run `dryad run snapshot-test`.

## Adding a Renderer

A renderer lives under `dyd/assets/src/renderer-<target>/`. Most renderers follow the same shape:

- `package.dhall` exports the public renderer API.
- `common.dhall` defines renderer options, context, and text fragments.
- `render-schema.dhall` dispatches each schema node type to a per-node renderer.
- `render-<type>.dhall` files implement rendering for each schema node type, such as `record`, `list`, `optional`, and `reference`.
- `render-description.dhall` and `render-prefix.dhall` are used when the target has comments, docs, indentation, or naming behavior.

A renderer should expose a `render` function that takes a `Document.Type` and returns `Text`.

Typical workflow:

1. Copy a nearby renderer directory, usually `renderer-typescript/` for type-oriented targets or `renderer-golang/` for struct/model-oriented targets.
2. Rename the directory to `renderer-<target>/`.
3. Update `common.dhall` with target-specific options and render context.
4. Update `package.dhall` to import the right modules, apply any needed transformers, and export `{ render, options }` if the renderer has options.
5. Implement or adjust each `render-<type>.dhall` file.
6. Add target command variants under the test fixture root and snapshot-test assets under the snapshot-test root.
7. Run `dryad run snapshot-test`.
8. Add smoke tests if the target has a local toolchain check.
9. Add the renderer to `renderers.md`.

For tests, start with a small fixture like `person` and add a concrete target asset directory:

```text
dyd/roots/libraries/dhall-codegen-test-fixtures/dyd/assets~fixture=person/
  document.dhall

dyd/roots/libraries/dhall-codegen-test-fixtures/dyd/commands~target=<target>/
  dyd-root-build

dyd/roots/libraries/dhall-codegen-snapshot-tests/dyd/assets~fixture=person+target=<target>/
  expected.<ext>
```

The target command should import the new renderer and render the fixture `document.dhall`.

## Docs Site

The docs site is an mdBook root at `dyd/roots/libraries/dhall-codegen-docs`.

Serve the generated docs locally:

```bash
dryad run open-docs
```

`open-docs` serves the generated mdBook site with Caddy and tries to open it in your browser.
