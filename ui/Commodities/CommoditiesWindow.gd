extends ConfirmationDialog


var CommodityLine = preload("res://ui/Commodities/CommodityLine.tscn")
var commoditiesContainers: Array
onready var grid: GridContainer = $MarginContainer/VBoxContainer/GridContainer


func _ready():
	Events.connect("commodities_button_pressed", self, "_on_Events_commodities_button_pressed")
	
	for commodity in Global.commodities:
		var new_commodity = CommodityLine.instance()
		new_commodity.get_node("CommodityName").text = commodity.commodity_name
		new_commodity.get_node("CommodityBox/CommodityCounter").text = String(commodity.stock)
		new_commodity.get_node("CommodityIcon").set_texture(commodity.icon_texture)
		
		grid.add_child(new_commodity)
		
	commoditiesContainers = grid.get_children()


func _on_Events_commodities_button_pressed():
	show()


func update_text():
	for item in commoditiesContainers:
		var commodity_name = item.get_node("CommodityName").text
		for commodity in Global.commodities:
			if commodity_name == commodity.commodity_name:
				item.get_node("CommodityBox/CommodityCounter").text = String(commodity.stock)
