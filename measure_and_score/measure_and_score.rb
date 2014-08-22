require 'pp'
require 'yaml'

config_yaml = ARGV.shift
config_yaml ||= "./measure_and_score.yml"


configs = YAML.load_file(config_yaml)

pp configs[:measure_command]
puts `#{configs[:measure_command]}`
