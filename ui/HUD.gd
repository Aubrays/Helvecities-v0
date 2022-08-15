extends CanvasLayer


func _ready():
	$NextTurnButton.connect("turn_ended", $HeaderBar/HBoxContainer/TurnCounter, "update_turn_counter")
