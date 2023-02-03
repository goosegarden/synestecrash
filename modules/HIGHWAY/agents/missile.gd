extends MeshInstance

var speed = 72

var ison = false

var timer = 0
var timeout = 10
var dir = Vector3.ZERO

func _process(delta):
	if ison :
#		var dir = (-global_transform.basis.z).normalized()
		global_transform.origin += dir *speed * delta
		timer += delta
		if timer > timeout :
			queue_free()
