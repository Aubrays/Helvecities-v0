extends HBoxContainer

var commodity
export var commodity_name: String


func _ready():
	for item in Global.commodities:
		if item.commodity_name == commodity_name:
			self.commodity = item
	$CommodityIcon.set_texture(self.commodity.icon_texture)
	$CommodityBox/CommodityLabel.text = String(self.commodity.stock)


func update_text():
	$CommodityBox/CommodityLabel.text = String(self.commodity.stock)
