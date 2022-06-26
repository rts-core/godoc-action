<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/rts-core/godoc-action">
    <img src="images/logo.png" alt="Logo" height="120">
  </a>

  <p align="center">
    Github Action for generating GoDocs to host on GHPages
    <br />
    <a href="https://github.com/rts-core/godoc-action/issues">Report Bug</a> |
    <a href="https://github.com/rts-core/godoc-action/issues">Request Feature</a>
  </p>
</p>

### Built With

* [GoDoc](https://pkg.go.dev/golang.org/x/tools/cmd/godoc)
* [Docker](https://www.docker.com/)
* [Github Actions](https://github.com/features/actions)

<!-- GETTING STARTED -->
## Getting Started

This action is designed to run a godoc webserver and get static HTML hosted from it to a directory for you to push to your gh-pages branch.

### Example Usage

```yml
name: Go

on:
  push:
    branches: [ "main" ]

jobs:

  ci:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3

    - name: Set up Go
      uses: actions/setup-go@v3
      with:
        go-version: 1.18

    - name: Test
      run: go test -v ./...
      
    - name: Generate Documentation
      uses: ./.github/workflows/actions/godoc
    
    - name: Publish Documentation
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: .docs
        force_orphan: true

```

## Inputs
### html_dir
Allows you to name the directory the html will be generated into. Note the index.html file will be in the root of whatever directory you enter, and this directory will be both deleted and recreated on run to ensure no odd collisions.

**Required:** No

**Default:** .docs

### ignore_src
Allows you to flag whether the *.go files will be downloaded from the server. These are usually used to allow links to automatically open the source file in the browser. They do not work in most cases for static hosting though, they also take up room and take longer to gather. So it's recommended you do not include these.

**Required:** No

**Default:** true