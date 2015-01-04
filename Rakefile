require 'erb'
require 'ostruct'
require 'yaml'
require 'fileutils'
require 'pp'
require 'rake'
require 'pp'

require 'docker'

class ErbBinding < OpenStruct
    def get_binding
        return binding()
    end
end

desc "create Dockerfiles from templated input (default)"
task :build  do
    puts "in build"
    basedir = File.dirname(__FILE__) + File::SEPARATOR
    config = YAML.load_file(basedir + File::SEPARATOR + "config.yml")
    for key in config.keys
        hsh = config[key]
        common_dir = basedir + "common"
        source_dir = basedir +  hsh['source_dir']
        out_dir = basedir + hsh['out_dir'].gsub("/", File::SEPARATOR)
        unless File.exists? out_dir
            FileUtils::mkdir_p out_dir
        end
        data = hsh['data']
        infiles = Dir.new(source_dir).entries.reject{|i| i == "." or i == ".."}
        infiles = infiles.map{|i| source_dir + File::SEPARATOR + i}
        common_files = Dir.new(common_dir).entries.reject{|i| i == "." or i == ".."}
        common_files = common_files.map{|i| common_dir + File::SEPARATOR + i}

        for file in infiles+common_files
            if file.end_with? ".in"
                vars = ErbBinding.new(data)
                erb = ERB.new(File.new(file).read, nil, "%")
                vars_binding = vars.send(:get_binding)
                out_filename = out_dir + File::SEPARATOR + File.basename(file).sub(/\.in$/, "")
                out_fh = File.open(out_filename, "w")
                out_fh.write(erb.result(vars_binding)) # FIXME only do this if file has changed
                out_fh.close()
            else
                # FIXME only do this if files differ
                FileUtils.cp(file, out_dir, :preserve => true)
            end
        end
    end
end

task :default => :build

# increase read and write timeouts to 2 hours
timeout = (60 * 60) * 2
Excon.defaults[:write_timeout] = timeout
Excon.defaults[:read_timeout] = timeout


if defined? ENV['DOCKER_HOST']
    puts "setting docker url"
    Docker.url = ENV['DOCKER_HOST']
end
auth = YAML.load_file('auth.yml')

Docker.authenticate!(auth)

basedir = File.dirname(__FILE__) + File::SEPARATOR
config = YAML.load_file(basedir + File::SEPARATOR + "config.yml")
e = Dir.new("out").entries.reject{|i| i.start_with? "."}.find_all{|i| File.directory? "out" + File::SEPARATOR + i}
for dir in e
    obj = config[dir]
    deps = [:build]
    if obj['data']['parent'].start_with? "bioconductor/"
        deps << "out" + File::SEPARATOR + obj['data']['parent'].sub('bioconductor/','') \
            + File::SEPARATOR +  "ticket.txt"
        puts 'deps:'
        pp deps
    end
    ticketfile = "out" + File::SEPARATOR + dir + File::SEPARATOR + "ticket.txt"
    puts ticketfile
    file ticketfile => deps do |t|
        puts "in target #{t.name}"
        image_name = "bioconductor/" +  t.name.split(File::SEPARATOR)[1]
        puts "image_name is #{image_name}"
        puts "building #{image_name} from Dockerfile in #{File.dirname(t.name)}..."
        image = Docker::Image.build_from_dir File.dirname(t.name)
        today = Time.now.strftime "%Y%m%d"
        ['latest', today].each do |tag|
            puts "tagging #{image_name} with tag #{tag}..."
            image.tag("repo" => image_name, "tag" => tag, "force" => true)
        end
        puts "pushing #{image_name}..."
        image.push()
        puts "push done!"
        touch ticketfile
    end
end

task :phony do
    puts "phony"
end

puts "yow"
