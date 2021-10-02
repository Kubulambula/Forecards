extends Node2D

var received_forecast = WeatherData.TYPES.INVALID


func weather_effect(what):
	if what == received_forecast:
		# good
		pass
	else:
		# bad
		pass
