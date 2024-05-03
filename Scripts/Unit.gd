extends Node

@onready var HealthComponent = $Health
@onready var StatComponent = $Stat
@onready var Abilities = $Abilities

var AbilityTimer

func _ready():
	AbilityTimer = Timer.new()
	AbilityTimer.autostart = true
	AbilityTimer.one_shot = false

	add_child(AbilityTimer)
