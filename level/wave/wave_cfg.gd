class_name WaveConfig

var unit_type: UnitType;
var count: int;
# In seconds
var delay: float;

func _init(
	in_unit_type,
	in_count,
	in_delay
):
	unit_type = in_unit_type;
	count = in_count;
	delay = in_delay;
