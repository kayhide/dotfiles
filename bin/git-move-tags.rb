@force = !!ARGV.delete('-f')
@show = !!ARGV.delete('-s')

@ref = ARGV.last
@ref ||= 'refs/original/refs/heads/master'
@options = '--decorate --oneline --color=never'

@logs = `git log #{@options}`.lines.map(&:chomp)
@ref_logs = `git log #{@ref} #{@options}`.lines.map(&:chomp)

@logs.zip(@ref_logs) do |current, ref|
  if @show
    puts current, ref
  end
  current_comment = current.sub(/^\S* (\(.*?\) )?/, '')
  ref_comment = ref.sub(/^\S* (\(.*?\) )?/, '')
  if ref =~ /tag: ([^,\)]*)/
    tag = $1
    if current_comment == ref_comment
      commit = current.split.first
      puts current
      if @force
        puts `git tag #{tag} #{commit} -f`
      else
        puts "git tag #{tag} #{commit} -f"
      end
    else
      puts "seems commits not matched."
      puts "dst: #{current_comment}"
      puts "src: #{ref_comment}"
    end
    puts
  end
end

unless @force
  puts 'add -f option to execute.'
end
