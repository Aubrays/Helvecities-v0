extends PanelContainer


var CostLine = preload("res://ui/Districts/CostLine.tscn")
var district: Dictionary

onready var district_name_label = $VBoxContainer/DistrictName
onready var box = $VBoxContainer

	
func _ready():
	hide()
	print(district)
	district_name_label.text = district.name
	for cost in district.cost:
		var cost_line = CostLine.instance()
		box.add_child(cost_line)
		for item in Global.existing_commodities:
			if item.name == cost:
				print(item.icon)
				cost_line.get_node("TextureRect").set_texture(load(item.icon))
