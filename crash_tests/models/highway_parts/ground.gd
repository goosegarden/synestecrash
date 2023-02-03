extends Spatial


onready var mat = $ground.mesh.surface_get_material(0)
var syneses = {}



func _process(delta):
	if syneses.playing :
		mat.albedo_color = (syneses.colors.color2 ) * syneses.colfacs.f2 
#		mat.albedo_color = syneses.colors.color1 * 3.0 * syneses.colfacs.f1 + Color(1.0,1.0,1.0) * 0.8 *  (.4 -syneses.colfacs.f1)
