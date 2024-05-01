extends Button

var mid = Vector2(570, 1600)

var originPos : Vector2

var target_pos : Vector2
var pos_offset : int = 128
var dir = mid - position
var start_pos : Vector2
var angle_to_mid = position.angle_to(mid)
var radius := 250.0 
const originRadius = 250.0

@export var offSet : Vector2
@export var character : PackedScene
@export var character_index : int = 0

@onready var characters = $"../.."
@onready var character_amount : int = characters.get_child_count()

func _ready():
	originPos = position
	target_pos =   mid
	start_pos = global_position

func _process(delta):
	if CharacterManager.selected_character == character:
		radius = lerp(radius, originRadius - 100, 0.05) #lerp to the fireplace
	else:
		radius = lerp(radius, originRadius, 0.1) #lerp to the orginal position
	
	position = Vector2(
		sin((TAU / character_amount) * character_index) * radius,
		cos((TAU / character_amount) * character_index) * radius
		)  + mid


func _on_pressed():
	CharacterManager.selected_character = character
