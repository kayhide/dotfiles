{ runCommand
, makeWrapper
, kakoune
}:

runCommand "my-kakoune"
{
  buildInputs = [ makeWrapper kakoune ];
} ''
  mkdir -p $out/bin
  ln -s ${kakoune}/bin/kak $out/bin/kak
  wrapProgram $out/bin/kak \
    --unset LD_LIBRARY_PATH
''
