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

configs[:before_commands].each do |command|
  puts `#{command}`
end

puts result = `#{configs[:measure_command]}`

configs[:after_commands].each do |command|
  puts `#{command}`
end

Dir.mkdir("./gather_files/") unless Dir.exists?("./gather_files/")
configs[:gather_target].each do |target|
  puts `cp -r #{target} #{configs[:config_dir]}/gather_files/`
end

`git add -A`
`git commit -m "#{result}"`
`git push`

