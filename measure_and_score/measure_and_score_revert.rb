require 'pp'
require 'yaml'

config_yaml = ARGV.shift
config_yaml ||= "./measure_and_score.yml"

configs = YAML.load_file(config_yaml)

unless File.exists?("#{configs[:config_dir]}/.git")
  warn "[Fail] #{configs[:config_dir]} doesn't git dir." 
  exit 1
end

Dir.chdir(configs[:config_dir])

`git reset --hard HEAD^`
