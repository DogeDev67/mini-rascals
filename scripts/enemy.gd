extends base_enemy


@export var is_moving : bool = true

@onready var move_timer = $move_timer

var dir : Vector2 = Vector2(randi_range(-1, 1), randi_range(-1, 1))

func _physics_process(delta):
	velocity = dir * speed
	move_and_slide()


func _on_move_timer_timeout():
	#No, I'm not gonna implement state machines
	if is_moving:
		is_moving = !is_moving
		dir = Vector2(0, 0)
	elif  !is_moving:
		is_moving = !is_moving
		dir = Vector2(randi_range(-1, 1), randi_range(-1, 1))
