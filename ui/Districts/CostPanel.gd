extends PanelContainer


var CostLine = preload("res://ui/Districts/CostLine.tscn")
var district: Dictionary

onready var district_name_label = $VBoxContainer/DistrictName
onready var box = $VBoxContainer

	
func _ready():
	hide()
	district_name_label.text = district.name
	if district.build_step == Global.step and district.build == false:
		for cost in district.cost:
			var cost_line = CostLine.instance()
			box.add_child(cost_line)
			for item in Global.existing_commodities:
				if item.name == cost:
					cost_line.get_node("Label").text = String(district.cost[cost])
					cost_line.get_node("TextureRect").set_texture(load(item.icon))
