extends Node

var UnitQueue

@onready var PlayerTeam = $PlayerTeam
@onready var EnemyTeam = $EnemyTeam
@onready var EnemySpawner = $Spawner

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

	SetupEnemies()

func SetupEnemies():
	var enemyUnits = Helper.GetTeam(DEFS.TEAM_TYPE.ENEMY)
	for unit in enemyUnits:
		unit.connect("Death", Callable(self, "OnEnemyDeath"))

func OnDeath():
	var playerUnits = Helper.GetTeam(DEFS.TEAM_TYPE.PLAYER)
	for unit in playerUnits:
		if unit.IsAlive():
			return
	var allUnits = Helper.GetAllUnits()
	for unit in allUnits:
		unit.Pause()

func OnEnemyDeath():
	await get_tree().create_timer(.4).timeout
	var enemyUnits = Helper.GetTeam(DEFS.TEAM_TYPE.ENEMY)

	for unit in enemyUnits:
		if unit.IsAlive():
			return
	for x in range(0, randi_range(1,2)):
		EnemyTeam.AddUnit(EnemySpawner.GetEnemy())
	EnemyTeam.Setup()
	SetupEnemies()
