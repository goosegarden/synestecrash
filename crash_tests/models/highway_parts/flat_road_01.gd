extends Spatial


onready var mat = $flat_road.mesh.surface_get_material(0)
var syneses = {}



func _process(delta):
	if syneses.playing :
		var c1 = syneses.colors.color1
		mat.set_shader_param("col", Vector3(c1.r, c1.g, c1.b) )
		mat.set_shader_param("fac", syneses.colfacs.f1 )
		mat.set_shader_param("playing", true )
		
	else : 
		mat.set_shader_param("col", Vector3(1.0,1.0,1.0) )
		mat.set_shader_param("fac", 0.0 )
#		var f = (max(0.08, syneses.colfacs.f1)-0.08) * 9.0
#		var f = syneses.colfacs.f1 * 5.0
#		mat.albedo_color = Color.white * (0.9 - f * 0.6) + syneses.colors.color1 * f * 0.5
#		mat.albedo_color = syneses.colors.color1 * 3.0 * syneses.colfacs.f1 + Color(1.0,1.0,1.0) * 0.8 *  (.4 -syneses.colfacs.f1)
#		mat.albedo_color = syneses.colors.color2 * 2.0 * syneses.colfacs.f2 + Color(0.5,0.5,0.5) * (.6 -syneses.colfacs.f2)
