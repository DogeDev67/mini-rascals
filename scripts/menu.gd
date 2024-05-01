extends Node2D
@onready var camera = $Camera2D
@onready var aniplayer = $AnimationPlayer
@onready var ranger = $upmenu/ranger
@onready var knight = $upmenu/knight
@onready var title = $upmenu/title

var t : float = 0

func _physics_process(delta):
	title.position.y += sin(t) * 0.1 # give the title screen life
	
	t += 0.02

func _ready():
	ranger.play("default")
	knight.play("default")
func _on_start_pressed():
	aniplayer.play("move_cam")


func _on_backbutton_pressed():
	aniplayer.play_backwards("move_cam")


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
