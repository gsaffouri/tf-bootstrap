#!/bin/bash -e

# Cleans up various files to prepare for a fresh deployment
rm -fr .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup main.tf
