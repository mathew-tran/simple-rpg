extends BaseAbility

@export var BaseDamage = 2
@export var DamageRange = 5
var Damage = 0

func CalculateDamage():
	Damage = BaseDamage + randi_range(0, DamageRange)

func DoAbility():
	CalculateDamage()
	DetermineTarget()
	if is_instance_valid(TargetUnit):
		TargetUnit.TakeDamage(Damage)
