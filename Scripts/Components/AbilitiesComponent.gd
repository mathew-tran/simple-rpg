extends Node


func GetRandomAbility():
	return get_child(randi_range(0, get_child_count()- 1))
