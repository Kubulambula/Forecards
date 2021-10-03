extends Control


#TODO reparent card if in city or hand

func _ready():
	WeatherData.card_container = self


# WeatherData call this after MapData.card_container = self (setget)
func setup(cards):
	# Serazeno podle toho jak jsou ve scenetree zeshora dolu
	var card_points = $CanvasLayer/CardPoints.get_children()
	for i in cards.size():
		if i < card_points.size():
			var card = load(cards[i]).instance()
			card.origin_card_point = card_points[i]
			card.zero_rotation = -card_points[i].rect_rotation
			
			card_points[i].add_child(card)
		else:
			push_error("not enough points to put cards in :(")
