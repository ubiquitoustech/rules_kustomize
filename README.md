you can use kustomize this way


./kustomize build {path to directory with kustomization.yaml file} --output ( or -o ) write the build output to this path


This makes it very easy to use it as a rule in bazel without having to change the directory structure or how things are imported

Just need to make sure that bazel keeps everything in the same relative path which it should so this should work well


Create a new basic set of rules that with use kustomize probably best to use it as a toolchain that way you can rely on it

try with this to see if this works in concept: https://github.com/benchsci/rules_kustomize

then create real rules for kustomize that are done with ctx.actions.run and a executable

make sure kustomize rules can run on kustomization .yaml or yml

Allow for kustomize to have deps on the output of other rules so it will work with kleat

they are just basic file deps so they don't have to do anything fancy look at the go example for how this could work

just use the kustomize binaries to make it easy so it doesn't conflict with kleat



use binaries for kustomize to start



so what do I need to do to get the binary working?
I need to download the binary and then make it available as an executable




## Things to do:
1. handle deps so that input files generated from other rules can be use by kustomize
2. make the rules work on multiple platforms
