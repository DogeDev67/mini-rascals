extends Node
var max_room_count : int
var room_count : int
var rooms : Array = [preload("res://scenes/rooms/test_room_1.tscn")]

var room_list : Array

var current_exit_pos : Vector2
var current_entrance_pos : Vector2
var current

signal creating_room

func create_room(room : PackedScene = rooms.pick_random()): 
	#for i in get_children():
		#remove_child(i)
	creating_room.emit()
	var ROOM = room.instantiate()
	ROOM.global_position = current_exit_pos
	call_deferred("add_child", ROOM)
	
	if room_list.size() > 3:
		get_children()[0].queue_free()
		room_list.pop_back()

