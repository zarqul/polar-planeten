#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

echo "${@}"

VENV_BIN=/app/.venv/bin

case "$1" in
  django)
    cd planeten
    $VENV_BIN/python manage.py "${@:2}"
    ;;

  test)
    cd planeten
    $VENV_BIN/python manage.py test
    ;;

  gunicorn)
    cd planeten
    $VENV_BIN/gunicorn planeten.wsgi:application --bind="0.0.0.0:8000"
    ;;

  *)
    exec "$@"

esac
