extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#Enemies are hit by ally projectiles.
	collision_mask = GlobalConst.ALLY_PROJECTILE_COLLISION_LAYER;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
