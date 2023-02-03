extends Control


var maximums = []
var magnitudes = []
var min_db = -48
var max_db = 3
var min_vis = 0
var max_vis = 20

func _draw() :
	var n = 0
	var num = magnitudes.size()
	var width = 1
	if num > 0 :
		width = 1000/num
#	draw_rect(Rect2(-100,-100,20,-20), Color.red)
#	print(magnitudes.size())
	for m in magnitudes :
		var v = clamp(m.mag,min_db,3)
		v = range_lerp(v, min_db, max_db, min_vis, max_vis)
#		v = max(0.1,v)
		var r = Rect2(10 + n*width, -100, width, -v *(12+n*(12/num)))
#		var r = Rect2(rect_global_position.x + n*10, rect_global_position.y, 10, 20)
		draw_rect(r, Color.red)
		n += 1
