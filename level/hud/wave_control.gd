extends Control

var waves_config: WavesConfig;

var DEFAULT_BREAK_BEFORE_WAVES_SEC = 50;
var DEFAULT_BREAK_BETWEEN_WAVES_SEC = 30;

var time_till_next_wave: float = 0;
var wave_alive: bool = false;
var wave_spawning: bool = false;
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
	
	if adjusted == 0 and !wave_alive:
		start_wave();

# Called when the node enters the scene tree for the first time.
func _ready():
	$WaveUnitTimer.connect("timeout", _on_unit_timer);
	$StartEarly.connect("button_up", _on_start_early);
	if !waves_config:
		printerr("Must define wave config before scene entry");
	set_time_till_next_wave(get_break_before_waves_sec());

func _on_start_early():
	set_time_till_next_wave(0);

func start_wave():
	print("starting wave!");
	wave_started.emit();
	wave_alive = true;
	wave_spawning = true;
	var up_wave_cfg: WaveConfig = waves_config.waves[up_wave_idx];
	units_left_in_wave = up_wave_cfg.count;
	$WaveUnitTimer.wait_time = up_wave_cfg.delay;
	$WaveUnitTimer.start();
	
func _on_unit_timer():
	var type = waves_config.waves[up_wave_idx].unit_type;
	spawn_enemy.emit(type);
	units_left_in_wave-=1;
	if units_left_in_wave <= 0:
		$WaveUnitTimer.stop();
		wave_spawning = false;
	
func _in_wave_ended():
	set_time_till_next_wave(get_break_between_waves_sec());
	wave_alive = false;
	up_wave_idx+=1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_time_till_next_wave(time_till_next_wave - delta);

func get_break_before_waves_sec():
	return waves_config.break_before_waves_sec if waves_config else DEFAULT_BREAK_BEFORE_WAVES_SEC;
	
func get_break_between_waves_sec():
	return waves_config.break_between_waves_sec if waves_config else DEFAULT_BREAK_BETWEEN_WAVES_SEC;
