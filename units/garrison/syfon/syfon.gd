extends Garrison

@onready var attacker: AttackComponent = $AttackComponent;

var current_target_id: int;


# Called when the node enters the scene tree for the first time.
func _ready():
	type = SyfonType.new();
	stats = SyfonAttackerStats.new(type);
	attacker.set_attack_delay(type.starting_base_attack_speed);
	attacker.set_range(type.starting_base_range);
	attacker.do_attack.connect(_on_do_attack);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# TODO: do ramp based on target.
func _on_do_attack(target_queue):
	target = target_queue[0]; # for now.
	
