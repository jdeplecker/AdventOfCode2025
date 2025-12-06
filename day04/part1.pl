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
for (my $i = 0; $i < $height; $i++) {   
    for (my $j = 0; $j < $width; $j++) {
        my $neighbours = 0;
        foreach(@dirs) {
            my ($dx, $dy) = @{ $_ };
            my $nx = $j + $dx;
            my $ny = $i + $dy;

            if (0 <= $nx < $width && 0 <= $ny < $height && $rolls_layout[$ny][$nx] =~ '@') {
                $neighbours+=1;
            }
        }
        $result++ if $rolls_layout[$i][$j] =~ '@' && $neighbours < 4;
    }
}
print $result;
