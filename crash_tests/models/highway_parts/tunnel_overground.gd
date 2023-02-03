extends Spatial


onready var mat = $tunnel_overground.mesh.surface_get_material(0)
var syneses = {}


func _process(delta):
	if syneses.playing :
#		mat.albedo_color = (syneses.colors.color2 ) * 2.0 * syneses.colfacs.f1 
		mat.albedo_color = syneses.colors.color2  * syneses.colfacs.f1 
