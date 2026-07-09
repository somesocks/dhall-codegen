# dhall-codegen

`dhall-codegen` is a pure Dhall library for defining schemas and generating equivalent definitions across multiple programming languages.

Supported language renderers include:

- TypeScript
- Python
- Go
- JSON Schema
- Dhall

## Documentation

- Documentation: <https://somesocks.github.io/dhall-codegen/>
- Releases: <https://github.com/somesocks/dhall-codegen/releases>
- License: [MIT](./LICENSE)

## Usage

Download `dhall-codegen-<version>.tar.gz` from a release and unpack it into your project. Import the package from Dhall with paths like:

```dhall
let Grammar = ./dhall-codegen/grammar.dhall
```

See the documentation for schema examples, renderer options, and target-specific output details.

## Development

Install [Dryad](https://github.com/somesocks/dryad).

Use the development scope:

```bash
dryad scope use dev
```

Common commands:

```bash
dryad run build
dryad run test
dryad run open-docs
```

Build the release archive directly:

```bash
dryad root build dyd/roots/libraries/dhall-codegen --scope=none --variant=output=archive
```

The archive is linked under `dyd/sprouts/libraries/dhall-codegen/dyd/dependencies/stem~output=archive/dyd/assets/`.
