"""
rules to create files to test kustomize deps
"""

def _configmap_create_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)

    configmap = """\
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
        content = configmap,
    )
    return [DefaultInfo(files = depset([out]))]

configmap_create = rule(
    implementation = _configmap_create_impl,
)

def _deployment_create_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)

    deployment = """\
apiVersion: apps/v1
kind: Deployment
metadata:
  name: the-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      deployment: hello
  template:
    metadata:
      labels:
        deployment: hello
    spec:
      containers:
      - name: the-container
        image: monopole/hello:1
        command: ["/hello",
                  "--port=8080",
                  "--enableRiskyFeature=$(ENABLE_RISKY)"]
        ports:
        - containerPort: 8080
        env:
        - name: ALT_GREETING
          valueFrom:
            configMapKeyRef:
              name: the-map
              key: altGreeting
        - name: ENABLE_RISKY
          valueFrom:
            configMapKeyRef:
              name: the-map
              key: enableRisky
    """

    ctx.actions.write(
        output = out,
        content = deployment,
    )
    return [DefaultInfo(files = depset([out]))]

deployment_create = rule(
    implementation = _deployment_create_impl,
)

def _service_create_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)

    service = """\
kind: Service
apiVersion: v1
metadata:
  name: the-service
spec:
  selector:
    deployment: hello
  type: LoadBalancer
  ports:
  - protocol: TCP
    port: 8666
    targetPort: 8080
    """

    ctx.actions.write(
        output = out,
        content = service,
    )
    return [DefaultInfo(files = depset([out]))]

service_create = rule(
    implementation = _service_create_impl,
)
