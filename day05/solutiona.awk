BEGIN {
	numPageRules = 0
	numPageOrders = 0
}
{
	if ($0 ~ /^[0-9]+\|[0-9]+$/) {
		# Page rules
		numPageRules++
		split($0, pageRules[numPageRules], /\|/)
	}

	if ($0 ~ /,/) {
		# Page orders
		numPageOrders++
		split($0, pageOrders[numPageOrders], /,/)
	}
}
END {
	for (p = 1; p <= numPageOrders; p++) {
		middleIndex = int(length(pageOrders[p]) / 2) + 1
		middle = pages[p][middleIndex]

		for (page = 1; page <= length(pageOrders[p]); page++) {
			for (rule = 1; rule <= length(pageRules); rule++) {
				if (strtonum(pageRules[rule][1]) == strtonum(pageOrders[p][page])) {
					print "Found rule " pageRules[rule][1] " (rulenum: " rule ") in pageOrder " p " nr " page " value: " pageOrders[p][page]
				}
			}
		}
	}
}
