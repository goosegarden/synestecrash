extends Node2D


export var blur_fac = 0.0125
export var dither_scale = 13.0
export var dither_fac = 0.05
export var trail_frequency = 0.03
export var trail_fac = 0.6
export (Color) var mod_color = Color.white



onready var vp = $ViewportContainer/Viewport
#onready var bgvp = $ViewportContainer/Viewport2
onready var trailmat = $quad.material
onready var endmat = $quad2.material

onready var player = get_tree().get_nodes_in_group("player")[0]
#onready var bgcam = $ViewportContainer/Viewport2/Camera

var captures = [
	ImageTexture.new(),
	ImageTexture.new(),
	ImageTexture.new(),
	ImageTexture.new(),
	ImageTexture.new(),
	ImageTexture.new(),
#	ImageTexture.new(),
#	ImageTexture.new(),
	]

var timer = 0
var t_num = 1
var t_delay = 0.03


func _ready():
	t_delay = trail_frequency
	trailmat.set_shader_param("vp", vp.get_texture())
	endmat.set_shader_param("blur_fac", blur_fac)
	endmat.set_shader_param("dither_scale", dither_scale)
	endmat.set_shader_param("dither_fac", dither_fac)
	endmat.set_shader_param("trail_fac", trail_fac)
	$quad2.modulate = mod_color
	for i in range(captures.size()) :
		captures[i].create_from_image(vp.get_texture().get_data())
		trailmat.set_shader_param("t"+str(i+1), captures[i])



func _process(delta):
#	var t = player.cam.global_transform
#	bgcam.global_transform = t
	timer += delta
	if timer > t_num * t_delay :
		captures[t_num - 1].set_data(vp.get_texture().get_data())
		t_num += 1
		if t_num > captures.size()-1 :
			t_num = 0
			timer = 0

