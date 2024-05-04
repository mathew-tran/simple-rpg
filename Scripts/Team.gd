extends Node

@onready var Units = $Units
@onready var Slots = $Slots
@export var TeamType : DEFS.TEAM_TYPE

func Setup():
	for x in range(0, Units.get_child_count()):
		var unit = Units.get_child(x) as Unit
		unit.Setup(TeamType)
		unit.global_position = Slots.get_child(x).global_position

