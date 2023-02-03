extends Control


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
		width = 600/num

	for m in magnitudes :
		var v = m
#		var v = clamp(m,min_db,3)
#		v = range_lerp(v, min_db, max_db, min_vis, max_vis)
#		v = max(0.1,v)
		var r = Rect2(80 + n*width, 400, width, -v *(300+n*(300/num)))
#		var r = Rect2(rect_global_position.x + n*10, rect_global_position.y, 10, 20)
		draw_rect(r, Color.darkblue)
		n += 1
