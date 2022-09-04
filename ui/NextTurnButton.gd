extends Button


func _on_NextTurnButton_pressed():
	Events.emit_signal("turn_ended")
