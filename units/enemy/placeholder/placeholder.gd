extends Enemy

func _ready():
	$EnemyHitboxComponent.area_entered.connect(_on_projectile_hit)
	type = EnemyPlaceholderType.new();
	$HealthComponent.init_at(type.base_health);
	$HealthComponent.no_health.connect(_on_no_health);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_projectile_hit(inbound):
	var projectile = inbound.owner;
	if is_instance_of(projectile, Projectile):
		$HealthComponent.lose_health(projectile.damage);
		projectile.queue_free();
	else:
		printerr("well fuck");

func get_static_aim_at():
	return $StaticAimMarker.global_position;

func _on_no_health():
	queue_free();
	died.emit(self);
	
