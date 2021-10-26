"""
kustomize actions
"""

def kustomize_build_action(ctx, srcs, deps, dir, out):
    """Run a build of the kustomize

    Args:
        ctx: arguments description, can be
        multiline with additional indentation.
        srcs: source files
        out: output directory
        deps: dependencies
        dir: directory to run kustomize from
    """

    # setup the args passed to kustomize
    launcher_args = ctx.actions.args()

    launcher_args.add_all([
        "build",
        dir,
        "-o",
        out,
        "--load-restrictor=LoadRestrictionsNone",
    ])

    outputs = []
    outputs.append(out)

    execution_requirements = {}
    if "no-remote-exec" in ctx.attr.tags:
        execution_requirements = {"no-remote-exec": "1"}

    ctx.actions.run(
        outputs = outputs,
        inputs = srcs,
        executable = ctx.toolchains["@ubiquitous_tech_rules_kustomize//kustomize:toolchain_type"].kustomizeinfo.target_tool_path,
        arguments = [launcher_args],
        mnemonic = "Kustomize",
    )
