require 'pp'
require 'yaml'

config_yaml = ARGV.shift
config_yaml ||= "./measure_and_score.yml"

configs = YAML.load_file(config_yaml)

unless File.exists?("#{configs[:config_dir]}/.git")
  warn "[Fail] #{configs[:config_dir]} doesn't git dir." 
  exit 1
end

puts result = `#{configs[:measure_command]}`

Dir.chdir(configs[:config_dir])
`git add -A`
`git commit -m "#{result}"`
`git push`

