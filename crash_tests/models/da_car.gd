extends KinematicBody

#onready var base_mat = $base_car.car_body.mesh.surface_get_material(0)
onready var base_mat = SpatialMaterial.new()
onready var glass_mat = SpatialMaterial.new()

var speed = 35
var highway
var paint_color
var syneses = {}

var paint_colors = [
	Color.cadetblue,
	Color.webmaroon,
	Color.webgray,
	Color.teal,
	Color.steelblue,
	Color.sienna,
	Color.rebeccapurple,
	Color.navyblue,
	Color.mintcream,
	Color.firebrick,
	Color.brown,
	Color.crimson,
	Color.darkred
]

func _ready():
	$"base_car2/car-body".set_surface_material(0, base_mat)
	$"base_car2/car-body".set_surface_material(1, glass_mat)
	randomize()
	var ci = randi()%paint_colors.size()-1
	paint_color = paint_colors[ci]
	base_mat.albedo_color = paint_color * .5
	base_mat.flags_disable_ambient_light = true
	glass_mat.albedo_color = Color.black


func _process(delta):
	
	if highway :
		global_transform.origin += (speed * (-global_transform.basis.z.normalized())) * delta + ( Vector3(0,0,highway.global_z_velocity)  * delta )
		if syneses.playing :
			glass_mat.albedo_color = syneses.colors.color4 * syneses.colfacs.f3 * 1.0
	if global_transform.origin.z > 500 :
		queue_free()
	
