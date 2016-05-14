$>.sync = true

task :default => [:submodule, :symlink, :elisp]

desc 'Update git submodules'
task :submodule do
  puts "updating git submodules."
  puts `git submodule update --init --recursive`
end

desc 'Create symlinks for dotfiles and bin files'
task :symlink do
  exclusive_files = %w(. .. .git .gitignore .gitmodules)
  Dir["#{Dir.pwd}/.*"].reject do |f|
    exclusive_files.include? File.basename(f)
  end.sort.each do |f|
    if RUBY_PLATFORM =~ /cygwin/ && File.directory?(f)
      puts "copying dir: #{f}"
      puts FileUtils.cp_r f, '../'
    else
      puts "making symbolic link: #{f}"
      puts `ln -sf #{f} ~/`
    end
  end
  Dir["#{Dir.pwd}/bin/*"].reject do |f|
    exclusive_files.include? File.basename(f)
  end.sort.each do |f|
    puts "making symbolic link: #{f}"
    puts `ln -sf #{f} ~/bin/`
  end
end

desc 'Create symlink for karabiner'
task :karabiner do
  Dir["#{Dir.pwd}/Karabiner/*.xml"].sort.each do |f|
    puts "making symbolic link: #{f}"
    FileUtils.ln_sf f, File.expand_path('~/Library/Application Support/Karabiner/')
  end
end
