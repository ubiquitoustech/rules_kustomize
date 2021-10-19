load(":actions.bzl", "kustomize_build_action")







def _kustomize_build_impl(ctx):

    deps_depsets = []


    for dep in ctx.attr.deps:

        if DefaultInfo in dep:
            deps_depsets.append(dep.files)


    deps_inputs = depset(transitive = deps_depsets).to_list()

    inputs = deps_inputs + ctx.files.srcs
    inputs.append(ctx.file.kustomize)

    main_archive = ctx.actions.declare_file(ctx.label.name + ".yaml")

    kustomize_build_action(
        ctx,
        srcs = inputs,
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
            doc = "halconfig file to use as input to kleat",
        ),
        # "data": attr.label_list(
        #     allow_files = True,
        #     doc = "Data files available to binaries using this library",
        # ),
        "_kustomize": attr.label(
            doc = "An executable target that runs kleat",
            # TODO this should be changed so that it doesn't require user install and naming
            default = Label("@kubernetes-sigs_kustomize//:kustomize-file"),
            executable = True,
            cfg = "host",
        ),
    },
    doc = "runs kustomize and generates the an output file",
)