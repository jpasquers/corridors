extends Control

var waves_config: WavesConfig;

var DEFAULT_BREAK_BEFORE_WAVES_SEC = 50;
var DEFAULT_BREAK_BETWEEN_WAVES_SEC = 30;

var time_till_next_wave: float = 0;
var wave_in_progress: bool = false;
var up_wave_idx = 0;
var units_left_in_wave = 0;

signal wave_started;
signal spawn_enemy;

func set_waves_config(in_wave_config: WavesConfig):
	waves_config = in_wave_config;
	
func set_time_till_next_wave(time: float):
	time_till_next_wave = time;
	var adjusted = max(round(time_till_next_wave), 0);
	$Time.text = "[center]%s[/center]" % str(adjusted) + "s";
	
	if adjusted == 0:
		start_wave();

# Called when the node enters the scene tree for the first time.
func _ready():
	$WaveUnitTimer.connect("timeout", _on_unit_timer);
	if !waves_config:
		printerr("Must define wave config before scene entry");
	set_time_till_next_wave(get_break_before_waves_sec());

func start_wave():
	wave_started.emit();
	var up_wave_cfg: WaveConfig = waves_config.waves[up_wave_idx];
	units_left_in_wave = up_wave_cfg.count;
	$WaveUnitTimer.wait_time = up_wave_cfg.delay;
	$WaveUnitTimer.start();
	
func _on_unit_timer():
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_time_till_next_wave(time_till_next_wave - delta);

func get_break_before_waves_sec():
	return waves_config.break_before_waves_sec if waves_config else DEFAULT_BREAK_BEFORE_WAVES_SEC;
	
func get_break_between_waves_sec():
	return waves_config.break_between_waves_sec if waves_config else DEFAULT_BREAK_BETWEEN_WAVES_SEC;
