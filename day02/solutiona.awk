BEGIN {
	unsafe = 0; safe = 0; MINDEV=1; MAXDEV=3 
} {
	last = $1; lastdir = 0; dir = 0;
	print "RECORD (NF: " NF "): "  $RS;
	for ( pos = 2; pos <= NF; pos++) {
		print "  FIELD " $pos " last: " last;
		if (last < $pos) {
			print "  setting dir pos"; dir = 1 
		}
		if (last > $pos) {
			print " setting dir neg"; dir = -1 
		}
		if (last <= $pos && ($pos-last > MAXDEV || $pos-last < MINDEV)) {
			print "  last <= pos: diff: " $pos - last;
			unsafe++ 
			next;
		}
		if (last >= $pos && (last-$pos > MAXDEV || last-$pos < MINDEV)) {
			print "  last >= pos: diff: " last-$pos;
			unsafe++;
			next;
		}
		if (pos > 2 && dir != lastdir) {
			print "  pos > 2, lastdir != dir: " lastdir " != " dir;
			unsafe++;
			next;
		} else {
			lastdir = dir;
		}
		print "  last: " last " / lastdir: " lastdir " / pos: " pos " / record: " $RS;
		last = $pos;
	}
	safe++
}
END {
	print "unsafe: " unsafe ", safe: " safe;
}
