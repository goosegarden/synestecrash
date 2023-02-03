extends KinematicBody

onready var cam = $base/cam_pod/cam_lock/Camera
onready var cam_lock = $base/cam_pod/cam_lock
onready var base = $base
onready var vert = $base/vert

var speed = 30
var steer_speed = 10

var min_speed = 30
var max_speed = 160

var velocity = Vector3.ZERO
var steer_vel = Vector3.ZERO



func _ready():
	pass # Replace with function body.



func _process(delta):
	if global_transform.origin.x > 43 : 
		speed -= delta * 24.0
	elif global_transform.origin.x < -43 : 
		speed -= delta * 24.0
	else :
		speed -= delta * 2.0

	var acc = 0
	velocity = Vector3.ZERO
	var steer = Vector3.ZERO
	if Input.is_action_pressed("lf") :
		steer.x -= 1
	if Input.is_action_pressed("rg") :
		steer.x += 1
	if Input.is_action_pressed("fw") :
		speed += 16 * delta
		acc += 1
	if Input.is_action_pressed("bw") :
		speed -= 40 * delta
		acc -= 1
	speed = clamp(speed,min_speed,max_speed)
	steer_speed = (speed / 5) +2
	
	velocity = -global_transform.basis.z.normalized() * speed * delta
	steer_vel = lerp(steer_vel,steer * steer_speed, delta*6.0)
	velocity += steer_vel * delta
	
#	global_transform.origin += velocity
	global_transform.origin += steer_vel * delta
	global_transform.origin.x = clamp(global_transform.origin.x, -45, 45)
		
	$base/vert/ghost_highway__bike03/screen/Viewport/ColorRect/Label2.text  = str(int(speed * 2))
	
	if acc == 1 :
		if speed < max_speed :
			cam.global_transform.origin.z = lerp(cam.global_transform.origin.z, cam_lock.global_transform.origin.z +0.05, delta * 4.0)
	elif acc == -1 :
		if speed > min_speed :
			cam.global_transform.origin.z = lerp(cam.global_transform.origin.z, cam_lock.global_transform.origin.z -0.05, delta * 8.0)
	else : 
		cam.global_transform.origin.z = lerp(cam.global_transform.origin.z, cam_lock.global_transform.origin.z, delta * 3.0)
	
	base.rotation.z = lerp(base.rotation.z, -steer.x * .15, delta * 5.0 )
	vert.rotation.y = lerp(vert.rotation.y, -steer.x * .1, delta * 4.0 )
	
	if global_transform.origin.z < -630 :
		global_transform.origin.z = 50


