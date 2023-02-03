extends Spatial


onready var lmg = $land_mesh_gen_01

func _ready():
	var m = lmg.generate()
	add_child(m)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
