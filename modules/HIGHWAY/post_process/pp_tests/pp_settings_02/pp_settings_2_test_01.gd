extends Node2D

export (NodePath) var scene_np
export (NodePath) var setting_np

var scene
var setting



func _ready():
	scene = get_node(scene_np)
	setting = get_node(setting_np)
	remove_child(scene)
	setting.vp.add_child(scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
