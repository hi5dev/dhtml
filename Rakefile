# frozen_string_literal: true

require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs += %w[lib test]
  t.test_files = FileList[File.join('test', '**', '*_test.rb')]
  t.verbose = false
end

task default: :test
