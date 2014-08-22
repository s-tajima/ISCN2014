require 'pp'
require 'yaml'
require 'fileutils'
require './manage_config_file_libs.rb'


config_yaml = ARGV.shift
config_yaml ||= "./manage_config_file.yml"


configs = YAML.load_file(config_yaml)

Dir.mkdir(configs[:dest_dir]) unless Dir.exists?(configs[:dest_dir])
Dir.chdir(configs[:dest_dir])

configs[:targets].each do |target|
  gather(target, configs[:dest_dir])
end

