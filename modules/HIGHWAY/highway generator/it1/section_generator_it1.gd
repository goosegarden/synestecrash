extends Spatial


onready var road = preload("res://assets/graphics/my_models/highway_section_01_t2_model.tscn")

onready var sections = [
	preload("res://assets/highway_parts/highway_closed.tscn"),
	preload("res://assets/highway_parts/highway_open.tscn"),
	preload("res://assets/highway_parts/tunnel.tscn"),
]

onready var bridge = preload("res://assets/highway_parts/bridge.tscn")
#onready var road = preload("res://assets/graphics/my_models/highway_section_01_model.tscn")



func generate_section() :
#	var cbegin = CubeMesh.new()
#	var cend = CubeMesh.new()
#	var mi_begin = MeshInstance.new()
#	var mi_end = MeshInstance.new()
#	mi_begin.mesh = cend
#	mi_end.mesh = cbegin

	var road_segment = road.instance()
	
#	var b_pos = road_segment.find_node("begin")
#	var e_pos = road_segment.find_node("end")
#	b_pos.add_child(mi_begin)
#	e_pos.add_child(mi_end)
	
	return road_segment
