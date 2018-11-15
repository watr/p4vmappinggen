require 'find'
require 'open3'

Dir.chdir(__dir__)

files = []
Find.find('./input-sample-json') { |item|
    if FileTest.file? item then
        files << File.basename(item, '.*')
    end
}

has_ng = false
files.each { |item|
    stdout, stderr, status = Open3.capture3("diff -B <(ruby ./p4vmappinggen.rb -i ./input-sample-json/#{item}.json) <(cat ./output-expected-txt/#{item}.txt)")
    ok = (stdout.length == 0)
    if (not has_ng) and (not ok) then
        has_ng = true
    end
    print ['test', item, '=>', (ok ? "OK" : "NG")].join(' ') + "\n"
}

exit (not has_ng)