#!/bin/bash

# Copyright 2025 Duc Hung Ho.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

CURRENT_DIR=$(pwd)
GOPATH_DIR=${GOPATH}

if [ -z "$GOPATH_DIR" ]; then
  echo "GOPATH is not set. Please set it before running this script."
  exit 1
fi

if [[ "$CURRENT_DIR" != *"$GOPATH_DIR"* ]]; then
  echo "Current directory ($CURRENT_DIR) does not contain GOPATH ($GOPATH_DIR)."
  exit 1
fi

SENPATH=$GOPATH/src/github.com/kyerand/sentinel
SENPROTOPATH=*.proto
SENOUT=$GOPATH/src

protoc -I. \
  --proto_path=$SENPATH \
  -I$SENPATH/api \
  -I$SENPATH/_submodules/googleapis \
  -I$SENPATH/_submodules/grpc-gateway \
  -I$SENPATH/_submodules/protovalidate/proto/protovalidate \
  --go_out=$SENOUT \
  --go-grpc_out=$SENOUT \
  --validate_out="lang=go,paths=:$SENOUT" \
  $SENPROTOPATH
