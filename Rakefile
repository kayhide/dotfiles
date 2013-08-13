$>.sync = true

task :default => [:submodule, :symlink, :elisp]

task :submodule do
  puts "updating git submodules."
  puts `git submodule update --init --recursive`
end

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
end

task :elisp do
  exclusive_putterns = %w(elisp)
  ptn = /#{exclusive_putterns.join('|')}/
  el_files = Dir[".emacs.d/**/*.el"].reject do |f|
    f =~ ptn
  end.sort
  puts "compiling elisp files: (#{el_files.count})"
  puts `emacs --batch -Q -l .emacs.d/init.el -f batch-byte-compile #{el_files.join ' '}`

  puts `rm wget-log*`  if Dir['wget-log*'].any?
end
