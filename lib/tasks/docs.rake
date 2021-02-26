# If Rspec is not install don't define this task
begin
  require 'rspec/core/rake_task'

  desc 'Generate API request documentation from API specs'
  RSpec::Core::RakeTask.new('docs:generate:html') do |t|
    t.pattern = 'spec/requests/**/*_spec.rb'
    t.rspec_opts = ['--format RspecApiDocumentation::ApiFormatter']
  end
rescue LoadError
  warn 'Skipping docs generate task'
end
