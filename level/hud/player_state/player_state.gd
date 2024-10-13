extends Control

var ka: int;
var lives: int;

signal player_died;

func set_boot_player_state(player_state):
	ka = player_state.ka;
	lives = player_state.lives;

func _ready():
	$Rows/KaRow/KaValue.text = "[right][b]" + str(ka) + "[/b][/right]"
	$Rows/LivesRow/LivesValue.text = "[right][b]" + str(lives) + "[/b][/right]"
	Events.enemy_escaped.connect(enemy_escaped);

func _in_change_ka(amt: int):
	ka += amt;
	$Rows/KaRow/KaValue.text = "[right][b]" + str(ka) + "[/b][/right]";

func enemy_escaped(enemy):
	change_lives(-1);

func change_lives(amt: int):
	lives += amt;
	if lives<0: 
		lives = 0;
		player_died.emit();
	$Rows/LivesRow/LivesValue.text = "[right][b]" + str(lives) + "[/b][/right]";

func _process(delta):
	pass;
