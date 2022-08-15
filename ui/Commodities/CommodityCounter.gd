extends HBoxContainer


export var commodity_name: String


func _ready():
	var commodity = Global.commodities[commodity_name]
	$CommodityIcon.set_texture(commodity.icon_texture)
	$CommodityBox/CommodityLabel.text = String(commodity.stock)
