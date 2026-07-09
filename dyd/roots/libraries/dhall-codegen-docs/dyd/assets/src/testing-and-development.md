# Testing and Development

This page is for contributors working on `dhall-codegen` itself: the schema grammar, renderers, transformers, tests, and docs.

## Dryad

This project is managed using [Dryad](https://github.com/somesocks/dryad), a package manager and reproducible build tool for complex monorepo codebases.

## Repo Structure

The repo is a Dryad garden. Source packages live under `dyd/roots/`, and generated build outputs are linked under `dyd/sprouts/`.

The main roots are:

- `dyd/roots/libraries/dhall-codegen` — the pure-Dhall library, renderers, transformers, and test fixtures.
- `dyd/roots/libraries/dhall-codegen-docs` — the mdBook docs site.
- `dyd/roots/tools/dhall/dhall` — the pinned Dhall interpreter used by the library root.
- `dyd/roots/tools/mdbook` — the pinned mdBook binary used by the docs root.
- `dyd/roots/tools/caddy` — the pinned Caddy binary used to serve the docs locally.

## Building

Set the active scope to `dev` with:

```bash
dryad scope use dev
```

Then you have access to the following scoped commands:

- `dryad run build` builds the library package and test variants, docs, and local docs server tool.
- `dryad run test` builds the development scope and runs test sprouts.
- `dryad run open-docs` serves the generated docs site with Caddy.

Build the project roots used during development:

```bash
dryad run build
```

This builds the `dhall-codegen` library package and test variants, the docs site, and the local Caddy tool used to serve the docs.

To build only the library root:

```bash
dryad root build dyd/roots/libraries/dhall-codegen --scope=none
```

The library root has two output variants:

- `output=package` bundles the reusable Dhall source package.
- `output=tests` bundles the source package plus test fixtures and exposes a runnable test command.

## Development Commands

Dryad builds run in isolated, disposable build environments. That isolation is useful for reproducible builds, but it also means some development scripts need to run inside the same prepared environment instead of directly from the host shell.

`dryad root develop start` creates that environment for a root, wires in its dependencies, and then runs the command you provide.

Most package-level commands should be run through `dryad root develop start`:

```bash
dryad root develop start dyd/roots/libraries/dhall-codegen~output=package --on-exit=discard -- <command>
```

The `~output=package` selector keeps development commands tied to the package variant now that the root also has a runnable `output=tests` variant.

Use `--on-exit=save` for commands that intentionally modify files, such as formatting or regenerating golden outputs.

Format source files under `dyd/assets/src/`:

```bash
dryad root develop start dyd/roots/libraries/dhall-codegen~output=package --on-exit=save -- z-format-src
```

Format test files under `dyd/assets/tests/`:

```bash
dryad root develop start dyd/roots/libraries/dhall-codegen~output=package --on-exit=save -- z-format-tests
```

Run the full scoped test command:

```bash
dryad run test
```

This builds the development scope, then runs every sprout matching `output=tests`.

Run the test suite inside a development environment:

```bash
dryad root develop start dyd/roots/libraries/dhall-codegen~output=package --on-exit=discard -- z-run-tests
```

Prefer `dryad run test` for the full sprout-based check that builds and runs the `output=tests` variant.

Regenerate checked-in golden outputs:

```bash
dryad root develop start dyd/roots/libraries/dhall-codegen~output=package --on-exit=save -- z-update-tests
```

## Testing

Testing is done by comparing generated output against checked-in golden fixtures. A test renders a schema document, reads the expected output file, and asserts that the two are identical.

Tests live under `dyd/assets/tests/`. Each test case usually contains a schema document plus one or more renderer output checks.

- `document.dhall` defines the schema document for a test case.
- `out.<ext>.dhall` invokes a renderer and evaluates to generated `Text`.
- `out.<ext>` is the checked-in golden output.
- `check*.dhall` asserts that generated output matches the golden output.

When a renderer, transformer, or grammar change intentionally changes generated output, run `z-update-tests` and review the golden fixture diffs.

## Adding a Test Case

The fastest way to add a new test case is to copy an existing one. `dyd/assets/tests/example-person/` is a small, representative example.

Typical workflow:

1. Copy an existing test directory.
2. Edit `document.dhall` to define the schema case.
3. Add or remove renderer subdirectories as needed.
4. Run `z-update-tests` to regenerate golden outputs.
5. Run `z-run-tests` to validate the generated outputs.

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
6. Add golden tests under `dyd/assets/tests/`.
7. Run `z-update-tests`.
8. Run `z-run-tests`.
9. Add the renderer to `renderers.md`.

For tests, start with a small fixture like `example-person` and add a new renderer subdirectory:

```text
dyd/assets/tests/example-person/<target>/
  out.<ext>.dhall
  out.<ext>
  check.<ext>.dhall
```

The `out.<ext>.dhall` file should import the new renderer and render `../document.dhall`.

## Docs Site

The docs site is an mdBook root at `dyd/roots/libraries/dhall-codegen-docs`.

Serve the generated docs locally:

```bash
dryad run open-docs
```

`open-docs` serves the generated mdBook site with Caddy and tries to open it in your browser.
