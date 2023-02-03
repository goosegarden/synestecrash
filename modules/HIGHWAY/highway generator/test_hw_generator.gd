extends Spatial


onready var hg = $highway_generator_01


func _ready():
	pass # Replace with function body.



func _process(delta):
	hg.update(50, delta)
