BEGIN {
	FS=""
	term="XMAS"
	split(term, termLetters)
	found=0
}
{
	lines[FNR] = $0
	split(lines[FNR], lineSplitted[FNR]);
}
END {
	for (line in lines) {
		print "[" line "]: " lines[line] ": length: " length(lines[line]);
		for (n = 1; n <= length(lines[line]); n++) {
			if (lineSplitted[line][n] != termLetters[1]) {
				print "Did not find '" termLetters[1] "' at offset (" n "," line ")";
				continue;
			}

			north = (strtonum(line) >= length(term));
			east = n + length(term) - 1 <= length(lines[line]);
			south = strtonum(line) + length(term) - 1 <= length(lines);
			west = n - length(term) + 1 >= 1;
			# Match into 8 directions, unless the length of the term would not
			# fit within the array boundaries.

			print "  Found '" termLetters[1] "' at offset (" n "," line "); NESW: " north "/" east "/" south "/" west

			## North
			if (north) {
				matchLength = 1;
				for (tl = 2; tl <= length(term); tl++) {
					if (lineSplitted[line - tl + 1][n] != termLetters[tl]) {
						break;
					}
					matchLength++;
				}
				if (matchLength == length(term)) {
					print "Matched North at line " line " starting at offset " n;
					found++;
				}
			}

			if (north && east) {
				matchLength = 1;
				for (tl = 2; tl <= length(term); tl++) {
					if (lineSplitted[line - tl + 1][n + tl - 1] != termLetters[tl]) {
						break;
					}
					matchLength++;
				}
				if (matchLength == length(term)) {
					print "Matched NorthEast at line " line " starting at offset " n;
					found++;
				}
			}

			## East
			if (east) {
				matchLength = 1;
				for (tl = 2; tl <= length(term); tl++) {
					if (lineSplitted[line][n + tl - 1] != termLetters[tl]) {
						break;
					}
					matchLength++;
				}
				if (matchLength == length(term)) {
					print "Matched East at line " line " starting at offset " n;
					found++;
				}
			}

			if (south && east) {
				matchLength = 1;
				for (tl = 2; tl <= length(term); tl++) {
					if (lineSplitted[line + tl - 1][n + tl - 1] != termLetters[tl]) {
						break;
					}
					matchLength++;
				}
				if (matchLength == length(term)) {
					print "Matched SouthEast at line " line " starting at offset " n;
					found++;
				}
			}

			## South
			if (south) {
				matchLength = 1;
				for (tl = 2; tl <= length(term); tl++) {
					if (lineSplitted[line + tl - 1][n] != termLetters[tl]) {
						break;
					}
					matchLength++;
				}
				if (matchLength == length(term)) {
					print "Matched South at line " line " starting at offset " n;
					found++;
				}
			}

			if (south && west) {
				matchLength = 1;
				for (tl = 2; tl <= length(term); tl++) {
					if (lineSplitted[line + tl - 1][n - tl + 1] != termLetters[tl]) {
						break;
					}
					matchLength++;
				}
				if (matchLength == length(term)) {
					print "Matched SouthWest at line " line " starting at offset " n;
					found++;
				}
			}

			## West
			if (west) {
				matchLength = 1;
				for (tl = 2; tl <= length(term); tl++) {
					if (lineSplitted[line][n - tl + 1] != termLetters[tl]) {
						break;
					}
					matchLength++;
				}
				if (matchLength == length(term)) {
					print "Matched West at line " line " starting at offset " n;
					found++;
				}
			}

			if (north && west) {
				matchLength = 1;
				for (tl = 2; tl <= length(term); tl++) {
					if (lineSplitted[line - tl + 1][n - tl + 1] != termLetters[tl]) {
						break;
					}
					matchLength++;
				}
				if (matchLength == length(term)) {
					print "Matched NorthWest at line " line " starting at offset " n;
					found++;
				}
			}
		}
	}

	print "Found: " found;
}
