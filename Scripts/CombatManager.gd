extends Node

var UnitQueue

@onready var PlayerTeam = $PlayerTeam
@onready var EnemyTeam = $EnemyTeam

var TeamCount = 0

func _ready():
	Setup()

func Setup():
	PlayerTeam.Setup()
	EnemyTeam.Setup()
	var playerUnits = Helper.GetTeam(DEFS.TEAM_TYPE.PLAYER)
	TeamCount = len(playerUnits)
	for unit in playerUnits:
		unit.connect("Death", Callable(self, "OnDeath"))

func OnDeath():
	var playerUnits = Helper.GetTeam(DEFS.TEAM_TYPE.PLAYER)
	for unit in playerUnits:
		if unit.IsAlive():
			return
	var allUnits = Helper.GetAllUnits()
	for unit in allUnits:
		unit.Pause()
