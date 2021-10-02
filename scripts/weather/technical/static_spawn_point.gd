extends Node2D

var current_effect = null

func spawn(what):
	add_child(what.instance())
