@ref = 'refs/original/refs/heads/master'
@options = '--decorate --oneline --color=never'

@logs = `git log #{@options}`.lines.map(&:chomp)
@ref_logs = `git log #{@ref} #{@options}`.lines.map(&:chomp)

@logs.zip(@ref_logs) do |current, ref|
  if ref =~ /tag: ([^,\)]*)/
    tag = $1
    commit = current.split.first
    puts current, ref
    puts `git tag #{tag} #{commit} -f`
    puts
  end
end
