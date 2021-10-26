"""
kustomize rules
"""

load(":actions.bzl", "kustomize_build_action")

def _kustomize_build_impl(ctx):
    deps_depsets = []

    for dep in ctx.attr.deps:
        if DefaultInfo in dep:
            deps_depsets.append(dep.files)

    deps_inputs = depset(transitive = deps_depsets).to_list()

    inputs = deps_inputs

    diff = len(ctx.file.kustomize.path) - len(ctx.file.kustomize.basename)

    for src in ctx.files.srcs:
        place = src.path[diff:]
        symtest = ctx.actions.declare_symlink(place)

        ctx.actions.symlink(output = symtest, target_path = src.path)

        inputs.append(symtest)

    # add kustomize file to the symlinks as well
    place = ctx.file.kustomize.path[diff:]

    symtest = ctx.actions.declare_symlink(place)

    ctx.actions.symlink(output = symtest, target_path = ctx.file.kustomize.path)

    inputs.append(symtest)

    for file in ctx.toolchains["@ubiquitous_tech_rules_kustomize//kustomize:toolchain_type"].kustomizeinfo.tool_files:
        inputs.append(file)

    main_archive = ctx.actions.declare_file(ctx.label.name + ".yaml")

    outputlen = len(main_archive.path) - len(main_archive.dirname)

    outdir = main_archive.path[:-outputlen]

    kustomize_build_action(
        ctx,
        srcs = inputs,
        deps = deps_inputs,
        dir = outdir,
        out = main_archive,
    )

    return [DefaultInfo(
        files = depset([main_archive]),
        runfiles = ctx.runfiles(collect_data = True),
    )]

kustomize_build = rule(
    _kustomize_build_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
            doc = "Source files to compile for the main package of this binary",
        ),
        "deps": attr.label_list(
            default = [],
            # aspects = [],
            doc = "A list of direct dependencies that are required to build the bundle",
        ),
        # I would like to remove this field but right now it us used to get the parent directory kustommize should run in for the build
        "kustomize": attr.label(
            allow_single_file = [".yaml", ".yml"],
            doc = "kustomize file to use as input to kustomize",
        ),
        # "data": attr.label_list(
        #     allow_files = True,
        #     doc = "Data files available to binaries using this library",
        # ),
    },
    toolchains = ["@ubiquitous_tech_rules_kustomize//kustomize:toolchain_type"],
    doc = "runs kustomize and generates the an output file",
)
