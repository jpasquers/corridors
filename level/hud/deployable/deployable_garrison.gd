extends DeployableGroup

class_name DeployableGarrison;

func _ready():
	super();
	Events.player_placed_unit.connect(_in_placed_unit);

func _on_selected(type: BaseElementType):
	super(type);
	print("Deployable garrison registered unit select");

	if type_selector_map[type.type_id].count > 0:
		Events.player_selected_unit_shadow.emit(type);

func _in_placed_unit(type: UnitType):
	consume(type);
	
func _process(delta):
	pass
