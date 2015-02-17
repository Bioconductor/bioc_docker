require 'erb'
require 'ostruct'
require 'yaml'
require 'fileutils'
require 'pp'
require 'open3'
require 'rake'
require 'rake/clean'

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
    require 'docker'
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
        if parent =~ /bogus/
          parent = version_hash['parent']
        end
        ptasks = []
        ptasks << parent
        if parent.start_with? "bioconductor/"
            ptasks << parent.sub("bioconductor/", "")
        end
        task taskname => ptasks do |t|
           puts "running task #{t.name}..."
           setup_docker
           today = Time.now.strftime "%Y%m%d"
           puts "checking for existing image #{t.name}:#{today}...."
           images = Docker::Image.all
           existing = images.find {|i|i.info['RepoTags'].include? "bioconductor/#{t.name}:#{today}"}
           unless existing.nil?
               puts "found an existing image with id #{existing.id}..."
           end
           puts "building #{t.name} from Dockerfile in out#{SEP}#{t.name}..."
           image = Docker::Image.build_from_dir("out" + SEP + t.name) do |ch|
               puts ch
           end
           if (!existing.nil?) and existing.id.start_with? image.id
               puts "built id matches pre-existing id, skipping tag and push steps..."
               next # exit the block
           end
          wanted_tags = ['latest', today]
          wanted_tags.each do |tag|
              puts "tagging #{t.name} with tag #{tag}..."
              image.tag("repo" => "bioconductor/" + t.name, "tag" => tag, "force" => true)
          end
          puts "image tags are: #{image.info['RepoTags'].join(", ")}"
          puts "pushing #{t.name}..."
          # see if this fixes pushing issues:
          # image_to_push = images.find{|i| i.info['RepoTags'].include? "bioconductor/#{t.name}:latest"}
          # image_to_push.push()
          # use docker executable instead of api
          # because api pushes seem flaky

          cmd = "docker push bioconductor/#{t.name}"
          Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
              while line = stdout_err.gets
                  puts line
              end

              exit_status = wait_thr.value
              unless exit_status.success?
                  abort "FAILED !!! '#{cmd}' returned exit code #{exit_status.exitstatus}"
              end
          end
          puts "push done!"
          # confirm that image in repo is properly tagged
          output = `docker run --rm rufus/docker-registry-debug -q info bioconductor/#{t.name}`
          lines = output.split("\n")
          found_tags = []
          puts "inspecting tags in image on hub..."
          for line in lines
              next if line.start_with? '-'
              tag = line.strip.split(" ").first
              puts "found tag #{tag}..."
              found_tags << tag
          end
          # if wanted_tags.sort == found_tags.sort
          #     puts "tags matched!"
          # else
          #   puts "tags did not match, retrying"
          # end
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
                source = (t.source.nil?) ? t.prerequisites.first : t.source
                if source.end_with? ".in"
                    puts "building #{t.name} from #{source}..."
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
                    if data['parent'] == 'bogus'
                      data['parent'] = vhash['parent']
                    end
                    data['image_name'] = "bioconductor/#{vcont_name}"
                    data['r_url'] = vhash['r_url']
                    data['bioc_version'] = vhash['version_number']
                    vars = ErbBinding.new(data)
                    erb = ERB.new(File.new(source).read, nil, "%")
                    vars_binding = vars.send(:get_binding)
                    out_fh = File.open(t.name, "w")
                    out_fh.write(erb.result(vars_binding)) 
                    out_fh.close()


                else
                    cp source, t.name, :preserve => true
                end
            end
        end
        desc "merge metadata values into templates (default)"
        task :build_files => alldeps
    end
end

task :default => :build_files

desc "(re)build all containers that require it"
task build_all_containers:  mkimg_deps


# be careful using the following...it could theoretically
# try and build 8 containers at once (all leaf containers
# for release and devel) which could use a lot of memory
# and other resources.
desc "in parallel, (re)build all containers that require it"
multitask parallel_build_all_containers:  mkimg_deps
