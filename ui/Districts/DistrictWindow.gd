extends ConfirmationDialog


var CostLine = preload("res://ui/Districts/CostLine.tscn")

var district_name: String

func init(district_name):
	self.district_name = district_name
	for district in Global.districts:
		if district_name == district.name:
			$VBoxContainer/DistrictName.text = district_name
			for cost in district.cost:
				var cost_line = CostLine.instance()
				$VBoxContainer.add_child(cost_line)
				for item in Global.existing_commodities:
					if item.name == cost:
						cost_line.get_node("Label").text = String(district.cost[cost])
						cost_line.get_node("TextureRect").set_texture(load(item.icon))



func _on_DistrictWindow_confirmed():
	Events.emit_signal("district_build_confirmed", district_name)
	
	for district in Global.districts:
		if district_name == district.name:
			district.build = true
			for cost in district.cost:
				for item in Global.commodities:
					if item.commodity_name == cost:
						item.stock = item.stock - district.cost[cost]	
