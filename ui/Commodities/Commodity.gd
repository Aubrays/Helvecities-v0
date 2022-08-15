class_name Commodity
extends Node
# A commodity is a in-game resource to collect, like wood or wheat.
# The name commodity was choosen because resource is a reserved name in GDScript.


#const commodities = [
#	{
#		"name": "wheat",
#		"icon": "res://assets/ressources_icons/oat.svg"
#	},
#	{
#		"name": "wood",
#		"icon": "res://assets/ressources_icons/wood-pile.svg"
#	},
#	{
#		"name": "pork",
#		"icon": "res://assets/ressources_icons/pig.svg"
#	},
#
#]

var type_name: String
var icon_texture: Texture
var stock: int
var evolution_per_turn: int


func _init(type_name, icon_texture, initial_stock, initial_evolution_per_turn = 0):
	self.type_name = type_name
	self.icon_texture = icon_texture
	self.stock = initial_stock
	self.evolution_per_turn = initial_evolution_per_turn
