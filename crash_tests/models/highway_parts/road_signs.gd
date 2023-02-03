extends Spatial

onready var mat1 = $road_signs.mesh.surface_get_material(0)
onready var m = $road_signs.mesh.surface_get_material(1)
onready var m1 = $road_signs.mesh.surface_get_material(2)
onready var m2 = $road_signs.mesh.surface_get_material(3)

var poster_path = "res://crash_tests/graphics/posters/paint0"

var syneses = {}

func initialize() :
#	randomize()
#	var i = randi()%9 + 1
#	var i2 = randi()%9 + 1
#	var i3 = randi()%9 + 1
#
#	var imt = ImageTexture.new()
#	imt.load(poster_path+str(i)+".png")
#	var imt2 = ImageTexture.new()
#	imt2.load(poster_path+str(i2)+".png")
#	var imt3 = ImageTexture.new()
#	imt3.load(poster_path+str(i3)+".png")
#
	m = SpatialMaterial.new()
#	m.albedo_texture = imt
	m.albedo_color = Color.darkcyan
	
	m1 = SpatialMaterial.new()
#	m1.albedo_texture = imt2
	m1.albedo_color = Color.darkcyan
	
	m2 = SpatialMaterial.new()
#	m2.albedo_texture = imt3
	m2.albedo_color = Color.darkcyan
	
	$road_signs.set_surface_material(1, m)
	$road_signs.set_surface_material(2, m1)
	$road_signs.set_surface_material(3, m2)

func _process(delta):
	
	if syneses.playing :
#		mat2.albedo_texture.viewport_path =  syneses.viz_vp
		mat1.albedo_color = syneses.colors.color2 * 2.0 * syneses.colfacs.f2 
#		mat2.albedo_color = syneses.colors.color4 * syneses.colfacs.f4 * 2.0
		m.albedo_color = Color(0.3, 0.3, 0.3) + syneses.colors.color4 * syneses.colfacs.f4 * 4.0
		m1.albedo_color = Color(0.3, 0.3, 0.3) + syneses.colors.color4 * syneses.colfacs.f4 * 4.0
		m2.albedo_color = Color(0.3, 0.3, 0.3) + syneses.colors.color4 * syneses.colfacs.f4 * 4.0
#		mat2.albedo_color = Color.white
		
