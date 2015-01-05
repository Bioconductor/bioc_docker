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


CONFIG = YAML.load_file "config.yml"
SEP = File::SEPARATOR

@docker_setup = nil

def setup_docker
    return unless @docker_setup.nil?
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
    @docker_setup = true
end



# basedir = File.dirname(__FILE__) + SEP
# e = Dir.new("out").entries.reject{|i| i.start_with? "."}.find_all{|i| File.directory? "out" + SEP + i}
# for dir in e
#     obj = CONFIG[dir]
#     deps = [:build_files]
#     if obj['data']['parent'].start_with? "bioconductor/"
#         deps << "out" + SEP + obj['data']['parent'].sub('bioconductor/','') \
#             + SEP +  "ticket.txt"
#     end
#     ticketfile = "out" + SEP + dir + SEP + "ticket.txt"
#     puts ticketfile
#     file ticketfile => deps do |t|
#         puts "in target #{t.name}"
#         image_name = "bioconductor/" +  t.name.split(SEP)[1]
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

alldeps = []
mkimg_deps = []
for version_name in CONFIG['versions'].keys
    version_hash= CONFIG['versions'][version_name]
    for container_name in CONFIG['containers'].keys
        taskname = version_name + "_" + container_name
        mkimg_deps << taskname


        vcontainer_name = version_name + "_" + container_name
        container_hash = CONFIG['containers'][container_name]
        parent = container_hash['parent']
        parent = container_hash['parent'].sub("bioconductor/", "bioconductor/#{version_name}_")

        ptasks = []
        if parent.start_with? "bioconductor/"
            ptasks << parent.sub("bioconductor/", "")
        end
        task taskname => ptasks do |t|
           puts "running task #{t.name}..."
           setup_docker
           today = Time.now.strftime "%Y%m%d"
           puts "checking for existing image #{t.name}:#{today}...."
           images = Docker::Image.all
           existing = images.find {|i|i.info['RepoTags'].include? "#{t.name}:#{today}"}
           unless existing.nil?
               puts "found an existing image with id #{existing.id}..."
           end
           puts "building #{t.name} from Dockerfile in out#{SEP}#{t.name}..."
           image = Docker::Image.build_from_dir("out" + SEP + t.name) do |ch|
               puts ch
           end
           if (!existing.nil?) and existing.id.start_with? image.id
               puts "built id matches pre-existing id, skipping tag and push steps..."
               next # this should exit the block??
           end
          ['latest', today].each do |tag|
              puts "tagging #{t.name} with tag #{tag}..."
              image.tag("repo" => "bioconductor/" + t.name, "tag" => tag, "force" => true)
          end
          puts "pushing #{t.name}..."
          image.push()
          puts "push done!"

        end

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
                if t.prerequisites.first.end_with? ".in"
                    puts "building #{t.name} from #{t.prerequisites.first}..."
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
                    erb = ERB.new(File.new(t.prerequisites.first).read, nil, "%")
                    vars_binding = vars.send(:get_binding)
                    out_fh = File.open(t.name, "w")
                    out_fh.write(erb.result(vars_binding)) 
                    out_fh.close()


                else
                    cp t.prerequisites.first, t.name, :preserve => true
                end
            end
        end
        #task vcontainer_name => deps
        desc "merge metadata values into templates (default)"
        task :build_files => alldeps
        #directory destdir # ensure output dir exists, make this a dep of following tasks
    end
end

task :default => :build_files

desc "(re)build all containers that require it"
task :build_all_containers => mkimg_deps
