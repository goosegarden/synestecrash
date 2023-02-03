extends Spatial

onready var overground = $tunnel_overground

onready var mat1 = $tunnel2.mesh.surface_get_material(0)
onready var mat2 = $tunnel2.mesh.surface_get_material(1)
onready var m = $tunnel2.mesh.surface_get_material(2)
onready var mat4 = $tunnel2.mesh.surface_get_material(3)
onready var m2 = $tunnel2.mesh.surface_get_material(4)
onready var m3 = $tunnel2.mesh.surface_get_material(5)
var syneses = {}

var poster_path = "res://crash_tests/graphics/posters/paint0"

func _ready():
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
	
	m2 = SpatialMaterial.new()
#	m2.albedo_texture = imt2
	m2.albedo_color = Color.darkcyan
	
	m3 = SpatialMaterial.new()
#	m3.albedo_texture = imt3
	m3.albedo_color = Color.darkcyan
	
	$tunnel2.set_surface_material(2, m)
	$tunnel2.set_surface_material(4, m2)
	$tunnel2.set_surface_material(5, m3)

func _process(delta):
	if syneses.playing :
#		mat1.albedo_color = syneses.colors.color2 * 3.0 * syneses.colfacs.f2 
		mat1.albedo_color = syneses.colors.color2 * 3.0 * syneses.colfacs.f3 + Color(1.0,1.0,1.0) *.6
		m.albedo_color = syneses.colors.color1 * syneses.colfacs.f1 * 2.0
		m2.albedo_color = syneses.colors.color3 * syneses.colfacs.f3 * 3.0
		m3.albedo_color = syneses.colors.color4 * syneses.colfacs.f4 * 3.0
