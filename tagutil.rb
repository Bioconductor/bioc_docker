#!/usr/bin/env ruby

require 'docker'

basedir = File.dirname(__FILE__)
auth = YAML.load_file(basedir + File::SEPARATOR + 'auth.yml')

@authenticated = false



imagenames = %w(base core flow microarray proteomics sequencing)
repo = 'bioconductor'
versions = %w(release devel)

def get_image_info()
    for version in versions
        for imagename in imagenames
            name = "#{repo}/#{version}_#{imagename}"
            output = `docker run --rm rufus/docker-registry-debug -q info #{name}`
            lines = output.split("\n")
            found_tags = []
            for line in lines
                next if line.start_with? '-'
                found_tags << line.strip.split(' ').first
            end
            puts "#{name} has tags: #{found_tags.join ', '}"
        end
    end
end


#e.g. devel_flow
def retag(name)
    name = "bioconductor/" + name unless name.starts_with? "bioconductor/"
    images = Docker::Image.all
    image = images.find{|i| i.info['RepoTags'].first.start_with? name}
    if image.nil?
        puts "#{name}: no such image found"
        exit 1
    end
    unless @authenticated
        @authenticated = true
        Docker.authenticate!(auth)    
    end
    image.push()
end
