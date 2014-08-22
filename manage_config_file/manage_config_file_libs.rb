#
# gather
#

def gather(path, dest_dir, dry_run = false)
  unless File.exists?(path)
    warn "[Skip] #{path} doesn't exists." 
    return false
  end
  type = File.ftype(path)

  return gather_file(path, dest_dir)      if type == "file"
  return gather_directory(path, dest_dir) if type == "directory"

  warn "[Skip] #{path} unexpected file type." 
  return false
end

def gather_file(path, dest_dir)
  unless FileUtils.move(path, dest_dir)
    warn "[Skip] #{path} move file failed." 
    return
  end

  unless File.symlink("#{dest_dir}/#{File.basename(path)}", path) 
    warn "[Skip] #{path} create symlink failed." 
    return
  end

  puts "[OK] #{path} gathered."
end

def gather_directory(path, dest_dir)
  gather_file(path, dest_dir)
end

#
# extract
#
def extract(path, dest_dir, dry_run = false)
  unless File.exists?(path)
    warn "[Skip] #{path} doesn't exists." 
    return false
  end
  type = File.ftype(path)

  return extract_file(path, dest_dir)      if type == "file"
  return extract_directory(path, dest_dir) if type == "directory"

  warn "[Skip] #{path} unexpected file type." 
  return false
end

def extract_file(path, dest_dir)
  unless File.delete(path)
    warn "[Skip] #{path} remove file failed." 
    return
  end

  unless File.symlink("#{dest_dir}/#{File.basename(path)}", path) 
    warn "[Skip] #{path} create symlink failed." 
    return
  end

  puts "[OK] #{path} extracted."
end

def extract_directory(path, dest_dir)
  unless FileUtils.rm_rf(path)
    warn "[Skip] #{path} remove directory failed." 
    return
  end

  unless File.symlink("#{dest_dir}/#{File.basename(path)}", path) 
    warn "[Skip] #{path} create symlink failed." 
    return
  end

  puts "[OK] #{path} extracted."
end
