require 'bundler/setup'
require 'java_css_inliner'
require 'benchmark'
require 'fileutils'

files_dir = File.join(File.dirname(__FILE__), 'files')
html_file = File.join(files_dir, 'ink_boilerplate.html')
css_file  = File.join(files_dir, 'ink.css')
html_str = File.read(html_file)
css_str  = File.read(css_file)

output_dir = File.join(File.dirname(__FILE__), '..', 'tmp')
output_file = File.join(output_dir, 'ink_boilerplate.inlined.html')
FileUtils.mkdir_p(output_dir)

inliner = CSS::Inliner.new

# Get an initial benchmark
Benchmark.bm(40) do |bm|
  bm.report('initial run') do
    inliner.inline(html_str, css_str)
  end
end

# Write a sample file out to disk for inspection
File.open(output_file, 'w') do |f|
  f.write inliner.inline(html_str, css_str)
end

# Warmup the JIT
500.times do
  inliner.inline(html_str, css_str)
end

# Benchmark the JIT optimized time
Benchmark.bm(40) do |bm|
  bm.report('after warmup') do
    inliner.inline(html_str, css_str)
  end
end
