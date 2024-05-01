@icon("res://assets/base_weapon_icon.png")
class_name base_weapon extends Node2D

@export var sprite : Sprite2D
@export var projectile : PackedScene # must be a projectile scene
@export var cooldown : Timer
@export var aniplayer : AnimationPlayer
@export var muzzle : Marker2D
var can_attack : bool = true

func _ready():
	pass
	#sprite.rotation_degrees += 45
	
	#dont uncomment code above
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("attack") and can_attack:
		attack()
	
	if get_parent().get_parent().position.x < get_global_mouse_position().x:
		sprite.flip_v = false
	elif get_parent().get_parent().position.x > get_global_mouse_position().x:
		sprite.flip_v = true

func attack():
	aniplayer.stop()
	aniplayer.play("shooting")
	
	var proj = projectile.instantiate()
	get_parent().get_parent().get_parent().add_child(proj)
	proj.transform = muzzle.global_transform
	cooldown.start()
	can_attack = false

func _on_cooldown_timeout():
	can_attack = true
