extends Node2D

const Commodity = preload("res://ui/Commodities/Commodity.gd")
const CostPanel = preload("res://ui/Districts/CostPanel.tscn")
const Worker = preload("res://ui/Workers/Worker.gd")
const StepsFunc = preload("res://levels/01_Lausanne/Steps.gd")
const DistrictWindow = preload("res://ui/Districts/DistrictWindow.tscn")

var districts = [
	{
		"name": "La Palud",
		"build_step": 1,
		"cost": {
			"wheat": 5000,
		},
	},
	{
		"name": "Le Bourg",
		"build_step": 2,
		"cost": {
			"wheat": 15000,
			"plank": 4000,
		},
	},
]

var available_commodities = [
	{
		"name": "wheat",
		"start_quantity": 5000,
	},
	{
		"name": "wood",
		"start_quantity": 0,
	},
	{
		"name": "pork",
		"start_quantity": 0,
	},
	{
		"name": "salt",
		"start_quantity": 0,
	},
	{
		"name": "leather",
		"start_quantity": 0,
	},
	{
		"name": "skin",
		"start_quantity": 0,
	},
	{
		"name": "bark",
		"start_quantity": 0,
	},
	{
		"name": "raw_meat_pastry",
		"start_quantity": 0,
	},
	{
		"name": "meat_pastry",
		"start_quantity": 0,
	},
	{
		"name": "dough",
		"start_quantity": 0,
	},
	{
		"name": "meat",
		"start_quantity": 0,
	},
	{
		"name": "bread",
		"start_quantity": 0,
	},
	{
		"name": "flour",
		"start_quantity": 0,
	},
	{
		"name": "shoes",
		"start_quantity": 0,
	},
	{
		"name": "wood_log",
		"start_quantity": 0,
	},
	{
		"name": "plank",
		"start_quantity": 0,
	},
]

var available_workers = [
	{
		"name": "builder",
	},
	{
		"name": "farmer",
	},
	{
		"name": "baker",
	},
	{
		"name": "confectioner",
	},
	{
		"name": "butcher",
	},
	{
		"name": "woodcutter",
	},
	{
		"name": "carpenter",
	},
	{
		"name": "fournier",
	},
	{
		"name": "miller",
	},
	{
		"name": "cobbler",
	},
	{
		"name": "tanner",
	},
	{
		"name": "merchant",
	},
]

var cost_panels: Dictionary

### Inhabitants upkeep
# 1 turn = 1 year of 100 inhabitants
export var inhabitant_upkeep = {
	"bread": 10, 
	"meat": 3,
	"shoes": 1,
	"meat_pastry": 1,
	"wood_log": 10,
	"salt": 2,
}

export var start_wheat: int
export var start_wood: int
export var start_pork: int
export var start_people: int

onready var hud: CanvasLayer = $HUD
onready var turn_counter: HBoxContainer = $HUD/SidePanel/VBoxContainer/ActionContainer/TurnCounter
onready var currentTurn = Global.turn_number
onready var inhabitants_number = Global.inhabitants_number



func _ready():
	Events.connect("turn_ended", self, "_on_Events_turn_ended")
	Events.connect("district_build_confirmed", self, "_on_Events_district_build_confirmed")
	var steps = StepsFunc.get_steps()


func _enter_tree():
	for commodity in available_commodities:
		Global.commodities.append(
			Commodity.new(String(commodity.name), commodity.start_quantity)
		)
		
	for commodity in Global.commodities:
		commodity.add_ingredients()
		
	for worker in available_workers:
		Global.workers.append(
			Worker.new(worker.name)
		)
	for district in districts:
		district["build"] = false
		Global.districts.append(district)


func _on_Events_turn_ended():
	Global.turn_number += 1
	turn_counter.update_turn_counter(Global.turn_number)
	
	for worker in Global.workers:
		worker.update_quantity_at_end_turn()
		worker.produce()
	
	for commodity in Global.commodities:
		commodity.update_stock()
		
	for i in inhabitant_upkeep:
		for commodity in Global.commodities:
			if commodity.commodity_name == i:
				commodity.stock -= inhabitant_upkeep[i] * Global.inhabitants_number
			if commodity.stock < 0:
	#			emit_signal("commodity_out_of_stock", commodity)
				commodity.stock = 0
			
	get_tree().call_group("commodity_counters", "update_text")
	get_node("HUD/CommoditiesWindow").update_text()
	
func _on_Events_district_build_confirmed(district_name):
	var district_node: Area2D
	match district_name:
		"La Palud":
			district_node = get_node("Map/Palud")
		"Le Bourg":
			district_node = get_node("Map/Bourg")
		"Saint-Laurent":
			district_node = get_node("Map/StLaurent")
		"Le Pont":
			district_node = get_node("Map/Pont")
	
	district_node.get_node("PolygonColor").color = Color( 0, 0, 0, 0)
	
	get_tree().call_group("commodity_counters", "update_text")
	get_node("HUD/CommoditiesWindow").update_text()


func _on_Palud_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		hide_cost_panel("La Palud")
		show_cost_panel("La Palud", event.position)
		
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		show_build_panel("La Palud")

func _on_Palud_mouse_exited():
	hide_cost_panel("La Palud")


func _on_Bourg_input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion:
		hide_cost_panel("Le Bourg")
		show_cost_panel("Le Bourg", event.position)
		
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		show_build_panel("Le Bourg")


func _on_Bourg_mouse_exited():
	hide_cost_panel("Le Bourg")


func show_cost_panel(district_name, position):
	var district_panel = CostPanel.instance()
	
	for district in Global.districts:
		if district_name == district.name:
			district_panel.set("district", district)

	var offset := 10
	district_panel.rect_position.x = position[0] + offset
	district_panel.rect_position.y = position[1] + offset
	
	var district_node : Area2D
	match district_name:
		"La Palud":
			district_node = get_node("Map/Palud")
		"Le Bourg":
			district_node = get_node("Map/Bourg")
		"Saint-Laurent":
			district_node = get_node("Map/StLaurent")
		"Le Pont":
			district_node = get_node("Map/Pont")
	# TODO Manage the others nodes...
	
	district_node.get_node("PolygonColor").color = Color( 0.827451, 0.827451, 0.827451, 0.82421875 )
	
	self.add_child(district_panel)
	district_panel.show()


func hide_cost_panel(district_name):
	
	var district_node : Area2D
	match district_name:
		"La Palud":
			district_node = get_node("Map/Palud")
		"Le Bourg":
			district_node = get_node("Map/Bourg")
		"Saint-Laurent":
			district_node = get_node("Map/StLaurent")
		"Le Pont":
			district_node = get_node("Map/Pont")
	# TODO Manage the others nodes...
	
	for district in Global.districts:
		if district_name == district.name:
			if district.build == false:
				district_node.get_node("PolygonColor").color = Color( 0, 0, 0, 0.82421875 )
			if district.build == true:
				district_node.get_node("PolygonColor").color = Color( 0, 0, 0, 0 )
	self.remove_child(get_node("CostPanel"))


func show_build_panel(district_name):
	for district in Global.districts:
		if district_name == district.name and district.build == false and district.build_step == Global.step:
			var district_window = DistrictWindow.instance()
			district_window.init(district_name)
			hud.add_child(district_window)
			district_window.show()
	







