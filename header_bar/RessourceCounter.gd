extends HBoxContainer


export var start_quantity: int = 0
onready var quantity: int = start_quantity


func _ready():
	$RessourceBox/RessourceLabel.text = str(quantity)
