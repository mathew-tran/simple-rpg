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

var TargetUnit : Unit
var OwningUnit : Unit

func _ready():
	OwningUnit = get_parent().get_parent()

func DetermineTarget():
	if Target == TARGET.SELF:
		TargetUnit = OwningUnit
	if Target == TARGET.SINGLE_ENEMY:
		TargetUnit = Helper.GetRandomEnemy(OwningUnit.TeamType)

func DoAbility():
	DetermineTarget()
	print("Do ability on " + TargetUnit.name + " with " + OwningUnit.name)
