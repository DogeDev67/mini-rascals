extends room_creation_trigger

func _ready():
	RoomGen.creating_room.connect(creating_room)

func _on_area_entered(area):
	if area.get_parent().is_in_group("player"):
		try_creating_room()
		RoomGen.room_list.append(get_parent().name)

func creating_room():
	queue_free()
