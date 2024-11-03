extends Area2D


func _input(event):
	if event.is_action_pressed("Interacao") and len(get_overlapping_bodies()) > 0:
		use_dialogue()
		
func use_dialogue():
	var dialogue = get_parent().get_node("DialogoBox")
	
	if dialogue:
		dialogue.start()
