#!/bin/bash

# =============================================================================
#   Pre-test actions
# =============================================================================

rm -f /vagrant/hiera/localhost.com.yaml
cp ./tests/config/localhost.com.yaml /vagrant/hiera/localhost.com.yaml
