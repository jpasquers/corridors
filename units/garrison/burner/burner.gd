extends Garrison

class_name Burner

@onready var attacker: AttackComponent = $AttackComponent;

func _ready():
	type = BurnerType.new();
	attacker.set_attack_delay(type.base_attack_speed);
	attacker.set_range(type.base_range);
	attacker.do_attack.connect(_on_do_attack);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_do_attack(target_queue):
	for target in target_queue:
		target.inbound_damage(1);
