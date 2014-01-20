require 'bundler/setup'
require 'derelicte'
require 'benchmark'
require 'fileutils'

files_dir = File.join(File.dirname(__FILE__), 'files')
html_file = File.join(files_dir, 'ink_hero.html')
css_file  = File.join(files_dir, 'ink.css')
css_file2 = File.join(files_dir, 'ink_hero.css')
html_str = File.read(html_file)
css_str  = File.read(css_file) + File.read(css_file2)

output_dir = File.join(File.dirname(__FILE__), '..', 'tmp')
output_file = File.join(output_dir, 'ink_hero.inlined.html')
FileUtils.mkdir_p(output_dir)

inliner = Derelicte::Inliner.new

# Get an initial benchmark
Benchmark.bm(40) do |bm|
  bm.report('initial run (1x)') do
    inliner.inline(html_str, css_str)
  end
end

# Write a sample file out to disk for inspection
File.open(output_file, 'w') do |f|
  f.write inliner.inline(html_str, css_str)
end

# Warmup the JIT
1000.times do
  inliner.inline(html_str, css_str)
end

# Benchmark the JIT optimized time
Benchmark.bm(40) do |bm|
  bm.report('after warmup (10x)') do
    10.times do
      inliner.inline(html_str, css_str)
    end
  end
end

doc = ::Derelicte.doc_from_str(html_str)
analyzer = ::Derelicte.css_analyzer_from_str(css_str)
job = ::Derelicte::InlinerJob.new(doc, analyzer)
job.send(:assignments)

Benchmark.bm(40) do |bm|
  bm.report('parse css to analyzer (10x)') do
    10.times do
      analyzer = ::Derelicte.css_analyzer_from_str(css_str)
    end
  end

  bm.report('evaluate rules for doc (10x)') do
    10.times do
      job = ::Derelicte::InlinerJob.new(doc, analyzer)
      job.send(:assignments)
    end
  end

  bm.report('apply rules to doc (10x)') do
    10.times do
      job.apply_rules_to_doc
    end
  end
end
