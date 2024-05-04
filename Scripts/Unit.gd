extends Node

class_name Unit

@onready var HealthComponent = $Health
@onready var StatComponent = $Stat
@onready var Abilities = $Abilities

@onready var NameLabel = $Control/VBoxContainer/Label
@onready var AbilBar = $Control/VBoxContainer/AbilBar
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

func OnAbilityTimerTimeout():
	Abilities.GetRandomAbility().DoAbility()


func _on_poll_timer_timeout():
	AbilBar.max_value = AbilityTimer.wait_time
	AbilBar.value = AbilityTimer.wait_time - AbilityTimer.time_left
