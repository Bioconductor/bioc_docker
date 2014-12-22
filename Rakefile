require 'erb'
require 'ostruct'
require 'yaml'
require 'fileutils'
require 'pp'

class ErbBinding < OpenStruct
    def get_binding
        return binding()
    end
end

desc "create Dockerfiles from templated input (default)"
task :build  do
    basedir = File.dirname(__FILE__)
    config = YAML.load_file(basedir + File::SEPARATOR + "config.yml")
    for key in config.keys
        hsh = config[key]
        source_dir = hsh['source_dir']
        out_dir = hsh['out_dir'].gsub("/", File::SEPARATOR)
        out_dir = source_dir + File::SEPARATOR + "out"
        data = hsh['data']
        infiles = Dir.new(source_dir).entries
        for file in infiles
            next if ['..', '.', 'out'].include? file
            if file.end_with? ".in"
                vars = ErbBinding.new(data)
                erb = ERB.new(File.new(source_dir + File::SEPARATOR + file).read, nil, "%")
                vars_binding = vars.send(:get_binding)
                out_filename = out_dir + File::SEPARATOR + file.sub(/\.in$/, "")
                out_fh = File.open(out_filename, "w")
                out_fh.write(erb.result(vars_binding)) # FIXME only do this if file has changed
                out_fh.close()
            else
                # FIXME only do this if files differ
                FileUtils.cp(source_dir + File::SEPARATOR + file, out_dir)
            end
        end
    end
end

task :default => :build
