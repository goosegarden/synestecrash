extends KinematicBody

onready var base = $base
onready var vert = $base/vert
var speed = 20
var steer_speed = 10

var velocity = Vector3.ZERO
var steer_vel = Vector3.ZERO
onready var cam = $base/cam_pod/cam_lock/Camera





func _ready():
	pass # Replace with function body.



func _process(delta):
	speed -= delta
#	cam.fov = 80 + speed *0.25
#	if Input.is_action_just_pressed("shoot") :
#		shoot()
	
	velocity = Vector3.ZERO
	var steer = Vector3.ZERO
	if Input.is_action_pressed("lf") :
		steer.x -= 1
	if Input.is_action_pressed("rg") :
		steer.x += 1
	if Input.is_action_pressed("fw") :
		speed += 10 * delta
	if Input.is_action_pressed("bw") :
		speed -= 32 * delta
	speed = clamp(speed,8,60)
	steer_speed = (speed / 5) +2
	
	velocity = -global_transform.basis.z.normalized() * speed * delta
	steer_vel = lerp(steer_vel,steer * steer_speed, delta*6.0)
	velocity += steer_vel * delta
	
	global_transform.origin += velocity
	
	base.rotation.z = lerp(base.rotation.z, -steer.x * .1, delta * 5.0 )
	vert.rotation.y = lerp(vert.rotation.y, -steer.x * .1, delta * 4.0 )
	
	if global_transform.origin.z < -630 :
		global_transform.origin.z = 50


