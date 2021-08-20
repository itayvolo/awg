#!/bin/bash
sed "s/tagVersion/$1/g" awg-default.yaml > awgapp-depl.yaml
