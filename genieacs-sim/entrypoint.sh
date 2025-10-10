#!/bin/sh
set -eu

if [ -z "${SIM_ACS_URL}" ]; then
  echo "SIM_ACS_URL must be set" >&2
  exit 1
fi

ARGS="--acs ${SIM_ACS_URL} --serial ${SIM_SERIAL} --oui ${SIM_OUI} --product ${SIM_PRODUCT}"

if [ -n "${SIM_USERNAME}" ]; then
  ARGS="$ARGS --username ${SIM_USERNAME}"
fi

if [ -n "${SIM_PASSWORD}" ]; then
  ARGS="$ARGS --password ${SIM_PASSWORD}"
fi

if [ -n "${SIM_INTERVAL}" ]; then
  ARGS="$ARGS --interval ${SIM_INTERVAL}"
fi

if [ -n "${SIM_EXTRA_ARGS}" ]; then
  ARGS="$ARGS ${SIM_EXTRA_ARGS}"
fi

exec ./genieacs-sim $ARGS
