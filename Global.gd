extends Node


const existing_commodities = [
	{
		"name": "wheat",
		"icon": "res://assets/ressources_icons/oat.svg",
		"tradable": true,
		"ingredients" : [],
	},
	{
		"name": "wood",
		"icon": "res://assets/ressources_icons/wood-pile.svg",
		"tradable": true,
		"ingredients" : [],
	},
	{
		"name": "pork",
		"icon": "res://assets/ressources_icons/pig.svg",
		"tradable": true,
		"ingredients" : [],
	},
	{
		"name": "salt",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [],
	},
	{
		"name": "leather",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "skin",
				"quantity": 1,
			},
			{
				"name": "bark",
				"quantity": 1,
			},
		],
	},
	{
		"name": "skin",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "pork",
				"quantity": 1,
			},
		],
	},
	{
		"name": "bark",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "wood",
				"quantity": 1,
			},
		],
	},
	{
		"name": "raw_meat_pastry",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": false,
		"ingredients" : [
			{
				"name": "meat",
				"quantity": 1,
			},
			{
				"name": "flour",
				"quantity": 1,
			},
		],
	},
	{
		"name": "meat_pastry",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "raw_meat_pastry",
				"quantity": 1,
			},
			{
				"name": "wood_log",
				"quantity": 1,
			},
		],
	},
	{
		"name": "dough",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": false,
		"ingredients" : [
			{
				"name": "flour",
				"quantity": 1,
			},
		],
	},
	{
		"name": "meat",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "pork",
				"quantity": 1,
			},
		],
	},
	{
		"name": "bread",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "dough",
				"quantity": 1,
			},
			{
				"name": "wood_log",
				"quantity": 1,
			},
		],
	},
	{
		"name": "flour",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "wheat",
				"quantity": 1,
			},
		],
	},
	{
		"name": "shoes",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "leather",
				"quantity": 1,
			},
		],
	},
	{
		"name": "wood_log",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "wood",
				"quantity": 1,
			},
		],
	},
	{
		"name": "plank",
		"icon": "res://assets/ressources_icons/cube.svg",
		"tradable": true,
		"ingredients" : [
			{
				"name": "wood",
				"quantity": 1,
			},
		],
	},
]
var existing_workers = [
	{
		"name": "builder",
		"commodities": [],
	},
	{
		"name": "farmer",
		"commodities": [
			"wheat",
			"pork",
		],
	},
	{
		"name": "baker",
		"commodities": [
			"dough",
		],
	},
	{
		"name": "confectioner",
		"commodities": [
			"raw_meat_pastry",
		],
	},
	{
		"name": "butcher",
		"commodities": [
			"meat",
			"skin",
		],
	},
	{
		"name": "woodcutter",
		"commodities": [
			"wood",
			"wood_log",
		],
	},
	{
		"name": "carpenter",
		"commodities": [
			"plank",
		],
	},
	{
		"name": "fournier",
		"commodities": [
			"bread",
			"meat_pastry",
		],
	},
	{
		"name": "miller",
		"commodities": [
			"flour",
			"bark",
		],
	},
	{
		"name": "cobbler",
		"commodities": [
			"shoes",
		],
	},
	{
		"name": "tanner",
		"commodities": [
			"leather",
		],
	},
	{
		"name": "merchant",
		"commodities": [],
	},
] 
onready var commodities: Array
onready var districts
onready var workers: Array
onready var turn_number: int = 1
onready var inhabitants_number: int = 500
onready var step: int = 1


