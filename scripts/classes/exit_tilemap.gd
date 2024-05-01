class_name exit_tilemap extends TileMap

@export var enemies : Node2D
var is_enemy_alive : bool

func _physics_process(delta):
	var is_enemy_alive = false
	
	for i in enemies.get_children().size():
		
		if enemies.get_children()[i].is_in_group("enemy"):
			is_enemy_alive = true
	
	if is_enemy_alive == false:
		queue_free()
