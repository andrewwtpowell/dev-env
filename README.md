# dev-env

## Building Container Image
```
docker build -t <tag> .
```
## Running Container
```
docker run -it --rm \
-v </path/to/workspace>:/workspace \
-e HOST_USER_ID=$(id -u $USER) \
-e HOST_GROUP_ID=$(id -g $USER) \
-e GIT_USER_NAME="<name>" \
-e GIT_USER_EMAIL="<email>" \
-v ~/.ssh:/home/me/.ssh \
<tag>:latest
```
