extends Spatial

onready var streamer = $AudioStreamPlayer
onready var spectrum  = AudioServer.get_bus_effect_instance(0,0)
onready var player = $biker
onready var screen_title = $biker/base/vert/ghost_highway__bike03/screen/Viewport/ColorRect/Label

onready var pp_shader = $biker/base/cam_pod/cam_lock/Camera/pp_quad.get_surface_material(0)
onready var env = $WorldEnvironment.environment

var play_list = [
	preload("res://assets/audio/Stevie Wonder Superstition.ogg"),
	preload("res://assets/audio/Death In Vegas, Aisha.mp3"),
	preload("res://assets/audio/Mad Professor & Lee Perry - Reggae Voodoo.mp3"),
	preload("res://assets/audio/Happy Mondays - Hallelujah.mp3"),
]

var playing = false
var play_index = 0

var freq_chart = [
	0,20,32,50,80,125,200,315,500,800,1250, 2000,3150,5000,8000,12500]
var magnitudes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var min_db = -48
var max_db = 3
var min_vis = 0
var max_vis = 1



func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
#	print(pp_shader)

func _process(delta):
	if Input.is_action_just_pressed("play_start") :
		pp_shader.set_shader_param("playing", true)
		var song = play_list[play_index]
		play_index += 1
		if play_index > play_list.size() -1 :
			play_index = 0
		streamer.stream = song
		var title = song.resource_path
		title = title.trim_prefix("res://assets/audio/")
		title = title.trim_suffix(".ogg")
		title = title.trim_suffix(".mp3")
		screen_title.text = title
#		print(title)
		streamer.play()
		playing = true
	
	if playing : 
		magnitudes = []
		chart_slice()
		env.background_color = Color(magnitudes[10], magnitudes[9]*2.0, magnitudes[8] )
	#	print(magnitudes)
		for i in range(magnitudes.size()) :
			pp_shader.set_shader_param("f"+str(i), magnitudes[i])

func chart_slice() :
	var n = 0
	for i in range(freq_chart.size()-2) :
		var prev_hz = freq_chart[i]
		var hz = freq_chart[i+1]
		var magnitude : float = linear2db(spectrum.get_magnitude_for_frequency_range(prev_hz,hz).length() )
		var v = clamp(magnitude,min_db,3)
		v = range_lerp(v, min_db, max_db, min_vis, max_vis)
		magnitudes.append(v*(0.6+n*0.0375))
		n += 1
