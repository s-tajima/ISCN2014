require 'pp'
require 'yaml'

command     = ARGV.shift
config_yaml = ARGV.shift
config_yaml ||= "./measure_and_score.yml"

available_commands = ["run", "push", "revert"]
exit 1 unless available_commands.include?(command)

`ruby ./measure_and_score_#{command}.rb #{config_yaml}`

