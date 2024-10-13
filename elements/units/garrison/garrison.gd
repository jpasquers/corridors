extends GridUnit

class_name Garrison

signal update_stats;

var stats: AttackerStats;
var bound_items: Array[ItemType];
var active_targets: Array[Enemy];

func _ready():
	pass

func _process(delta):
	pass

func apply_item(in_item_type: ItemType):
	print("Apply item type " + in_item_type.type_id + " To unit " + str(id));
	bound_items.push_back(in_item_type);
	stats = AttackerModifier.apply_all(stats, in_item_type.attacker_modifiers);
	update_stats.emit(stats);

func unapply_item(in_item_type: ItemType):
	#Note that there can be multiple items of a type.
	#Only remove the first.
	var removed = false;
	bound_items = bound_items.filter(func(bound_item):
		if (bound_item.type_id == in_item_type.type_id and !removed):
			removed = true;
			return false;
	);
	stats = AttackerModifier.unapply_all(stats, in_item_type.attack_modifiers);
