extends Node2D

var received_forecast = WeatherData.INVALID setget lol

func lol(what):
	print(what)


func weather_effect(what):
	if what == received_forecast:
		# good
		pass
	else:
		# bad
		pass
