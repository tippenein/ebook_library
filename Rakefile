require 'bundler'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w(--format documentation --colour)
end

task :default => 'spec'

# example rake task
task :generate do
  require 'json'
  default = EbookLibrary::Gatherer::DEFAULT_PATH
  path = ARGV[1] || default if File.directory?(default)
  gatherer = EbookLibrary::Gatherer.new path
  ebooks = gatherer.gather.to_json
  File.open("./books.json", 'w') { |file| file.write(ebooks) }
end
