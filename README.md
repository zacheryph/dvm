# dvm: docker volume manager

docker volume manager is a simple tool to make backing up
and restoring docker volumes as easy as possible. simple
give it a source[s] and destination and dvm handles putting
files where you want them.

This tool can be used for populating a docker volume or
extracting data from a docker volume.

## Usage

> `docker run --rm {SOURCE}:/in {DEST}:/out zacheryph/dvm [filename]`

DVM works very simply.  Take `/in` and copy it to `/out`.

If `/in` is a file its type is checked (tar, tgz, tbz are supported)
and it is extracted into `/out`.

Otherwise whatever is in the `/in` directory is copied to `/out`. If
a file name is given this is used to bundle up `/in` into said file
within `/out`.

## Supported File Types

The supported filetypes are supported for extracting `/in` into `/out`.

* tar (tarball)
* tar.gz (gzipped tarball)
* tar.bz (bzip2'ed tarball)

The supported file names are allowed for output file names, which will
be created within the directory given for `/out`

* `_filename_.tar`
* `_filename_.tar.gz`
* `_filename_.tgz`
* `_filename_.tar.bz`
* `_filename_.tar.bz2`
* `_filename_.tbz`
* `_filename_.tbz2`

## Examples

```shell
# copy docker volume dockvol into ./backup as is (cp)
$ docker run --rm -v dockvol:/in -v $PWD/backup:/out zacheryph/dvm

# copy docker volume dockvol to ./backup-now.tgz
$ docker run --rm -v dockvol:/in -v $PWD:/out zacheryph/dvm backup-now.tgz

# extract backup-now.tgz into the docker volume dockvol
$ docker run --rm -v $PWD/backup-now.tgz:/in -v dockvol:/out zacheryph/dvm
```
