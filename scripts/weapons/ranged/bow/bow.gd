extends Node2D
@onready var sprite = $bulletPivot/Sprite2D
@export var projectile : PackedScene # must be a projectile scene
@onready var cooldown = $cooldown

var can_attack : bool = true

func _ready():
	pass
	#sprite.rotation_degrees += 45
	
	#dont uncomment code above
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("attack") and can_attack:
		attack()

func attack():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("shooting")
	var proj = projectile.instantiate()
	get_parent().get_parent().get_parent().add_child(proj)
	proj.transform = $bulletPivot/Marker2D.global_transform
	cooldown.start()
	can_attack = false

func _on_cooldown_timeout():
	can_attack = true
