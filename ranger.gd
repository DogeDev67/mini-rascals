extends CharacterBody2D

#TODO clean up this mess

#shortcuts, onready is needed to prevent crashes
@onready var sprite = $sprite
@onready var dash_timer = $dash_timer
@onready var cam = $cam
@onready var aniplayer = $AnimationPlayer
@onready var walk_dust = $walk_dust

@export var speed = 139 # 139

var dir : Vector2 = Vector2.ZERO
var original_sprite_scale : int

var dashing : bool
var can_dash : bool
func _ready():
	original_sprite_scale = sprite.scale.x
	pass


func _physics_process(delta):
	var distance_to_mouse = global_position - get_global_mouse_position()
	var camera_offset = 30
	var cam_target_pos : Vector2 = Vector2.ZERO
	var camera_offset_multiplier = 6
	
	if Input.is_action_pressed("look_further"):
		cam_target_pos = distance_to_mouse.normalized() * camera_offset * -camera_offset_multiplier
	else:
		cam_target_pos = distance_to_mouse.normalized() * camera_offset * -1
	
	cam.position = lerp(cam.position, cam_target_pos, 0.1)
	PlayerVariables.position = position
	
	handle_movement()
	move_and_slide()

	#TODO: Dash. (I have no idea how to do this)
func handle_movement():
	PlayerVars.player_pos = position
	
	dir = Input.get_vector("left", 'right', 'up', 'down')
	velocity = dir * speed
	
	if dir != Vector2.ZERO: # when the player is moving
		sprite.stop()
		walk_dust.emitting = true
		aniplayer.play("walking")
		if dir.x > 0:
			sprite.scale.x = original_sprite_scale
		elif dir.x < 0:
			sprite.scale.x = -original_sprite_scale
	else: # when the player is NOT moving
		aniplayer.play("RESET")
		walk_dust.emitting = false
		sprite.play('idle')
