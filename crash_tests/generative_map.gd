extends Spatial


onready var base_section = preload("res://crash_tests/models/highway_parts/flat_road_01.tscn")
onready var tunnel = preload("res://crash_tests/models/highway_parts/tunnel2.tscn")
onready var bridge = preload("res://crash_tests/models/highway_parts/long_bridge.tscn")
onready var borders = preload("res://crash_tests/models/highway_parts/closed_borders.tscn")
onready var ground = preload("res://crash_tests/models/highway_parts/ground.tscn")
onready var road_signs = preload("res://crash_tests/models/highway_parts/road_signs.tscn")
onready var dacar = preload("res://crash_tests/models/da_car.tscn")
onready var billboard = preload("res://crash_tests/models/highway_parts/billboard.tscn")
onready var barrier = preload("res://crash_tests/models/highway_parts/barrier.tscn")

onready var main = get_parent()
onready var vehicles = $vehicles


var sections = []
var booted = false

var global_z_velocity = 0.0

func _ready():
	pass


func _process(delta):
	if booted : 
		move_sections(delta)

func clear_world() :
	for v in vehicles.get_children() :
		v.queue_free()
	for s in sections :
		s.queue_free()
	sections = []
	booted = false
	
func boot_world() :
	generate()
	generate()
	generate()
	generate()
	booted = true
		

func move_sections(delta) :
	
	if sections[0].global_transform.origin.z > 750 :
		var s = sections.pop_front()
		s.queue_free()
		generate()
	for s in sections : 
		s.global_transform.origin += Vector3(0,0,global_z_velocity ) * delta
		
	
func add_cars(section) :
	randomize()
	var r = randi()%7
	for i in range(r) :
		var car = dacar.instance()
		vehicles.add_child(car)
		car.syneses = main.syneses
		car.highway = self
		var r2 = randf()
		car.global_transform.origin = section.global_transform.origin + Vector3(40,0,50*i)
		if r2 > .3 :
			car.global_transform.origin = section.global_transform.origin + Vector3(30,0,60*i)
			car.speed += 5
		if r2 > .7 :
			car.global_transform.origin = section.global_transform.origin + Vector3(20,0,70*i)
			car.speed += 5
		if r2 > .9 :
			car.global_transform.origin = section.global_transform.origin + Vector3(10,0,70*i)
			car.speed += 10
	var r10 = randi()%6
	for i in range(r10) :
		var car = dacar.instance()
		vehicles.add_child(car)
		car.rotation.y = deg2rad(180)
		car.syneses = main.syneses
		car.highway = self
		var r2 = randf()
		car.global_transform.origin = section.global_transform.origin + Vector3(-40,0,150*i)
		if r2 > .3 :
			car.global_transform.origin = section.global_transform.origin + Vector3(-30,0,160*i)
			car.speed += 5
		if r2 > .7 :
			car.global_transform.origin = section.global_transform.origin + Vector3(-20,0,170*i)
			car.speed += 5
		if r2 > .9 :
			car.global_transform.origin = section.global_transform.origin + Vector3(-10,0,170*i)
			car.speed += 10
		
	
func generate() :
	var s = base_section.instance()
	sections.push_back(s)
	add_child(s)
	s.syneses = main.syneses
	if sections.size() > 1 :
		s.global_transform.origin = sections[sections.size()-2].global_transform.origin + Vector3(0,0,-500)
	else : 
		pass
	add_cars(s)
	var g = ground.instance()
	s.add_child(g)
	g.syneses = main.syneses
	s.global_transform.origin = s.global_transform.origin 
	randomize()
	var a = randf()
	if a > .8 :
		var t = tunnel.instance()
		s.add_child(t)
		t.overground.syneses = main.syneses
		t.syneses = main.syneses
		t.global_transform.origin = s.global_transform.origin 
	else :
		var a2 = randf()
		var a3 = randf()
		var a4 = randf()
		if a2 > .6 :
			var b = bridge.instance()
			s.add_child(b)
			b.syneses = main.syneses
			b.global_transform.origin = s.global_transform.origin + Vector3(0,0,-50)
		if a3 > .3 :
			var rs = road_signs.instance()
			rs.initialize()
			s.add_child(rs)
			rs.syneses = main.syneses
			var r1 = randf()
			rs.global_transform.origin = s.global_transform.origin + Vector3(0,0, -75 + 50 * r1)
		if a3 > .8 :
			var rs = road_signs.instance()
			s.add_child(rs)
			rs.syneses = main.syneses
			var r1 = randf()
			rs.global_transform.origin = s.global_transform.origin + Vector3(0,0, -250 + 150 * r1)
		
		if a2 > .6 :
			var cb = borders.instance()
			s.add_child(cb)
			cb.syneses = main.syneses
			cb.global_transform.origin = s.global_transform.origin 
		else : 
			var r11 = randf()
			if r11 > .5 :
				var bb3 = billboard.instance()
				s.add_child(bb3)
				bb3.global_transform.origin = s.global_transform.origin 
				bb3.global_transform.origin = s.global_transform.origin + Vector3(0,0,-30 * randf())
			var bb = barrier.instance()
			var bb2 = barrier.instance()
			s.add_child(bb)
			s.add_child(bb2)
			bb.global_transform.origin = s.global_transform.origin 
			bb2.rotation.y = deg2rad(180)
			bb2.global_transform.origin = s.global_transform.origin + Vector3(0,0,-500)
