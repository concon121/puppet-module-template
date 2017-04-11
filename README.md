# puppet-module-template

A little bare bones puppet module to help you get started in your quest to become a master puppeteer!

## Prerequisites

I've written this for use on unix systems.  Sorry Windows boys!

-   [Ruby](https://www.ruby-lang.org/en/documentation/installation/) - Puppet is written using Ruby, so this is fairly core.
-   [Bundler](http://bundler.io/) - A Ruby dependency management system.
-   [Rake](https://ruby.github.io/rake/) - A Ruby task runner.
-   [Puppet](https://docs.puppet.com/puppet/4.9/install_linux.html) - Needs no explanation really.
-   [ImageMagick-devel](https://www.rpmfind.net/linux/rpm2html/search.php?query=ImageMagick-devel) - A random dependency Rake requires on CentOS 6.

### I've Installed Ruby, what now?

Install Bundler, Rake, image magick and the Ruby gem dependencies: 
```
  sudo gem install bundler
  sudo gem install rake
  sudo yum install ImageMagick-devel
  bundle install
```

### Setting Up Hiera for Integration Tests

* Ensure that in your hosts file, the 2nd column is a domain (ends with .com, .co.uk etc...).

```
  $ cat /etc/hosts

  127.0.0.1   localhost.com localhost.localdomain localhost4 localhost4.localdomain4
  ::1         localhost.com localhost.localdomain localhost6 localhost6.localdomain6  
```

* Add a hiera.yaml to your Puppet installation directory.
  * backends - Must be a string or an array of strings, where each string is the name of an available Hiera backend. The built-in backends are yaml and json. Additional backends are available as add-ons.
  * hierarchy - Must be a string or an array of strings, where each string is the name of a static or dynamic data source.  In our case we just have a single config file for our localhost.com.
  * datadir - Must be a string which refers to the location on your file system where the Hiera configuration is present.

```
  $ cat /etc/puppet/hiera.yaml

  ---
  :backends:
    - yaml

  :hierarchy:
    - localhost.com

  :yaml:
    :datadir: '/vagrant/hiera'
```

* Create a localhost.com.yaml file in your datadir.

```
  $ cat /vagrant/hiera/localhost.com.yaml

  ---
  puppet_module_template::sample_parameter: 'sample_value!'
```

* Ensure hiera can resolve your configuration.

```
  $ hiera puppet_module_template::sample_parameter

  sample_value!

```

## Running Tests

Rake will handle the execution of tests, and the tasks that it will execute are configured in the Rakefile.

```
  $ rake test
```
The Rakefile is configured to run the following tasks:

-   dos2unix - Convert any windows characters to unix, to ensure compatibility.
-   metadata_lint - Validate that metadata.json contains all of the correct information.
-   lint - Validate all of the .pp files conform to standards and are correctly formatted.
-   validate - Ensure that .pp, .rb and .erb files can be compiled without error.
-   spec - Run all of the tests, identified as "*_spec.pp".
-   itest - Run all of the integration tests.
-   spec_clean - Tidy up the workspace after running the tests.

## Writing Tests

Tests are written using [rspec-puppet](http://rspec-puppet.com), documentation for which can be found on the website.

Test classes should be placed in the appropriate directory for their function:

-   Class Tests - spec/classes/*_spec.rb
-   Function Tests - spec/functions/*_spec.rb
-   Host Tests - spec/hosts/*_spec.rb
-   Definiion Tests - spec/defines/*_spec.rb

## Writing integration tests

Integration tests are written in bash at the moment, and can be found in the tests/itest.sh script.

This may change in the future, as bash doesn't provide a great testing framework.
