#!/usr/bin/perl

use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

my $file = $ARGV[0] or die "Need to get CSV file on the command line\n";

open(my $data, '<', $file) or die "Could not open '$file' $!\n";

my $largestDiff;
my $largestDiffDay;
while (my $line = <$data>) {
	chomp $line;

	if (length($line) != 0) {
		my @fields = split /\s+/ , $line;

		my $day = $fields[1];
		if (looks_like_number($day)) {
			# asterix* annotates min/max temp value in month
			my $dayMax = $fields[2];
			$dayMax =~ s/\*//;

			my $dayMin = $fields[3];
			$dayMin =~ s/\*//;

			my $dayDiff = $dayMax - $dayMin;

			print "day $day => diff $dayDiff° (max $dayMax° - min $dayMin°)\n";

			if (!defined $largestDiff || $dayDiff > $largestDiff) {
				$largestDiff = $dayDiff;
				$largestDiffDay = $day;
			}
		}
	}
}

print "\nweirdest day is day $largestDiffDay ($largestDiff° diff)";
