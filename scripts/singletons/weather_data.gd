extends Node

enum TYPES {INVALID, RAIN, TORNADO, FIRE, ROCK, ACID, SNOW}
var empty_card = preload("res://scenes/cards/card.tscn").instance()
var map = null
var gui

var camera = null

var card_container = null setget set_card_container
var cards = ["res://scenes/cards/RAIN.tscn", "res://scenes/cards/SNOW.tscn", "res://scenes/cards/TORNADO.tscn", "res://scenes/cards/ROCK.tscn", "res://scenes/cards/ACID.tscn", "res://scenes/cards/FIRE.tscn"]

var weather_move_speed_multiplier = 1


# New container annouced itself so give it some data
func set_card_container(value):
	card_container = value
	card_container.setup(cards)
