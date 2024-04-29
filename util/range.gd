func get_range_val(min, max, interval):
	var vals = [];
	var val = min;
	while (val <= max):
		vals.push_back(val);
		val+= interval;
	return vals.pick_random();
