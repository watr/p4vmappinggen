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
    script = "bash -c " + %Q["diff -B <(cat ./output-expected-txt/#{item}.txt) <(ruby ./p4vmappinggen.rb -i ./input-sample-json/#{item}.json)\"]
    stdout, stderror, status = Open3.capture3(script)
    ok = (stdout.length == 0)
    print ['test', item, '=>', (ok ? "OK" : "NG")].join(' ') + "\n"
    if (not ok) then
        print stdout
        if (not has_ng) then
            has_ng = true
        end
    end
}

exit (not has_ng)