class_name shotgun extends base_weapon

@export_range(1, 20)var bullet_amount : int = 3
@export_range(1, 90) var spread : float = 45
@export var speed_difference : float = 0


func attack():
	aniplayer.stop()
	aniplayer.play("shooting")
	for i in bullet_amount:
		var BULLET = projectile.instantiate()
		var bullet_spread = randf_range(-spread, spread)
		var bullet_speed_difference = randf_range(BULLET.speed, BULLET.speed + speed_difference)
		

		get_parent().get_parent().get_parent().add_child(BULLET)
		BULLET.transform = muzzle.global_transform
		BULLET.rotation_degrees += bullet_spread
		BULLET.speed = bullet_speed_difference
		cooldown.start()
		can_attack = false

func _on_cooldown_timeout():
	can_attack = true
