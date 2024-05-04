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
	HealthBar.max_value = HealthComponent.GetMaxHealth()
	HealthBar.value = HealthComponent.GetHealth()
	HealthComponent.connect("DamageTaken", Callable(self, "OnDamageTaken"))
	HealthComponent.connect("Death", Callable(self, "OnDeath"))

func OnDeath():
	HealthLabel.text = "DEAD"
	HealthBar.value = 0
	AbilityTimer.stop()
	if TeamType == DEFS.TEAM_TYPE.ENEMY:
		queue_free()


func OnDamageTaken():
	HealthBar.value = HealthComponent.GetHealth()
	HealthLabel.text = str(HealthComponent.GetHealth()) + "/" + str(HealthComponent.GetMaxHealth())

func OnAbilityTimerTimeout():
	Abilities.GetRandomAbility().DoAbility()


func _on_poll_timer_timeout():
	AbilBar.max_value = AbilityTimer.wait_time
	AbilBar.value = AbilityTimer.wait_time - AbilityTimer.time_left
