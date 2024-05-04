extends Node2D

class_name DamageText
var Amount = 0

func _ready():
	$Label.text = str(Amount)
	$AnimationPlayer.play("anim")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
