extends Node


func GetRandomEnemy(team):
	var units = []
	if team == DEFS.TEAM_TYPE.ENEMY:
		units = get_tree().get_nodes_in_group("player_team")
	else:
		units = get_tree().get_nodes_in_group("enemy_team")

	var aliveUnits = []
	for unit in units:
		if unit.IsAlive():
			aliveUnits.append(unit)
	if aliveUnits:
		return aliveUnits.pick_random()
	else:
		return null

func GetTeam(team):
	var units = []
	if team == DEFS.TEAM_TYPE.ENEMY:
		units = get_tree().get_nodes_in_group("enemy_team")
	else:
		units = get_tree().get_nodes_in_group("player_team")
	return units

func GetAllUnits():
	return get_tree().get_nodes_in_group("unit")
