class_name room_creation_trigger extends Area2D

# done

@export var exit_anchor : NodePath



func try_creating_room():
	RoomGen.current_exit_pos = get_node(exit_anchor).global_position
	RoomGen.create_room()
