extends base_enemy

#script works perfectly fine



@onready var nav_agent = $NavigationAgent2D



var dir : Vector2

func _physics_process(delta):
	
	if not PlayerVars.is_dashing:
		dir = PlayerVars.player_pos - global_position
		dir = dir.normalized()
	if not do_knockback:
		velocity = dir * speed

	move_and_slide()
