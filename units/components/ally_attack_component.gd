extends Node2D

signal do_attack;

var range: int;
var attack_delay: float; 
var waiting_for_enemy: bool = false;

var target_queue: Array;

func set_range(in_range):
	range = in_range;

func set_attack_delay(in_attack_delay):
	attack_delay = in_attack_delay;

# Called when the node enters the scene tree for the first time.
func _ready():
	$RangeArea.collision_mask = GlobalConst.ENEMY_COLLISION_LAYER;
	$RangeArea/Range.shape.set_radius(range);
	$RangeArea.area_entered.connect(_on_enemy_enter);
	$AttackTimer.wait_time = attack_delay;
	$AttackTimer.start();
	$AttackTimer.timeout.connect(_on_attack_timer);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_attack_timer():
	if target_queue.size() > 0:
		go(target_queue[0])
	else:
		waiting_for_enemy = true;
	
func _on_enemy_enter(enemy: Enemy):
	target_queue.push_back(enemy);
	if waiting_for_enemy:
		waiting_for_enemy = false;
		go(enemy);
	
func _on_enemy_exit(enemy: Enemy):
	target_queue = target_queue.filter(func x(target):
		return 	target.id != enemy.id
	);
	
func go(enemy: Enemy):
	do_attack.emit(enemy);
	$AttackTimer.start();
