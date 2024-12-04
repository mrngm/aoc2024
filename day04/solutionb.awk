BEGIN {
	FS=""
	term="MAS"
	split(term, termLetters)
	found=0
}
{
	lines[FNR] = $0
	split(lines[FNR], lineSplitted[FNR]);
}
END {
	for (line = 2; line < length(lines); line++) {
		print "[" line "]: " lines[line] ": length: " length(lines[line]);
		for (n = 2; n < length(lines[line]); n++) {
			if (lineSplitted[line][n] != termLetters[2]) {
				print "Did not find '" termLetters[2] "' at offset (" n "," line ")";
				continue;
			}

			forward = 0;
			backslash = 0;

			ne = lineSplitted[line - 1][n+1]
			se = lineSplitted[line + 1][n+1]
			sw = lineSplitted[line + 1][n-1]
			nw = lineSplitted[line - 1][n-1]

			print "  Found '" termLetters[2] "' at offset (" n "," line "); ne/se/sw/nw: " ne "/" se "/" sw "/" nw

			# NorthEast to SouthWest
			if (ne == termLetters[1] && sw == termLetters[3]) {
				print "Matched NE->SW at line " line " starting at offset " n ": " ne termLetters[2] sw
				forward++;
			}

			# SouthEast to NorthWest
			if (se == termLetters[1] && nw == termLetters[3]) {
				print "Matched SE->NW at line " line " starting at offset " n ": " se termLetters[2] nw
				backslash++;
			}

			# SouthWest to NorthEast
			if (sw == termLetters[1] && ne == termLetters[3]) {
				print "Matched SW->NE at line " line " starting at offset " n ": " sw termLetters[2] ne;
				forward++;
			}

			# NorthWest to SouthEast
			if (nw == termLetters[1] && se == termLetters[3]) {
				print "Matched NW->SE at line " line " starting at offset " n ": " nw termLetters[2] se;
				backslash++;
			}
			if (backslash == 1 && forward == 1) {
				found++
			}
		}
	}

	print "Found: " found;
}
