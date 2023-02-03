extends Spatial

onready var streamer = $AudioStreamPlayer
onready var spectrum  
onready var bus_layout = preload("res://crash_tests/my_bus_layout.tres")
onready var player = $scroll_biker

onready var screen_title = $scroll_biker/base/vert/ghost_highway__bike03/screen/Viewport/ColorRect/Label

onready var pp_shader = $scroll_biker/base/cam_pod/cam_lock/Camera/pp_quad.get_surface_material(0)
onready var env = $WorldEnvironment.environment
onready var skyshader = $q3_sky/sky_cube.mesh.surface_get_material(0)

onready var gen_map = $generative_map

onready var crash_screen = $crash_screen
onready var crash_sound = $crash_screen/crash_sound

onready var volume_display = $volume

var crash_delay = 2.0
var crash_timer = 0.0
var crashed = false
var skip_pos = 0.0

var global_z_velocity = 0

onready var audioloader = preload("res://crash_tests/modules/GDScriptAudioImport.gd")

var palettes = [
	{
		"color1" : Color(0.011,0.01,0.005),
		"color2" : Color(0.000,0.006,0.012),
		"color3" : Color.yellow,
		"color4" : Color.lightcyan,
		},

]

var syneses = {
	"playing" : false,
	"colors" :{
		"color1" :  Color(0.2,0.02,0.04),
		"color2" : Color.darkblue,
		"color3" : Color.yellow,
		"color4" : Color.lightcyan,
		},
	"colfacs" : {
		"f1" : 0.0,
		"f2" : 0.0,
		"f3" : 0.0,
		"f4" : 0.0,
	},
#	"viz_vp" : viz_vp,
}

var play_list = []

var playing = false
var play_index = 0
var current_song

var freq_chart = [
	0,20,32,50,80,125,200,315,500,800,1250, 2000,3150,5000,8000,12500]
var magnitudes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var min_db = -48
var max_db = 3
var min_vis = 0
var max_vis = 1

var started  = false

export var debug = true

func _ready():
	AudioServer.set_bus_layout(bus_layout)
	AudioServer.add_bus_effect(0, AudioEffectSpectrumAnalyzer.new())
	spectrum  = AudioServer.get_bus_effect_instance(0,0)

	if debug :
		load_debug_playlist()
		start()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else : 
		pass
		


func _process(delta):
	
	if debug : 
		if Input.is_action_just_pressed("clear_world") :
			gen_map.clear_world()
		if Input.is_action_just_pressed("generate_world") :
			gen_map.boot_world()
		
	if crashed : 
		crash_timer += delta
		if streamer.playing :
			if streamer.get_playback_position() > skip_pos + 0.2 :
				streamer.seek(skip_pos)
		if crash_timer > crash_delay :
			streamer.stop()
			crashed = false
			crash_screen.visible = false
#			streamer.play()
	else :
		global_z_velocity = player.speed
		gen_map.global_z_velocity = global_z_velocity
		
		player_handle_commands()
		
	if playing : 
#			visualize.magnitudes = magnitudes
#		else :
#			visualize.magnitudes = []
		chart_slice()
		feed_shaders()
#		visualize.update()
		
func start() :
#	load_playlist()
	var c1 = syneses.colors.color1
	var c2 = syneses.colors.color2
	var c3 = syneses.colors.color3
	var c4 = syneses.colors.color4
	pp_shader.set_shader_param("col1", Vector3(c1.r,c1.g,c1.b))
	pp_shader.set_shader_param("col2", Vector3(c2.r,c2.g,c2.b))
	pp_shader.set_shader_param("col3", Vector3(c3.r,c3.g,c3.b))
	pp_shader.set_shader_param("col4", Vector3(c4.r,c4.g,c4.b))

	gen_map.boot_world()
	started = true
	
func player_handle_commands() :
	if play_list.size() > 0 :
		if Input.is_action_just_pressed("play") :
			if not playing :
				pp_shader.set_shader_param("playing", true)
				current_song = play_list[play_index]
				var audio_loader = audioloader.new()
				var song = audio_loader.loadfile(current_song)
				streamer.stream = song
				streamer.play()
				playing = true
				syneses.playing = true
				update_bike_display("")
			else :
				streamer.stop()
				pp_shader.set_shader_param("playing", false)
				playing = false
				syneses.playing = false
				
		if Input.is_action_just_pressed("next") :
			play_index += 1
			if play_index > play_list.size() -1 :
				play_index = 0
			current_song = play_list[play_index]
			var audio_loader = audioloader.new()
			var song = audio_loader.loadfile(current_song)
			streamer.stream = song
			update_bike_display("")
			if playing : 
				streamer.play()
				
		if Input.is_action_just_pressed("prev") :
			play_index -= 1
			if play_index < 0  :
				play_index = play_list.size() -1
			current_song = play_list[play_index]
			var audio_loader = audioloader.new()
			var song = audio_loader.loadfile(current_song)
			streamer.stream = song
			update_bike_display("")
			if playing : 
				streamer.play()
	else :
		update_bike_display("No song in playlist...")

func feed_shaders() :
	if playing : 
	
		var lowbass = (magnitudes[0] +magnitudes[1] +magnitudes[2] +magnitudes[3]) /4.0
		var bass = (magnitudes[3] +magnitudes[4] +magnitudes[5] ) /3.0
		var lomids = (magnitudes[6] +magnitudes[7] +magnitudes[8] ) /3.0
		var mids = (magnitudes[8] +magnitudes[9] +magnitudes[10] ) /3.0
		var himids =  (magnitudes[10] +magnitudes[11] +magnitudes[12] ) /3.0
		var highs =  (magnitudes[13] +magnitudes[14]  ) /2.0
		
		
		syneses.colfacs.f1 = lowbass
		syneses.colfacs.f2 = bass
		syneses.colfacs.f3 = mids
		syneses.colfacs.f4 = himids
		
		env.background_color = syneses.colors.color3 * syneses.colfacs.f3 
		skyshader.set_shader_param("sky_col", Vector3(syneses.colors.color3.r, syneses.colors.color3.g, syneses.colors.color3.b ) *max(0.0,  syneses.colfacs.f3  -0.1) *1.7 )
		
		for i in range(magnitudes.size()) :
			pp_shader.set_shader_param("f"+str(i), magnitudes[i])

func update_bike_display(message) :
	if message == "" :
		var title = play_list[play_index].get_file()
#		title = title.get_file()
#		title = title.trim_prefix("res://crash_tests/songs/")
#		title = title.trim_suffix(".ogg")
#		title = title.trim_suffix(".mp3")
		screen_title.text = title
	else : 
		screen_title.text = message

func chart_slice() :
	magnitudes = []
	var n = 0
	var prev_hz
	var hz
	for i in range(freq_chart.size()-2) :
		prev_hz = freq_chart[n]
		hz = freq_chart[n+1]
		var magnitude : float = linear2db(spectrum.get_magnitude_for_frequency_range(prev_hz,hz).length() )
		var v = clamp(magnitude,min_db,3)
		v = range_lerp(v, min_db, max_db, min_vis, max_vis)
		magnitudes.append(v*(0.6+n*0.0375))
		n += 1
	prev_hz = freq_chart[n]
	hz = freq_chart[n+1]
	var magnitude : float = linear2db(spectrum.get_magnitude_for_frequency_range(prev_hz,hz).length() )
	var v = clamp(magnitude,min_db,3)
	v = range_lerp(v, min_db, max_db, min_vis, max_vis)
	magnitudes.append(v*(0.6+n*0.0375))

func load_playlist() :
	if debug : 
		pass
	else : 
		pass

func load_debug_playlist() :
	play_list = []
	var d = Directory.new()
	d.open("res://crash_tests/songs/")
	d.list_dir_begin()
	var f = d.get_next()
	while f != "" :
		var ext = f.get_extension()
		if ext == "ogg" or ext == "mp3" :
			play_list.append("res://crash_tests/songs/"+ f)
#			play_list.append(load("res://crash_tests/songs/"+ f))
		f = d.get_next()

func crash() :
	crash_sound.play()
	crashed = true
	crash_screen.visible = true
	skip_pos = streamer.get_playback_position() -0.1
#	streamer.stop()
	pp_shader.set_shader_param("playing", false)
	playing = false
	syneses.playing = false
	crash_timer = 0.0
	gen_map.clear_world()
	gen_map.boot_world()
	player.speed = 30
	player.global_transform.origin.x = 30
	var crash_img = get_viewport().get_texture().get_data()
	var crash_text = ImageTexture.new()
	crash_text.create_from_image(crash_img)
	crash_screen.material.set_shader_param("tx", crash_text) 
	

func _input(event):
	if event is InputEventMouseButton :
		if event.button_index == 4 :
			AudioServer.set_bus_volume_db(2, AudioServer.get_bus_volume_db(2) + 0.15 )
			volume_display.update()
		if event.button_index == 5 :
			AudioServer.set_bus_volume_db(2, AudioServer.get_bus_volume_db(2)  - 0.15 )
			volume_display.update()
		


func _on_Area_area_entered(area):
	if area.is_in_group("crash") :
		crash()
