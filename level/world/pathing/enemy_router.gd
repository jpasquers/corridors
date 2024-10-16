extends Path2D

class_name EnemyRouter

# The point pathing as a list of list of points.
# 0 -> path from Start to checkpoint 1.
# 1 -> path from checkpoint 1 to checkpoint 2.
# And so on.
var point_paths: Array[PackedVector2Array];

var followers = [];

@onready var follow_template = preload("res://level/world/pathing/enemy_follow_route.tscn");

func _ready():
	pass;


func add_enemy(enemy: Enemy):
	var follow = follow_template.instantiate();
	add_child(follow);
	followers.push_back(follow);
	follow.bind_recipient(enemy);
	follow.reached_end.connect(_on_reached_end);

# Generate and bind a single curve2d from the list of paths
# (Since path2d requires a curve2d)
func rebuild_follow_curve(in_point_paths):
	point_paths = in_point_paths;
	var all = [];
	for path in point_paths:
		all.append_array(path);
	var curve = Curve2D.new();
	for point in all:
		curve.add_point(point);
	set_curve(curve);
	
	
func _on_reached_end(follower: EnemyFollowRoute):
	followers = followers.filter(func do(a_follower):
		return a_follower != follower;
	)
	if (is_instance_valid(follower.get_recipient())):
		Events.enemy_escaped.emit(follower.get_recipient());
		follower.get_recipient().queue_free();
	follower.queue_free();

func _process(delta):
	for follower in followers:
		follower.do_progress(3);
