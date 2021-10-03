extends Node2D


func _ready():
	WeatherData.camera = $Camera2D
	$Map/WeatherDirector.can_spawn = true

#func _ready():
#	$AnimationPlayer.play("start")

func _input(event):
	if event is InputEventKey:
		$AnimationPlayer.play_backwards("start")
