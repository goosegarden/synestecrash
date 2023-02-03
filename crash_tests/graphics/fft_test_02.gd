extends Control


onready var spectrum  = AudioServer.get_bus_effect_instance(0,0)
onready var rt = $RichTextLabel
onready var rt2 = $RichTextLabel2
onready var visual = $visual

var freq_chart = [
	0,20,32,50,80,125,200,315,500,800,1250, 2000,3150,5000,8000,12500]

var FREQ_MIN = 0
var FREQ_MAX = 18000
var VU_COUNT = 64
var maximums = []
var magnitudes = []

func _ready():
	for i in range(1,VU_COUNT+1):
		maximums.append(-100)

func _process(delta):
	magnitudes = []
#	slice_equally()
	chart_slice()
	
	visual.maximums = maximums
	visual.magnitudes = magnitudes
	visual.update()

func chart_slice() :
	for i in range(freq_chart.size()-2) :
		var prev_hz = freq_chart[i]
		var hz = freq_chart[i+1]
		var magnitude : float = linear2db(spectrum.get_magnitude_for_frequency_range(prev_hz,hz).length() )
		magnitudes.append({"min" : prev_hz, "max" : hz, "mag" : magnitude})

func slice_equally() :
	var prev_hz = FREQ_MIN
	for i in range(1,VU_COUNT+1):   
		var hz = ((FREQ_MAX - FREQ_MIN) / VU_COUNT) * i + FREQ_MIN
#		var magnitude : float = spectrum.get_magnitude_for_frequency_range(prev_hz,hz).length() 
		var magnitude : float = linear2db(spectrum.get_magnitude_for_frequency_range(prev_hz,hz).length() )
		magnitudes.append({"min" : prev_hz, "max" : hz, "mag" : magnitude})
		prev_hz = hz
		maximums[i-1] = max(maximums[i-1], magnitude)
