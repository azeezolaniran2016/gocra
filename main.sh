#!/bin/sh
PROXY_PORT=3003
SCRIPT_FILES_DIR="$(pwd)/files"

echo "Checking required programs"
for i in "docker" "go" "yarn" "sed"
do
  if ! command -v $i &> /dev/null
  then
      echo "$i could not be found"
      exit -1
  fi
done

echo "Creating project $1"

mkdir -p $1 "$1/env" "$1/cmd"

cat "$SCRIPT_FILES_DIR/.air.toml" > "$(pwd)/$1/.air.toml"
cat "$SCRIPT_FILES_DIR/Dockerfile.dev" > "$(pwd)/$1/Dockerfile.dev"
cat "$SCRIPT_FILES_DIR/dev.env" > "$1/env/dev.env"
cat "$SCRIPT_FILES_DIR/Makefile" > "$1/Makefile"
sed "s/{CONTAINER_NAME}/$1/g; s/{PROXY_PORT}/$PROXY_PORT/g" $SCRIPT_FILES_DIR/docker-compose.yml > "$1/docker-compose.yml"
cat "$SCRIPT_FILES_DIR/.gitignore" > "$1/.gitignore"
cat "$SCRIPT_FILES_DIR/main.go" > "$1/cmd/main.go"

cd $1
go mod init $1
go mod tidy

yarn create react-app client --template typescript
cd client
yarn add -D http-proxy-middleware
sed "s/{PROXY_PORT}/$PROXY_PORT/g" $SCRIPT_FILES_DIR/setupProxy.js > "./src/setupProxy.js"
