extends Node



static func get_steps():
	var steps = [
		{
			"goals" : {
				"wheat": 5000,
				"district": "Palud",
			},
			"enabled_commodities": [
				"wheat",
			],
			"enabled_workers": [
				"builder",
				"farmer",
			]
		}
	]
	
	return steps
