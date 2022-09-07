extends Button


func _on_CommoditiesButton_pressed():
	Events.emit_signal("commodities_button_pressed")
