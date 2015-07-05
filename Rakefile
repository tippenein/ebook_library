require 'bundler'
require 'rspec/core/rake_task'
require 'ebook_library'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w(--format documentation --colour)
end

task :default => 'spec'

# example rake task
task :generate do
  require 'json'
  ebooks = EbookLibrary.dump
  File.open("./books.json", 'w') { |file| file.write(ebooks) }
end
