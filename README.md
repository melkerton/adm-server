# A Dart Mock Server (adm-server)

[![release-v0.0.1-alpha](https://img.shields.io/github/v/tag/melkerton/adm-server?label=release)](https://github.com/melkerton/adm-server/releases/tag/v0.0.1-alpha)
[![coverage](https://codecov.io/gh/melkerton/adm-server/branch/main/graph/badge.svg?token=FUMZ03VNVV)](https://app.codecov.io/gh/melkerton/adm-server/tree/main)
[![CircleCI](https://img.shields.io/circleci/build/github/melkerton/adm-server/main?logo=circleci)](https://dl.circleci.com/status-badge/redirect/gh/melkerton/adm-server/tree/main)

This is primarily a way for me to learn Dart and reStructured Text, look at at you own risk.

Cheers.

--- 

## Basic Usage

```
curl https://github.com/melkerton/adm-server/releases/download/v0.0.1-alpha/adms-v0.0.1-alpha-linux-amd64.exe
chmod +x adms-v0.0.1-alpha-linux-amd64.exe
./adms-v0.0.1-alpha-linux-amd64.exe
```

This will download `adms-v0.0.1-alpha-linux-amd64.exe`, make it executable, and start the server using the current directory as the mock data directory. Pass a directory path as the first argument [^1] to `adms-v0.0.1-alpha-linux-amd64.exe` to specify the mock data directory (first method preferred). 

## Server Configuration

Create a file `adms.yaml` in the root of the mock data directory.

Example adms.yaml
```
server:
    port: 4876
    host: localhost
```

## Mock Data Configuration

Create a file `index.yaml` next to `adms.yaml`. This file is a [YamlList](https://pub.dev/documentation/yaml/latest/yaml/YamlList-class.html) of [YampMap](https://pub.dev/documentation/yaml/latest/yaml/YamlMap-class.html)'s that maps the request uri to a response.

Example
```
- path: alpha
  response: data-alpha

- path: beta
  response: pipe-beta.py
```

There are two types of `response` available:

1. a flat data file containing an HttpMessage [^2] or
2. an executable that accepts the requested uri[^3] as the first agrument and prints an HttpMessage to stdout.

[^1]: This is the only argument that `adms-v0.0.1-alpha-linux-amd64.exe` accepts.
[^2]: (link and note re start line)
[^3]: 

[@kadevapp](https://twitter.com/kadevapp)
