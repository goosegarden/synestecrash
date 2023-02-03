extends Spatial

onready var base = $base
onready var secgen = $section_generator_it1

var dir = Vector3(0,0,-1)

var numsections = 3

var hw_seg_size = Vector2(56, 182)

var sections = []

func _ready():
	for i in range(numsections) :
		var s = secgen.generate_section()
		var begin = s.find_node("begin")
		var end = s.find_node("end")
		base.add_child(s)
		sections.append({
			"instance" : s,
			"treename" : s.name,
			"begin" : begin,
			"end" : end
		})
		if sections.size() > 1 :
			var last_seg = sections[sections.size()-1]
			s.global_transform.origin = last_seg.end.global_transform.origin


func update(speed, delta) :

	var s = sections[0]
	if s.instance.global_transform.origin.z > hw_seg_size.y +50 :
		base.remove_child(s.instance)
		s.instance.queue_free()
		sections.pop_front()
		request_new_section()
	for seg in sections : 
		seg.instance.global_transform.origin -= speed * delta * dir
		
		

func request_new_section() :
	var s = secgen.generate_section()
	var begin = s.find_node("begin")
	var end = s.find_node("end")
	base.add_child(s)
	var last_seg = sections[sections.size()-1]
	sections.append({
		"instance" : s,
		"treename" : s.name,
		"begin" : begin,
		"end" : end
		})
	s.global_transform.origin = last_seg.end.global_transform.origin
