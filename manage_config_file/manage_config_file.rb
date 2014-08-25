require 'pp'
require 'yaml'

command     = ARGV.shift
config_yaml = ARGV.shift
config_yaml ||= "./manage_config_file.yml"

available_commands = ["gather", "push", "clone", "extract"]
exit 1 unless available_commands.include?(command)

puts `ruby ./manage_config_file_#{command}.rb #{config_yaml}`

