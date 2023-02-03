extends Node

onready var menu = $menu
onready var game = $synesthecrash_scroll_game_01



var paused  = true


func _ready():
	
	get_tree().paused = true
	menu.visible = true



func _process(delta):
	if Input.is_action_just_pressed("menu_toggle") :
		if menu.filedialog.visible == false :
			menu_toggle()
		else : 
			 menu.filedialog.visible = false


func menu_toggle() :
	if not paused : 
		paused = true
		get_tree().paused = true
		menu.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else : 
		if game.started :
			paused = false
			get_tree().paused = false
			menu.visible = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_Button_pressed():
	game.start()
	get_tree().paused = false
	menu.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	paused = false



func _on_menu_playlist_updated():
	game.play_list = menu.song_paths


func _on_synesthecrash_scroll_game_01_ready():
	pass


func _on_start_button2_pressed():
	get_tree().quit()
