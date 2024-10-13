extends TabContainer


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func set_boot_deployable_groups(boot_deployable_groups: BootDeployableGroups):
	$Garrison.set_initial_counts_map(boot_deployable_groups.garrison_counts_map);
	$Items.set_initial_counts_map(boot_deployable_groups.item_counts_map);
