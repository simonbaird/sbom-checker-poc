#
# METADATA
# title: My first hello world
# description: >-
#   Not a serious policy, but something to show what a Conforma style
#   policy package looks like
#
package hello_world

import data.lib

# METADATA
# title: Check for valid SPDXID value
# description: >-
#   Make sure that the SPDXID value found in the SBOM matches a list
#   of allowed values.
# custom:
#   short_name: valid_spdxid
#   failure_msg: >-
#     Found unexpected SPDXID value: '%s'. Expecting it to be one of %s.
#   solution: >-
#     Perhaps figure out what tooling produced this SBOM and take a look
#     at what SPDXID value it is producing and why.
#
deny contains result if {
  # Actually there's only one allowed value currently
  allowed_values := ["SPDXRef-DOCUMENT"]

  # If this is true the violation will be effective
  not input.SPDXID in allowed_values

  # This does some parsing of the metadata and prepares a standard Conforma-style result
  result := lib.result_helper(rego.metadata.chain(), [input.SPDXID, concat(",", allowed_values)])
}


# METADATA
# title: Check we don't have too many packages
# description: >-
#   Just an example...
# custom:
#   short_name: minimal_packages
#   failure_msg: >-
#     There are %d packages which is more than the permitted maximum of %d.
#   solution: >-
#     You need to reduce the number of dependencies in this artifact.
#
deny contains result if {
  max_package_count := 510
  found_package_count := count(input.packages)

  # Violation condition
  found_package_count > max_package_count

  # This does some parsing of the metadata and prepares a standard Conforma-style result
  result := lib.result_helper(rego.metadata.chain(), [found_package_count, max_package_count])
}
