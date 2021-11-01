extends KinematicBody2D

class_name PhysObj

var grav_accel = 1500
var fric_accel = 1500

var max_v = Vector2(1000, 1000)

var cur_v = Vector2.ZERO
var cur_a = Vector2.ZERO


func _physics_process(delta):
	# apply external forces
	cur_a[1] = grav_accel
	if cur_a[0] == 0:
		if abs(cur_v[0]) < fric_accel * delta:
			cur_v[0] = 0
		elif is_on_floor():
			cur_a[0] = -1 * sign(cur_v[0]) * fric_accel
	# update velocity
	cur_v += cur_a * delta
	cur_v[0] = sign(cur_v[0]) * min(abs(cur_v[0]), max_v[0])
	cur_v[1] = sign(cur_v[1]) * min(abs(cur_v[1]), max_v[1])
	move_and_slide(cur_v, Vector2(0, -1))
	# reset velocities on collisions
	if is_on_wall():
		cur_v[0] = 0
	if is_on_floor() or is_on_ceiling():
		cur_v[1] = 0
	# reset acceleration for next call, done at end so super() can call this
	cur_a = Vector2(0, 0)
