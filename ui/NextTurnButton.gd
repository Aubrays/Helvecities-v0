extends Button


signal turn_ended


func _on_NextTurnButton_pressed():
	emit_signal("turn_ended")

