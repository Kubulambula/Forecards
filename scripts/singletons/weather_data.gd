extends Node

enum {INVALID, RAIN, TORNADO}

var map = null

var card_container = null setget set_card_container
var cards = ["res://scenes/cards/card.tscn"]

# New container annouced itself so give it some data
func set_card_container(value):
	card_container = value
	card_container.setup(cards)
