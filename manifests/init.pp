# == Class: puppet_module_template
#
# Document your puppet module here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array.
#
# === Authors
#
#    Connor Bray <connor.bray@icloud.com>
#
class puppet_module_template (
        $sample_parameter,
) {

    notify { 'The template is running!': }

}
