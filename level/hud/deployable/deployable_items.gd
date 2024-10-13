extends DeployableGroup

class_name DeployableItems;

func _ready():
	super();
	Events.player_applied_item.connect(_in_applied_item);

func _on_selected(type: BaseElementType):
	super(type);
	print("Deployable items registered item select");
	if type_selector_map[type.type_id].count > 0:
		Events.player_selected_item_shadow.emit(type);

func _in_applied_item(unit: Garrison, type: ItemType):
	consume(type);

func _process(delta):
	pass
