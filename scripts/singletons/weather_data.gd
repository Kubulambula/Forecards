extends Node

enum TYPES {INVALID, RAIN, TORNADO, FIRE}

var map = null

var card_container = null setget set_card_container
var cards = ["res://scenes/cards/RAIN.tscn", "res://scenes/cards/FIRE.tscn", "res://scenes/cards/TORNADO.tscn", "res://scenes/cards/ROCK.tscn", "res://scenes/cards/card.tscn", "res://scenes/cards/card.tscn",]

# New container annouced itself so give it some data
func set_card_container(value):
	card_container = value
	card_container.setup(cards)
