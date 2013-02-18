$>.sync = true

task :default => [:submodule, :symbolic_link, :elisp]
  
task :submodule do
  puts "updating git submodules."
  puts `git submodule update --init --recursive`
end

task :symbolic_link do
  exclusive_files = %w(. .. .git .gitignore .gitmodules)
  Dir["#{Dir.pwd}/.*"].reject do |f|
    exclusive_files.include? File.basename(f)
  end.sort.each do |f|
    puts "making symbolic link: #{f}"
    puts `ln -sf #{f} ~/`
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
