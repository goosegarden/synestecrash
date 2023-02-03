extends KinematicBody


var speed = 24

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed += rand_range(2, 20)



func _process(delta):
	global_transform.origin += speed * delta * (-global_transform.basis.z.normalized())
	if global_transform.origin.z < -630 :
		global_transform.origin.z = 50
	if global_transform.origin.z > 100 :
		global_transform.origin.z = -600
	
