"""Mirror of release info
TODO: generate this file from GitHub API"""

# The integrity hashes can be computed with
# shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64

# the checksum is used that is provided with the releases in checksums.txt on github for kustomize
TOOL_VERSIONS = {
    "4.4.0": {
        "darwin_amd64": "f0e55366239464546f9870489cee50764d87ebdd07f7402cf2622e5e8dc77ac1",
        "darwin_arm64": "9556143d01feb9d9fa7706a6b0f60f74617c808f1c8c06130647e36a4e6a8746",
        "linux_amd64": "bf3a0d7409d9ce6a4a393ba61289047b4cb875a36ece1ec94b36924a9ccbaa0f",
        "linux_arm64": "f38032c5fa58dc05b406702611af82087bc02ba09d450a3c00b217bf94c6f011",
    },
    "4.3.0": {
        "darwin_amd64": "77898f8b7c37e3ba0c555b4b7c6d0e3301127fa0de7ade6a36ed767ca1715643",
        "darwin_arm64": "26ffe5afc28d0d32876990ecc362dba69009fe99d872fd7168e53ad0e9cd7826",
        "linux_amd64": "d34818d2b5d52c2688bce0e10f7965aea1a362611c4f1ddafd95c4d90cb63319",
        "linux_arm64": "59de4c27c5468f9c160d97576fbdb42a732f15569f68aacdfa96a614500f33a2",
    },
}
