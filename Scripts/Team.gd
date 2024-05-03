extends Node

@onready var Units = $Units
@onready var Slots = $Slots

func Setup():
	for x in range(0, Units.get_child_count()):
		Units.get_child(x).global_position = Slots.get_child(x).global_position

