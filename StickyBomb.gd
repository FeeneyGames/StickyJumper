extends PhysObj


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	if is_on_floor():
		cur_v = Vector2.ZERO
