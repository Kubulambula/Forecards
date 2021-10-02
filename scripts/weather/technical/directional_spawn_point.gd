extends RayCast2D

var current_effect = null

func spawn(what):
	current_effect = what.instance()
	current_effect.direction = cast_to.normalized()
	add_child(current_effect)
