class_name Projectile extends Area2D

#TODO polish maybe? Code doesn't look and feel efficient

@export var sprite : NodePath
@export var speed : float
@export var life_time : float = 1
@export var damage : float = 1
@export var pierce : bool = false
@export var knockback_force : int = -10
var hit_enemies : Array = []

@export var arrow_trail : PackedScene = preload("res://scenes/arrow_trail.tscn")

func _ready():
	if arrow_trail != null:
		var ARROW_TRAIL = arrow_trail.instantiate()
		add_child(ARROW_TRAIL)
	area_entered.connect(entered)
	
	await get_tree().create_timer(life_time).timeout
	queue_free()
	
func _physics_process(delta):
	position += transform.x * speed

func entered(area):
	if area.get_parent().is_in_group("enemy") && not hit_enemies.has(area):
		area.get_parent().damage(damage, knockback_force, global_position)
		hit_enemies.append(area)
		if not pierce:
			queue_free()

