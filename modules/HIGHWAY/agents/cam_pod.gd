extends Spatial



onready var base = get_parent()
onready var cam_lock = $cam_lock
onready var cam = $cam_lock/Camera

export var mousespeed = Vector2(0.001,0.001)
#export (NodePath) var playerNP 
#var player

var t_y
var t_x



func _ready():
	t_x = rotation.x
	t_y = rotation.y
#	player = get_node(playerNP)

func _process(delta):
	transform.origin.y = lerp(transform.origin.y, base.transform.origin.y, delta )


func _input(event):
	if event is InputEventMouseMotion :
		var r = event.relative

		cam_lock.rotation.y = clamp( cam_lock.rotation.y + r.x * -mousespeed.x, -2.1, 2.1)
		cam.rotation.x = clamp( cam.rotation.x + r.y * -mousespeed.y, -0.6, 0.6)
#
		
		
		
