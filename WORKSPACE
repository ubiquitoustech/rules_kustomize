workspace(name = "ubiquitous_tech_rules_kustomize")

load("@ubiquitous_tech_rules_kustomize//kustomize:repositories.bzl", "kustomize_register_toolchains", "rules_kustomize_dependencies")

rules_kustomize_dependencies()

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies")

aspect_bazel_lib_dependencies()

load(":internal_deps.bzl", "rules_kustomize_internal_deps")

rules_kustomize_internal_deps()

kustomize_register_toolchains(
    name = "kustomize4_4_0",
    kustomize_version = "4.4.0",
)
