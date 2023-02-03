extends MeshInstance

var speed = 10


func _ready():
	speed += randi()%25 -5



func _process(delta):
	global_transform.origin += -global_transform.basis.z.normalized() * delta * speed
	if global_transform.origin.z < -630 :
		global_transform.origin.z = 40
	if global_transform.origin.z > 40 :
		global_transform.origin.z = -630
