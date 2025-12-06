use v5.35;

open(my $in,  "<",  "day04/input.txt") or die "file not found";
my @rolls_layout = [];
my $height = 0;
my $width = 0;
while (<$in>) { 
    my @row_arr = split("", $_);
    $width = $#row_arr + 1;
    $rolls_layout[$height] = \@row_arr;
    $height++;
}

my @dirs = ([-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]);
my $result = 0;

my $changed = 1;
while($changed) {
    $changed = 0;
    my @counting_grid = ();
    foreach my $i ( 0 .. $height - 1 ) {
    foreach my $j ( 0 .. $width - 1 ) {
        push @{ $counting_grid[$i] }, 0;
    }
    }
    foreach my $i ( 0 .. $height - 1 ) {
        foreach my $j ( 0 .. $width - 1 ) {
            foreach(@dirs) {
                my ($dx, $dy) = @{ $_ };
                my $nx = $j + $dx;
                my $ny = $i + $dy;

                if (0 <= $nx < $width && 0 <= $ny < $height && $rolls_layout[$ny][$nx] =~ '@') {
                    $counting_grid[$i][$j]+=1;
                }
            }
        }
    }
    foreach my $i ( 0 .. $height - 1 ) {
        foreach my $j ( 0 .. $width - 1 ) {
            if ($rolls_layout[$i][$j] =~ '@' && $counting_grid[$i][$j] < 4) {
                $rolls_layout[$i][$j] = '.';
                $result++;
                $changed = 1;
            }
        }
    }
}
print $result;
