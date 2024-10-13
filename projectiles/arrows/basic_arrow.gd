extends Projectile

var fixed_target: Vector2;

func _ready():
	$Area.area_entered.connect(_on_projectile_hit);
	look_at(fixed_target);


func _process(delta):
	global_position += transform.x * projectile_speed*delta;

func _on_projectile_hit(enemy_area):
	var enemy = enemy_area.owner;
	if is_instance_of(enemy, Enemy):
		enemy.inbound_damage(damage);
		queue_free();
