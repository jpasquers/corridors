extends Garrison

class_name Archer

@onready var attacker: AttackComponent = $AttackComponent;

@onready var arrow_scene = preload("res://projectiles/arrows/basic_arrow.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	type = ArcherType.new();
	attacker.set_attack_delay(type.base_attack_speed);
	attacker.set_range(type.base_range);
	attacker.do_attack.connect(_on_do_attack);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_do_attack(target_queue):
	var arrow = arrow_scene.instantiate();
	arrow.damage = 3;
	arrow.projectile_speed = 1200;
	arrow.pierce = 0;
	arrow.position = $ArrowStart.position;
	arrow.fixed_target = target_queue[0].get_forward_position();
	add_child(arrow);
