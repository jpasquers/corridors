class_name LevelStartConfig

var map_config: MapConfig;

var boot_deployable_garrison: BootDeployableGarrison = BootDeployableGarrison.TEST();

var waves_config: WavesConfig;

var boot_player_state: BootPlayerState;

func _init(
	in_map_config: MapConfig,
	in_boot_deployable_garrison: BootDeployableGarrison,
	in_waves_config: WavesConfig,
	in_boot_player_state: BootPlayerState
):
	map_config = in_map_config;
	boot_deployable_garrison = in_boot_deployable_garrison;
	waves_config = in_waves_config;
	boot_player_state = in_boot_player_state;


static func TEST():
	return LevelStartConfig.new(
		MapConfig.new(
			Vector2(40,20),
			0.1,
			2
		),
		BootDeployableGarrison.TEST(),
		WavesConfig.new(
			30,
			50,
			[
				WaveConfig.new(
					EnemyPlaceholderType.new(),
					10,
					1.0
				)
			]
		),
		BootPlayerState.TEST()
	);
