#!/usr/bin/env ruby

require 'docker'
require 'open3'

basedir = File.dirname(__FILE__)
@auth = YAML.load_file(basedir + File::SEPARATOR + 'auth.yml')
@imagenames = %w(base core flow microarray proteomics sequencing)
@versioned_imagenames = []
%w(release devel).each do |version|
    @imagenames.each do |name|
        @versioned_imagenames << "#{version}_#{name}"
    end
end


@authenticated = false



def get_image_info()
    repo = 'bioconductor'
    versions = %w(release devel)
    for version in versions
        for imagename in @imagenames
            name = "#{repo}/#{version}_#{imagename}"
            output = `docker run --rm rufus/docker-registry-debug -q info #{name}`
            lines = output.split("\n")
            found_tags = []
            for line in lines
                next if line.start_with? '-'
                found_tags << line.strip.split(' ').first
            end
            puts "#{name} has tags: #{found_tags.sort.join ', '}"
        end
    end
end

def get_local_image_info(name)
    name = "bioconductor/" + name unless name.start_with? "bioconductor/"
    images = Docker::Image.all
    image = images.find{|i| i.info['RepoTags'].first.start_with? name}
    if image.nil?
        puts "#{name}: no such image found"
        return
    end
    image.info['RepoTags']    
end

#e.g. devel_flow
def retag(name)
    name = "bioconductor/" + name unless name.start_with? "bioconductor/"
    images = Docker::Image.all
    image = images.find{|i| i.info['RepoTags'].first.start_with? name}
    if image.nil?
        puts "#{name}: no such image found"
        return
    end
    # unless @authenticated
    #     Docker.authenticate!(@auth)    
    #     @authenticated = true
    # end
    # image.push()
    # use docker executable instead of api
    # because api pushes seem flaky
    cmd = "docker push #{name}:latest"
    Open3.popen2e(cmd) do |stdin, stdout_err, wait_thr|
        while line = stdout_err.gets
            puts line
        end

      exit_status = wait_thr.value
      unless exit_status.success?
          abort "FAILED !!! '#{cmd}' returned exit code #{exit_status.exitstatus}"
      end
    end

end
