extends Node2D

@onready var spawn_point = $spawn_point
@onready var enemies = $TileMap/enemies
@onready var tile_map = $TileMap
@onready var entrance_anchor = $TileMap/EntranceAnchor
@onready var exit_anchor = $entrance/exitAnchor

var enemy_count : int = 0
var current_toom : int = 0
var room_cleared : bool = false
func _ready():
	var player = CharacterManager.selected_character.instantiate()
	player.position = spawn_point.position
	add_child(player)

func _process(delta):
	#enemy_count = enemies.get_children().size() # galaxy brain code
	pass


















