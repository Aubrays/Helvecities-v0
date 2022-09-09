class_name Commodity
extends Node
# A commodity is a in-game resource to collect, like wood or wheat.
# The name commodity was choosen because resource is a reserved name in GDScript.

var commodity_name: String
var icon_texture: Texture
var ingredients: Array = []
var stock: int
var evolution_per_turn: int


func _init(commodity_name, initial_stock, initial_evolution_per_turn = 0):
	var commodity: Dictionary
	for item in Global.existing_commodities:
		if item.name == commodity_name:
			commodity = item

	self.commodity_name = commodity.name
	self.icon_texture = load(commodity.icon)
	self.stock = initial_stock
	self.evolution_per_turn = initial_evolution_per_turn
	

func add_ingredients():
	var commodity: Dictionary
	for item in Global.existing_commodities:
		if item.name == commodity_name:
			commodity = item
	
	for ingredient in commodity.ingredients:
		for instancied_commodity in Global.commodities:
			if instancied_commodity.commodity_name == ingredient.name:
				self.ingredients.append(
					{
						"commodity": instancied_commodity,
						"quantity": ingredient.quantity
					}
						)


func update_stock():
	stock += evolution_per_turn
