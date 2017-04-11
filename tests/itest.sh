#!/bin/bash

# ===============================================================
# Before
# ===============================================================

sh ./tests/install_prereqs.sh

# ================================================================
# Apply the Puppet Module
# ================================================================

# Add the --debug option for more info
sudo puppet apply --modulepath=/etc/puppetlabs/code/modules /etc/puppetlabs/code/modules/puppet-module-template/tests/init.pp

# ================================================================
# Assertions
# ================================================================

./tests/run_assertions.sh

# ================================================================
# After
# ================================================================

./tests/tear_down.sh

failed=`grep "^[[:alpha:]]" ./test_results | wc -l`

if [[ $failed -gt 0 ]]
then
  exit 1
else
  rm -f ./test_results
fi
