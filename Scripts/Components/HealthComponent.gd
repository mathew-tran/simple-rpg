extends Node

@export var Health = 100
var MaxHealth = 100

signal Death

var bIsDead = false

func _ready():
	MaxHealth = Health

func TakeDamage(amount):
	Health -= amount
	if Health <= 0 and bIsDead == false:
		bIsDead = true
		emit_signal("Death")

func IsDead():
	return bIsDead

func GetHealth():
	return Health

func GetMaxHealth():
	return MaxHealth

func Heal(amount):
	Health += amount
	if Health > MaxHealth:
		Health = MaxHealth
