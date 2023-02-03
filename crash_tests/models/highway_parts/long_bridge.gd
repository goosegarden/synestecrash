extends Spatial

onready var mat = $bridge_2_long.mesh.surface_get_material(0)
var syneses = {}



func _process(delta):
	if syneses.playing :
		mat.albedo_color = syneses.colors.color2 * 3.0 * syneses.colfacs.f3 + Color(1.0,1.0,1.0) *.6
