extends Enemy


func _ready():
	$EnemyHitboxComponent.area_entered.connect(_on_projectile_hit)
	type = EnemyPlaceholderType.new();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_projectile_hit(projectile: Projectile):
	
