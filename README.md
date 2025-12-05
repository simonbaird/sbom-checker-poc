# sbom-checker-poc

Experimenting with using [Conforma](https://conforma.dev/) to perform policy
checks on SBOMs.

## Requirements

* [conforma](https://github.com/conforma/cli)
* [cosign](https://github.com/sigstore/cosign)
* [skopeo](https://github.com/containers/skopeo)

## Usage

```bash
# Download some sample sboms
make fetch-sboms
ls -l ./sboms

# Run policy checks against those sboms using
# the Conforma-style rego rules in ./policy
make check-sboms
```

## See also

* [TC-2808](https://issues.redhat.com/browse/TC-2808)
* [interlynk-io/sbomqs](https://github.com/interlynk-io/sbomqs)
