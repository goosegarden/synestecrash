extends Spatial

onready var hw_g = $highway_generator_01
onready var biker = $biker

onready var speed = biker.speed


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func _process(delta):
	speed = biker.speed
	hw_g.update(speed, delta)
