extends HBoxContainer


var turn_number: int = 0
onready var label = $TurnBox/TurnLabel


func _ready():
	label.text = str(turn_number)


func increase_turn_counter():
	turn_number += 1


func update_turn_counter():
	increase_turn_counter()
	label.text = str(turn_number)
