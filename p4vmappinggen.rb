#! /bin/sh
exec ruby -S -x "$0" "$@"
#! ruby

require 'optparse'
require 'json'

opt = OptionParser.new 
opt.on('-i', '--input JSON', 'input file') { |i|
    $json = i
}
special_workspace_root = nil
opt.on('-w', '--workspace-root WORKSPACE_ROOT', 'set(override) workspace root') { |i|
    special_workspace_root = i
}
opt.on('-h', '--help', 'show this help') { puts opt; exit }
opt.parse(ARGV)

if $json.nil? then 
    puts opt
    exit
end

File.open($json) do |file|
    info = JSON.load(file)

    depot_root = info['depot-root'] || ''
    if not depot_root.start_with?('//') then
        exit false
    end

    workspace_root = special_workspace_root || (info['workspace-root'] || '')
    includes = info['mappings']['includes']  || ''
    excludes = info['mappings']['excludes']  || ''

    prefixes = includes.map { '' } + excludes.map { '-' }
    zipped = prefixes.zip(includes + excludes)

    joined = zipped.map { |item|
        prefix = item[0]
        path = item[1]

        uses_default_depot_root = (depot_root == '//')
        depot = prefix + depot_root + (uses_default_depot_root ? '' : '/') + path
        local = workspace_root + '/' + path
        result = %Q["#{depot}"] + ' ' + %Q["#{local}"]
    }.join("\n")
    print joined
end