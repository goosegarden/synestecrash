extends Spatial


var osn = OpenSimplexNoise.new()


func _ready():
	osn.octaves = 7
	osn.period = 72
	osn.persistence = 0.4
	osn.lacunarity = 1.6


func _process(delta):
	var t = Time.get_ticks_msec()
	var shake = osn.get_noise_1d(t)
	transform.origin.y = max(shake * 2.0 -.3, 0) *.4
