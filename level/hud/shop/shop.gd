extends Control

var open: bool = false;


func _ready():
	$OpenShop.connect("button_up", _on_open_shop)
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_released("shop_alt"):
		_on_alt_shop();

func _on_open_shop():
	open = true;
	$ShopBody/Anims.play("open");

func _on_close_shop():
	open = false;
	$ShopBody/Anims.play_backwards("open");
	
func _on_alt_shop():
	if (open):
		_on_close_shop();
	else:
		_on_open_shop();
