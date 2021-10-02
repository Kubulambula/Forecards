extends Node

enum {RAIN, TORNADO}

var map = null

var card_container = null setget set_card_container
<<<<<<< Updated upstream:scripts/weather_data.gd
var cards = ["res://scenes/cards/card.tscn"]
=======
var cards = ["res://scenes/cards/card.tscn", "res://scenes/cards/card.tscn", "res://scenes/cards/card.tscn", "res://scenes/cards/card.tscn", "res://scenes/cards/card.tscn", "res://scenes/cards/card.tscn",]
>>>>>>> Stashed changes:scripts/singletons/weather_data.gd

# New container annouced itself so give it some data
func set_card_container(value):
	card_container = value
	card_container.setup(cards)
