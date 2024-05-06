class_name LevelStartConfig

var map_config: MapConfig;

var boot_deployable_garrison: BootDeployableGarrison = BootDeployableGarrison.TEST();

var waves_config: WavesConfig;

func _init(
	in_map_config: MapConfig,
	in_boot_deployable_garrison: BootDeployableGarrison,
	in_waves_config: WavesConfig
):
	map_config = in_map_config;
	boot_deployable_garrison = in_boot_deployable_garrison;
	waves_config = in_waves_config;


static func TEST():
	return LevelStartConfig.new(
		MapConfig.new(
			Vector2(60,30),
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
		)
	);
