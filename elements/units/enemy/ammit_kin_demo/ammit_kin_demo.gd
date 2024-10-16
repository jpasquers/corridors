extends Enemy

func _ready():
	type = AmmitKinDemoType.new();
	$HealthComponent.init_at(type.base_health);
	$HealthComponent.no_health.connect(_on_no_health);
	$UnitAnim/AnimationPlayer.play("move_left");

func _process(delta):
	pass
	
	
func inbound_damage(damage: int):
	$HealthComponent.lose_health(damage);

func get_forward_global_position():
	return $ForwardMarker.global_position;

func _on_no_health():
	queue_free();
	died.emit(self);
	
