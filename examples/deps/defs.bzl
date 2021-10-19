def _foo_binary_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)

    configMap = """\
apiVersion: v1
kind: ConfigMap
metadata:
  name: the-map
data:
  altGreeting: "Good Morning! Update"
  enableRisky: "false"
    """


    ctx.actions.write(
        output = out,
        content = configMap,
    )
    return [DefaultInfo(files = depset([out]))]


foo_binary = rule(
    implementation = _foo_binary_impl,
)