extends Node

var UnitQueue

@onready var PlayerTeam = $PlayerTeam
@onready var EnemyTeam = $EnemyTeam

func _ready():
	Setup()

func Setup():
	PlayerTeam.Setup()
	EnemyTeam.Setup()
