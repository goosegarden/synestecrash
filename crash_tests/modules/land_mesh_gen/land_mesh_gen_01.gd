extends Spatial


var noise = OpenSimplexNoise.new()
var st = SurfaceTool.new()

onready var mat = preload("res://crash_tests/graphics/land_default.tres")

var last_line = 0
var line_size = 120

var sc = 32


func _ready():
	noise.octaves = 2
	noise.period = 96
#	last_line.resize(line_size)
	for l in last_line : 
		l = Vector3.ZERO
#	generate()


func generate() :
	st.clear()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	for z in range(31) :
		for x in range(120) :

			var v0 = Vector3(x,0,-z) *8.0
			var v1 = Vector3(x,0,-z-1) *8.0
			var v2 = Vector3(x+1,0,-z) *8.0
			var v3 = Vector3(x+1,0,-z-1) *8.0
			
			v0.y = (noise.get_noise_2d(v0.x,v0.z - last_line) ) *(x-1) * 1.2
			v1.y =  (noise.get_noise_2d(v1.x,v1.z - last_line) ) *(x-1) * 1.2
			v2.y =  (noise.get_noise_2d(v2.x,v2.z - last_line) ) *x * 1.2
			v3.y =  (noise.get_noise_2d(v3.x,v3.z - last_line) ) *x * 1.2
			
#			var n1 = 
			st.add_uv(Vector2(v0.x/120, v0.z/125))
			st.add_uv(Vector2(v1.x/120, v1.z/125))
			st.add_uv(Vector2(v2.x/120, v2.z/125))
			st.add_uv(Vector2(v1.x/120, v1.z/125))
			st.add_uv(Vector2(v3.x/120, v3.z/125))
			st.add_uv(Vector2(v2.x/120, v2.z/125))

			st.add_vertex(v0)
			st.add_vertex(v1)
			st.add_vertex(v2)
			st.add_vertex(v1)
			st.add_vertex(v3)
			st.add_vertex(v2)
	st.generate_normals()
	st.generate_tangents()
	var am = st.commit()
	var mi = MeshInstance.new()
	mi.mesh = am
	mi.set_surface_material(0,mat)
	last_line += 32 * 8
	return mi
