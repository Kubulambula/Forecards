extends Node


func _ready():
	set_pause_mode(Node.PAUSE_MODE_PROCESS)
	var asp = AudioStreamPlayer.new()
	asp.stream = preload("res://audio/04 A Storm on the Horizon Pieces of the Soul.mp3") 
	asp.play()
	add_child(asp)
