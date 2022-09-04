extends HBoxContainer


func _on_LineEdit_text_changed(new_text):
	Events.emit_signal("worker_number_changed", self, new_text)


func _on_LineEdit_focus_entered():
	$LineEdit.select_all()
