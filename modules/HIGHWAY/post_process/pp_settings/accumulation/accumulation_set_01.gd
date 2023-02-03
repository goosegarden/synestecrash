extends Node2D

onready var pre_vp = $ViewportContainer/pre_vp
onready var post_vp = $post_vp
onready var preshader = $ViewportContainer.material

var pre_capture = ImageTexture.new()
var post_capture = ImageTexture.new()

var timer = 0

var t_delay = 0.2



func _ready():
	pre_capture.create_from_image(pre_vp.get_texture().get_data())
	post_capture.create_from_image(get_viewport().get_texture().get_data())
	preshader.set_shader_param("vp_copy", pre_capture)
	preshader.set_shader_param("post_capture", post_capture)



func _process(delta):

	timer += delta
	if timer > t_delay :
		pre_capture.set_data(pre_vp.get_texture().get_data())
		timer = 0

