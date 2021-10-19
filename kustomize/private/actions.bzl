"""
kustomize actions
"""

def kustomize_build_action(ctx, srcs, out):
    """Run a production build of the vite project

    Args:
        ctx: arguments description, can be
        multiline with additional indentation.
        srcs: source files
        out: output directory
    """

    # setup the args passed to kustomize
    launcher_args = ctx.actions.args()

    launcher_args.add_all([
        "build",
        ctx.file.kustomize.dirname,
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
        executable = ctx.executable._kustomize,
        arguments = [launcher_args],
        mnemonic = "Kustomize",
    )
