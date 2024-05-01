class_name base_enemy extends CharacterBody2D

@export var health : int
@export var speed : float
@export var knockback_timer : Timer

var do_knockback : bool = false

const DEATH_EFFECT = preload("res://scenes/death_effect.tscn")

func _ready():
	knockback_timer.connect("timeout", _knockback_timer_timeout)

func damage(damage : int, knockback_force : int = 1, attack_position : Vector2 = Vector2.ZERO):
	if health <= 0:
		death()
	do_knockback = true
	var knockback_dir = attack_position - global_position
	velocity =  -knockback_dir.normalized() * (knockback_force + speed * 5)
	health -= damage
	knockback_timer.start()
	#move_and_slide()

func death():
	var death_effect = DEATH_EFFECT.instantiate()
	death_effect.position = position
	add_sibling(death_effect)
	queue_free()

func _knockback_timer_timeout():
	do_knockback = false
	velocity = Vector2.ZERO
