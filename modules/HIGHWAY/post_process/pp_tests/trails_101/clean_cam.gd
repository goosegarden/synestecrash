extends Camera


onready var player_cam = get_tree().get_nodes_in_group("player_cam")[0]

func _ready():
	pass # Replace with function body.



func _process(delta):
	var t = Transform( player_cam.global_transform)
	global_transform = t
