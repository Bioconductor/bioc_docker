require 'erb'
require 'ostruct'
require 'yaml'
require 'fileutils'
require 'pp'
require 'rake'
require 'rake/clean'
require 'pp'

require 'docker'

require 'pry' # remove this line

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

####task :default => :build

# increase read and write timeouts to 2 hours
timeout = (60 * 60) * 2
Excon.defaults[:write_timeout] = timeout
Excon.defaults[:read_timeout] = timeout


# if defined? ENV['DOCKER_HOST']
#     puts "setting docker url"
#     Docker.url = ENV['DOCKER_HOST']
# end
# auth = YAML.load_file('auth.yml')

# Docker.authenticate!(auth)

# basedir = File.dirname(__FILE__) + File::SEPARATOR
# config = YAML.load_file(basedir + File::SEPARATOR + "config.yml")
# e = Dir.new("out").entries.reject{|i| i.start_with? "."}.find_all{|i| File.directory? "out" + File::SEPARATOR + i}
# for dir in e
#     obj = config[dir]
#     deps = [:build]
#     if obj['data']['parent'].start_with? "bioconductor/"
#         deps << "out" + File::SEPARATOR + obj['data']['parent'].sub('bioconductor/','') \
#             + File::SEPARATOR +  "ticket.txt"
#     end
#     ticketfile = "out" + File::SEPARATOR + dir + File::SEPARATOR + "ticket.txt"
#     puts ticketfile
#     file ticketfile => deps do |t|
#         puts "in target #{t.name}"
#         image_name = "bioconductor/" +  t.name.split(File::SEPARATOR)[1]
#         puts "image_name is #{image_name}"
#         today = Time.now.strftime "%Y%m%d"
#         puts "checking for existing image #{image_name}:#{today}...."
#         images = Docker::Image.all
#         existing = images.find {|i|i.info['RepoTags'].include? "#{image_name}:#{today}"}
#         unless existing.nil?
#             puts "found an existing image with id #{existing.id}..."
#         end
#         puts "building #{image_name} from Dockerfile in #{File.dirname(t.name)}..."
#         image = Docker::Image.build_from_dir(File.dirname(t.name)) do |ch|
#             puts ch
#         end
#         if (!existing.nil?) and existing.id.start_with? image.id
#             puts "built id matches pre-existing id, skipping tag and push steps..."
#             next # this should exit the block??
#         end
#         ['latest', today].each do |tag|
#             puts "tagging #{image_name} with tag #{tag}..."
#             image.tag("repo" => image_name, "tag" => tag, "force" => true)
#         end
#         puts "pushing #{image_name}..."
#         image.push()
#         puts "push done!"
#         touch t.name
#     end
# end

# task :phony do
#     puts "phony"
# end

# puts "yow"


# make these portable:
# infiles = Rake::FileList["src" + sep + "**" + sep  + "*.in", "common" + sep + "*.in"]
# copyfiles = Rake::FileList.new("src" + sep + "**" + sep + "*", "common" + sep + "*") do |fl|
#     fl.exclude(/\.in$/)
#     fl.exclude do |f|
#         File.directory? f
#     end
# end

# common_files = Rake::FileList["common" + sep + "*"]

CONFIG = YAML.load_file "config.yml"
SEP = File::SEPARATOR
alldeps = []
for version_name in CONFIG['versions'].keys
    version_hash= CONFIG['versions'][version_name]
    for container_name in CONFIG['containers'].keys
        vcontainer_name = version_name + "_" + container_name
        container_hash = CONFIG['containers'][container_name]
        srcdir = "src" + SEP + container_name
        destdir = "out" + SEP + version_name + "_" + container_name
        copyfiles = Rake::FileList.new(srcdir + SEP + "**" + SEP + "*", "common" + SEP + "*") do |fl|
            fl.exclude(/\.in$/)
            fl.exclude do |f|
                File.directory? f
            end
        end
        infiles = Rake::FileList[srcdir + SEP + "**" + SEP  + "*.in", "common" + SEP + "*.in"]
        deps = []
        for inputfile in copyfiles + infiles
            destfile = inputfile.sub(/#{srcdir}|common/, destdir)
            destfile = destfile.sub(/\.in$/, "") if inputfile.end_with? ".in"
            deps << destfile
            alldeps << destfile
            CLOBBER.include(destfile)
            file destfile => inputfile do |t|
                if t.source.end_with? ".in"
                    puts "building #{t.name} from #{t.source}..."
                    # in here you can't refer to anything outside, only 't'
                    vcont_name = t.name.split(SEP)[1]
                    version, cont_name = vcont_name.split('_')
                    vhash = CONFIG.dup['versions'][version]
                    # make a read/only copy to get around some weirdness
                    rodata = CONFIG.dup['containers'][cont_name]
                    data = rodata.dup
                    if data['parent'].start_with? "bioconductor/"
                        data['parent'] = rodata['parent'].sub("bioconductor/", "bioconductor/#{version}_")
                    end
                    data['image_name'] = "bioconductor/#{vcont_name}"
                    data['r_url'] = vhash['r_url']
                    data['bioc_version'] = vhash['version_number']
                    vars = ErbBinding.new(data)
                    erb = ERB.new(File.new(t.source).read, nil, "%")
                    vars_binding = vars.send(:get_binding)
                    out_fh = File.open(t.name, "w")
                    out_fh.write(erb.result(vars_binding)) 
                    out_fh.close()


                else
                    cp t.source, t.name, :preserve => true
                end
            end
        end
        task vcontainer_name => deps
        task :build_files => alldeps
        #directory destdir # ensure output dir exists, make this a dep of following tasks
    end
end

task :default => :build_files

