## Things to do:

1. review if symlinks are the best way to do this
2. add more features? plugins more commands?

## To use this you need to set --experimental_allow_unresolved_symlinks

## Examples

The examples directory contains examples of how to use these rules

# Bazel rules for mylang

## Installation

Include this in your WORKSPACE file:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "com_myorg_rules_mylang",
    url = "https://github.com/myorg/rules_mylang/releases/download/0.0.0/rules_mylang-0.0.0.tar.gz",
    sha256 = "",
)

load("@com_myorg_rules_mylang//mylang:repositories.bzl", "mylang_rules_dependencies")

# This fetches the rules_mylang dependencies, which are:
# - bazel_skylib
# If you want to have a different version of some dependency,
# you should fetch it *before* calling this.
# Alternatively, you can skip calling this function, so long as you've
# already fetched these dependencies.
rules_mylang_dependencies()
```

> note, in the above, replace the version and sha256 with the one indicated
> in the release notes for rules_mylang
> In the future, our release automation should take care of this.
