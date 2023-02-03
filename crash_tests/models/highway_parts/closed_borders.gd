extends Spatial



#onready var mat = $flat_road.mesh.surface_get_material(0)
onready var mat = $closed_borders.mesh.surface_get_material(0)
var syneses = {}



func _process(delta):
	if syneses.playing :
#		var f = (max(0.1, syneses.colfacs.f1)-0.1) * 10.0
#		mat.albedo_color = syneses.colors.color2 * f
#		mat.albedo_color = syneses.colors.color2 * 3.0 * syneses.colfacs.f2 + Color(1.0,1.0,1.0) *.2
#		mat.albedo_color = syneses.colors.color2 * 3.0 * syneses.colfacs.f2
		mat.albedo_color = syneses.colors.color2 * 3.0 * syneses.colfacs.f3 + Color(1.0,1.0,1.0) *.6
