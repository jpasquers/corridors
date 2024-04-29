class_name WavesConfig

var break_between_waves_sec = 30;
var break_before_waves_sec = 50;
var waves: Array[WaveConfig] = [];

func _init(
	in_break_between_waves_sec,
	in_break_before_waves_sec,
	in_waves
):
	break_between_waves_sec = in_break_between_waves_sec;
	break_before_waves_sec = in_break_before_waves_sec;
	waves = in_waves;
	
