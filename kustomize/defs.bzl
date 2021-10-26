"""
Public API re-exports
"""

load(
    "@ubiquitous_tech_rules_kustomize//kustomize/private:rules.bzl",
    _kustomize_build = "kustomize_build",
)

kustomize_build = _kustomize_build
