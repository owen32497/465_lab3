# Gonna be used for bash to call prips when needed
# Essentially a helper function 

prips() {
  cidr=$1

  # range is bounded by network (-n) & broadcast (-b) addresses.
  lo=$(ipcalc -n $cidr |cut -f2 -d=)
  hi=$(ipcalc -b $cidr |cut -f2 -d=)

  read a b c d <<< $(echo $lo |tr . ' ')
  read e f g h <<< $(echo $hi |tr . ' ')

  eval "echo {$a..$e}.{$b..$f}.{$c..$g}.{$d..$h}"
}
