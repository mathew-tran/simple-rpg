extends Node

class_name BaseAbility

enum TYPE {
	OFFENSIVE,
	DEFENSIVE
}

enum TARGET {
	SELF,
	SINGLE_ALLY,
	ALL_ALLY,
	SINGLE_ENEMY,
	ALL_ENEMY
}

@export var Type : TYPE
@export var Target : TARGET
@export var Description = "Describe ability"
var TargetUnit

var OwningUnit

func _ready():
	OwningUnit = get_parent().get_parent()

func DoAbility():
	pass
