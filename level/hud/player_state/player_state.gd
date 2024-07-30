extends Control

var ka: int;
var lives: int;

signal player_died;

func set_boot_player_state(player_state):
	ka = player_state.ka;
	lives = player_state.lives;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Rows/KaRow/KaValue.text = "[b]" + str(ka) + "[/b]"
	$Rows/LivesRow/LivesValue.text = "[b]" + str(lives) + "[/b]"

func _in_change_ka(amt: int):
	ka += amt;
	$Rows/KaRow/KaValue.text = "[b]" + str(ka) + "[/b]";
	
func _in_change_lives(amt: int):
	lives += amt;
	if lives<0: 
		lives = 0;
		player_died.emit();
	$Rows/LivesRow/LivesValue.text = "[b]" + str(lives) + "[/b]";

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
