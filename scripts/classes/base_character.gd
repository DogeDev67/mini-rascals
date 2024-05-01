class_name base_character extends CharacterBody2D
#TODO clean up this mess

#shortcuts, onready is needed to prevent crashes
@onready var sprite = $sprite
@onready var dash_timer = $dash_timer
@onready var cam = $cam
@onready var aniplayer = $AnimationPlayer
@onready var walk_dust = $walk_dust
@onready var dash_effect = $dash_effect
@onready var hurtbox = $hurtbox

@onready var invincibility_timer = $invincibility_timer


@export var health = 3
@export var speed = 139 # 139

var dir : Vector2 = Vector2.ZERO
var original_sprite_scale : int

var is_dashing : bool = false
var can_dash : bool = true

var invincible : bool = false


signal  character_reset

func _ready():
	original_sprite_scale = sprite.scale.x
	dash_timer.connect('timeout', dash_end)
	RoomGen.creating_room.connect(_on_room_created)
	
	invincibility_timer.timeout.connect(invincibility_timer_timeout)
	hurtbox.area_entered.connect(hurtbox_entered)
	
	
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
	
	if Input.is_action_just_pressed("dash")  &&  can_dash && velocity != Vector2.ZERO:
		dash()
	
	if not is_dashing:
		dir = Input.get_vector("left", 'right', 'up', 'down')
		velocity = dir * speed
	else:
		velocity = dir * speed * 2
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

func dash():
	PlayerVars.is_dashing = true
	is_dashing = true
	can_dash = false
	dash_timer.start()
	dash_effect.emitting = false
	dash_effect.emitting = true
func dash_end():
	is_dashing = false
	can_dash = true
	PlayerVars.is_dashing = false
	
func death():
	pass
	
func take_damage():
	pass
	
func _on_room_created():
	dash_end()
	velocity = Vector2.ZERO

func hurtbox_entered(area):
	var area_parent = area.get_parent()
	
	if area_parent.is_in_group("enemy"):
		if not invincible:
			health -= 1
			invincible = true
			invincibility_timer.start()

	if health <= 0:
		death()

func invincibility_timer_timeout():
	invincible = false
