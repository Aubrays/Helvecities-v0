extends HBoxContainer


export var commodity_name: String


func _ready():
	for item in Global.commodities:
		if item.commodity_name == commodity_name:
			$CommodityIcon.set_texture(item.icon_texture)
			$CommodityBox/CommodityLabel.text = String(item.stock)


func update_text():
	for item in Global.commodities:
		if item.commodity_name == commodity_name:
			$CommodityBox/CommodityLabel.text = String(item.stock)
