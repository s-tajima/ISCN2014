require 'pp'
require 'digest/md5'

logfile = ARGV.shift
labels  = ARGV


results = Hash.new
logs = open(logfile) 
while log = logs.gets
  next if log.strip.empty?
  record = Hash[log.split("\t").map{|f| f.split(":", 2)}]

  label_val  = Hash.new
  labels.each do |label|
    label_val[label]  = record[label] 
  end

  val_join = label_val.values.join(" ")
  hash = Digest::MD5.hexdigest(val_join) 

  results["#{hash}"]           = label_val if results["#{hash}"].nil?
  results["#{hash}"]['count']  = 0         if results["#{hash}"]['count'].nil?
  results["#{hash}"]['count'] += 1
end

results.each do |hash, result|
  labels.each do |label|
    print "#{result[label]} "
  end
  puts ": #{result['count']}"
end

