require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'
require 'colorize'

if RUBY_VERSION >= '1.9'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.relative = true
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp']

desc 'Validate manifests, templates, and ruby files'
task :validate do
  puts 'Starting file validation'.cyan

  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb', 'lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ %r{spec/fixtures}
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end

  puts 'Finished file validation'.cyan
end

desc 'Integration tests between puppet, bash script and wiremock.'
task :itest do
  puts 'Starting Integration Test'.cyan

  sh %(./tests/itest.sh) do |ok, _res|
    if !ok
      puts 'Failed! See test_results for more info'.red
    else
      puts 'Passed!'.green
    end
  end

  puts 'Finished Integration Test'.cyan
end

desc 'Convert dos characters to unix'
task :dos2unix do
  puts 'Starting dos2unix'.cyan

  sh %(yum -y install dos2unix)
  sh %{files=(`find . | grep '\\.sh'`) && for file in ${files[@]}; do dos2unix $file; done}

  puts 'Finished dos2unix'.cyan
end

desc 'Run metadata_lint, lint, validate, and spec tests.'
task :test do
  [:dos2unix, :metadata_lint, :lint, :validate, :spec, :itest, :spec_clean].each do |test|
    Rake::Task[test].invoke
  end
end
