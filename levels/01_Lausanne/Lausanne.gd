extends Node2D


const Commodity = preload("res://ui/Commodities/Commodity.gd")

export var start_wheat: int
export var start_wood: int
export var start_pork: int
export var start_people: int

var commodities: Dictionary

onready var hud: CanvasLayer = $HUD

### Resources
# People
var currentPeople: int = start_people
var peoplePerTurn: int = 0

# Salt
var currentSalt: int = 0
var saltPerTurn: int = 0

# Leather
var currentLeather: int = 0
var leatherPerTurn: int = 0

# Skin
var currentSkin: int = 0
var skinPerTurn: int = 0

# Bark
var currentBark: int = 0
var barkPerTurn: int = 0

# Meat pastry
var currentMeatPastry: int = 0
var meatPastryPerTurn: int = 0

# Dough
var currentDough: int = 0
var doughPerTurn: int = 0

# Meat
var currentMeat: int = 0
var meatPerTurn: int = 0

# Bread
var currentBread: int = 0
var breadPerTurn: int = 0

# Flour
var currentFlour: int = 0
var flourPerTurn: int = 0

# Shoes
var currentShoes: int = 0
var shoesPerTurn: int = 0

# Wood log
var currentWoodLog: int = 0
var woodLogPerTurn: int = 0

# Plank
var currentPlank: int = 0
var plankPerTurn: int = 0

### Inhabitants upkeep

# TODO

var currentTurn: int = 1


func _ready():
	print(commodities.wheat.stock)


func _enter_tree():
	var wheat = Commodity.new("wheat", preload("res://assets/ressources_icons/oat.svg"), start_wheat, 10)
	var wood = Commodity.new("wood", preload("res://assets/ressources_icons/wood-pile.svg"), start_wood, 10)
	var pork = Commodity.new("pork", preload("res://assets/ressources_icons/pig.svg"), start_pork, 10)

	commodities = {
		"wheat": wheat,
		"wood": wood,
		"pork": pork,
		}
	Global.commodities = commodities


func add_to_resource_per_turn(resource, amount):
	pass
