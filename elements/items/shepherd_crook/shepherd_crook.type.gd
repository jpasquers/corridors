extends ItemType

class_name ShepherdCrookType

func _init():
	type_id = "shepherd_crook";
	name = "Shepherd Crook";
	description = "";
	simple_view_path = "res://elements/items/shepherd_crook/shepherd_crook.png"
	rarity = 1;
	attacker_modifiers = [
		AttackerModifier.addIncrRange(0.2)
	];

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
