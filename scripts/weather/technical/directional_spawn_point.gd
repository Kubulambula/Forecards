extends RayCast2D

var current_effect = null

func spawn(what, where):
	if randi() % 4 != 1:
		current_effect = what.instance()
		current_effect.spawner = self
		current_effect.start_point = global_position
		current_effect.dest_point = global_position + cast_to.normalized()
		where.add_child(current_effect)
