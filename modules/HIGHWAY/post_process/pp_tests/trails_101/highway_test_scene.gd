extends Spatial


#onready var label = $Label
onready var player = $biker



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED




func _process(delta):
	pass
#	label.text = str(player.speed)
