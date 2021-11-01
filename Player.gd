extends PhysObj


var walk_accel = 1500

var max_walk_v = 300
var default_max_v = max_v

enum Facing {LEFT=-1, RIGHT=1}
var cur_facing = Facing.RIGHT

const shot = preload("res://StickyBomb.tscn")
var cur_shot = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if cur_shot == null:
			var new_shot = shot.instance()
			new_shot.position = position
			new_shot.cur_v[0] = cur_facing * 600
			if Input.is_action_pressed("ui_up"):
				new_shot.cur_v[1] = -600
			elif Input.is_action_pressed("ui_down"):
				new_shot.cur_v[1] = -50
			else:
				new_shot.cur_v[1] = -300
			get_tree().get_root().add_child(new_shot)
			cur_shot = new_shot
		else:
			var d_pos = position - cur_shot.position
			var blast_dir
			if d_pos != Vector2.ZERO:
				blast_dir = d_pos.normalized()
			else:
				blast_dir = Vector2(0, -1)
			cur_v = blast_dir * 800
			cur_shot.queue_free()
			cur_shot = null
		

func _physics_process(delta):
	# walking input update
	if Input.is_action_pressed("ui_right") and cur_v[0] < max_walk_v:
		cur_a[0] = walk_accel
		cur_facing = Facing.RIGHT
		max_v[0] = max_walk_v
	elif Input.is_action_pressed("ui_left") and -1 * cur_v[0] < max_walk_v:
		cur_a[0] = -1 * walk_accel
		cur_facing = Facing.LEFT
		max_v[0] = max_walk_v
	else:
		max_v[0] = default_max_v[0]
