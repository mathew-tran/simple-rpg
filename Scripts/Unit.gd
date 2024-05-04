extends Node

class_name Unit

@onready var HealthComponent = $Health
@onready var StatComponent = $Stat
@onready var Abilities = $Abilities

@onready var NameLabel = $Control/VBoxContainer/Label
@onready var AbilBar = $Control/VBoxContainer/AbilBar
@onready var HealthBar = $Control/HealthBar
@onready var HealthLabel = $Control/HealthBar/Label
@export var UnitName = "test"

var AbilityTimer : Timer

var TeamType : DEFS.TEAM_TYPE

var DamageTextClass = preload("res://Prefabs/UI/DamageText.tscn")

signal Death


func _ready():
	NameLabel.text = UnitName

	AbilityTimer = Timer.new()
	AbilityTimer.autostart = true
	AbilityTimer.one_shot = false
	AbilityTimer.connect("timeout", Callable(self, "OnAbilityTimerTimeout"))
	add_child(AbilityTimer)

func TakeDamage(amount):
	HealthComponent.TakeDamage(amount)

func IsAlive():
	return HealthComponent.IsDead() == false

func Setup(teamType):
	TeamType = teamType
	if TeamType == DEFS.TEAM_TYPE.ENEMY:
		$Sprite2D.flip_h = true
		add_to_group("enemy_team")
	else:
		add_to_group("player_team")
	add_to_group("unit")

	HealthBar.max_value = HealthComponent.GetMaxHealth()
	HealthBar.value = HealthComponent.GetHealth()
	HealthComponent.connect("DamageTaken", Callable(self, "OnDamageTaken"))
	HealthComponent.connect("Death", Callable(self, "OnDeath"))
	OnDamageTaken(0)

func OnDeath():
	HealthLabel.text = "DEAD"

	HealthBar.value = 0
	AbilityTimer.stop()
	if TeamType == DEFS.TEAM_TYPE.ENEMY:
		queue_free()
	emit_signal("Death")

func Pause():
	AbilityTimer.stop()

func OnDamageTaken(amount):
	HealthBar.value = HealthComponent.GetHealth()
	HealthLabel.text = str(HealthComponent.GetHealth()) + "/" + str(HealthComponent.GetMaxHealth())
	$Sprite2D.visible = false
	$HitTimer.start()
	if amount != 0:

		var dmgText = DamageTextClass.instantiate() as DamageText
		dmgText.Amount = amount
		Helper.GetBattlefield().add_child(dmgText)
		dmgText.global_position = $Sprite2D.global_position - Vector2(0, 20)



func OnAbilityTimerTimeout():
	if is_instance_valid(Abilities) == false:
		return
	Abilities.GetRandomAbility().DoAbility()


func _on_poll_timer_timeout():
	AbilBar.max_value = AbilityTimer.wait_time
	AbilBar.value = AbilityTimer.wait_time - AbilityTimer.time_left


func _on_hit_timer_timeout():
	$Sprite2D.visible = true
