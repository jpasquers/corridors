extends ItemType

class_name SimpleWhetstoneType

func _init():
	type_id = "simple_whetstone";
	name = "Simple Whetstone";
	description = "";
	simple_view_path = "res://elements/items/simple_whetstone/simple_whetstone.png"
	rarity = 1;
	attacker_modifiers = [
		AttackerModifier.addBaseDamage(1)
	];

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
