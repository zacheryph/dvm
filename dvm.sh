#!/bin/sh
if [ ! -d "/out" ]; then
  echo "/out must be a directory"
  exit
fi

# figure out mode based of output file name [if given]
outfile="$1"
if [ -z "$outfile" ]; then
  MODE=copy
elif echo "$outfile" | grep -Eq "\.(tar\.|t)gz$"; then
  MODE=gzip
elif echo "$outfile" | grep -Eq "\.(tar\.|t)bz2?$"; then
  MODE=bzip
fi

SRC=$(file -i /in)

if [ -f /in ]; then
  if echo "$SRC" | grep -q "application/x-tar" ; then
    CMD="tar -C /out -xvpf /in"
  elif echo "$SRC" | grep -q "application/x-gzip" ; then
    CMD="tar -C /out -xvpzf /in"
  elif echo "$SRC" | grep -q "application/x-bzip2" ; then
    CMD="tar -C /out -xvpjf /in"
  fi
else
  case "$MODE" in
    copy)
      CMD="cp --archive --verbose /in/* /out/"
      ;;
    gzip)
      CMD="tar -czvf /out/output.tar.gz -C /in ."
      ;;
    bzip)
      CMD="tar -cjvf /out/output.tar.bz2 -C /in ."
      ;;
    *)
      echo "unknown mode: $MODE"
      exit
      ;;
  esac
fi

# shellcheck disable=SC2086
exec ${CMD}
