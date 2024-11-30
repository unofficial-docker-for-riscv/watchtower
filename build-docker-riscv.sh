#!/bin/bash
# DO NOT UPSTREAM THIS FILE

VERSION=$(curl -s https://api.github.com/repos/containrrr/watchtower/releases/latest | jq -r .tag_name)

REPOS=(${REPOS:-ngc7331/riscv-watchtower})
TAGS=()
for repo in ${REPOS[@]}; do
	TAGS+=("-t ${repo,,}:${VERSION}")
  TAGS+=("-t ${repo,,}:latest")
done

docker buildx build \
  ${TAGS[@]} \
  --push \
  --build-arg WATCHTOWER_VERSION=${VERSION} \
  --platform linux/riscv64 \
  -f dockerfiles/Dockerfile.self-contained \
  .
