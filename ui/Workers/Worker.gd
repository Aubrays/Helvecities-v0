class_name Worker
extends Node
# A worker represents people they can produce commodities


var worker_name: String
var quantity: float # equivalent to permillage
var previous_quantity: float = 0.0
var commodities_production: Array
var enabled: bool


func _init(worker_name: String, quantity: float = 0, enabled: bool = false):
	var worker: Dictionary
	for item in Global.existing_workers:
		if item.name == worker_name:
			worker = item
	
	for commodity_info in worker.commodities:
		# ex: "flour", "bark" for miller
		for commodity in Global.commodities:
			if commodity.commodity_name == commodity_info:
				self.commodities_production.append(
					commodity
				)
				
	self.worker_name = worker.name
	self.quantity = quantity
	self.enabled = enabled


func produce():
	# Produce the commodities
	for commodity_producted in self.commodities_production:
		commodity_producted.stock += self.quantity * Global.inhabitants_number
		# Consume the ingredients for each commodity producted
		for ingredient in commodity_producted.ingredients:
			ingredient.commodity.stock -= self.quantity * Global.inhabitants_number * ingredient.quantity


func update_quantity_at_end_turn():
	self.previous_quantity = self.quantity

