#!/usr/bin/env bash

set +x +e

mvn -q jar:jar install:install help:evaluate -Dexpression=project.name
NAME=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.name)
VERSION=$(mvn -q -DforceStdout help:evaluate -Dexpression=project.version)
java -jar target/${NAME}-${VERSION}.jar
