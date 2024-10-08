#!/bin/bash 

set -e

DOCKER_HUB_USERNAME="${DOCKER_HUB_USERNAME}"
DOCKER_HUB_PASSWORD="${DOCKER_HUB_PASSWORD}"
LOCAL_DOKER_IMAGE_TAG="${LOCAL_DOKER_IMAGE_TAG}"
REMOTE_DOCKER_HUB_REPO="${REMOTE_DOCKER_HUB_REPO}"
ENV="PROD"
HOST="localhost"
PORT=8000
REDIS_HOST="${REDIS_HOST}"
REDIS_PORT=6379

TAG="latest"

echo "Login to docker hub"
echo "$DOCKER_HUB_PASSWORD" | docker login -u $DOCKER_HUB_USERNAME --password-stdin

echo "Building image"
docker build -t "$LOCAL_DOKER_IMAGE_TAG" \
    --build-arg ENV=$ENV \
    --build-arg HOST=$HOST \
    --build-arg PORT=$PORT \
    --build-arg REDIS_HOST=$REDIS_HOST \
    --build-arg REDIS_PORT=$REDIS_PORT ..

echo "Tagging image"
docker tag "$LOCAL_DOKER_IMAGE_TAG" "$REMOTE_DOCKER_HUB_REPO"

echo "Pushing image"
docker push $REMOTE_DOCKER_HUB_REPO:$TAG

echo "Done"