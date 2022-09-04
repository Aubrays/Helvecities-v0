extends HBoxContainer


onready var label = $TurnBox/TurnLabel


func _ready():
	label.text = str(Global.turn_number)

func update_turn_counter(new_turn_number):
	label.text = str(new_turn_number)
