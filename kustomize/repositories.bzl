load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
def rules_kustomize_dependencies():
    maybe(
        http_archive,
        name = "kubernetes-sigs_kustomize",
        sha256 = "bf3a0d7409d9ce6a4a393ba61289047b4cb875a36ece1ec94b36924a9ccbaa0f",
        urls = ["https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.4.0/kustomize_v4.4.0_linux_amd64.tar.gz"],
        build_file = "@rules_kustomize//kustomize:kustomize.BUILD",
    )