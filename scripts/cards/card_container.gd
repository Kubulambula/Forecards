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


func remap_value_between_ranges(value: float, old_range: Vector2, new_range: Vector2) -> float:
	return ((value - old_range.x) / (old_range.y - old_range.x)) * (new_range.y - new_range.x) + new_range.x

func _process(delta):
	pass
#	$CanvasLayer/CardPoints.rect_position.y = remap_value_between_ranges(get_local_mouse_position().y, Vector2(0,0), Vector2(0,0))
	# > 250 up
	# < 250 down
#	print(get_local_mouse_position().y)
#	if get_local_mouse_position().y >= 250:
#		$CanvasLayer/CardPoints.rect_position.y = lerp(rect_position.y, 0, 0.01)
#	else:
#		$CanvasLayer/CardPoints.rect_position.y = lerp(rect_position.y, 500, 0.01)
#	rect_position.y = lerp(rect_position.y, clamp(get_local_mouse_position().y, 0, 500), 0.4)
#	if get_local_mouse_position().y > 500:
#		rect_position = lerp(rect.position.y, ,0.4)
#	else:
#		pass
