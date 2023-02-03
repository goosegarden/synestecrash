extends Control

onready var rect = $ColorRect
var timer = 0
var timeout = 1.5


func _ready():
	rect.rect_size.y = 200 +  AudioServer.get_bus_volume_db(2) *10


func _process(delta):
	timer += delta
	if timer > timeout and modulate.a > 0 :
		modulate.a -= delta *0.6

func update() :
	timer = 0
	modulate.a = 1.0
	rect.rect_size.y = 200 +  AudioServer.get_bus_volume_db(2) *10
