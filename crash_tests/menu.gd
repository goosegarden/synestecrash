extends TextureRect

signal playlist_updated

onready var songlist = $songlist
onready var filedialog = $FileDialog
var song_paths = []

func _ready():
	filedialog.filters = ["*.ogg","*.mp3","*.OGG", "*.MP3"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FileDialog_file_selected(path):
	songlist.add_item(path.get_file())
	song_paths.append(path)
	emit_signal("playlist_updated")


func _on_add_song_pressed():
	filedialog.visible = true


func _on_remove_song_pressed():
	var sel = songlist.get_selected_items()

	for si in range(sel.size()) :
		songlist.remove_item(sel[si])
		song_paths.remove(si)
		emit_signal("playlist_updated")


func _on_FileDialog_files_selected(paths):
	for path in paths :
		songlist.add_item(path.get_file())
		song_paths.append(path)
		emit_signal("playlist_updated")
