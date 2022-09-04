extends Button


func _on_WorkersButton_pressed():
	Events.emit_signal("workers_button_pressed")
