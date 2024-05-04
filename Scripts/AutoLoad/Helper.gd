extends Node


func GetRandomEnemy(team):
	var units = []
	if team == DEFS.TEAM_TYPE.ENEMY:
		units = get_tree().get_nodes_in_group("player_team")
	else:
		units = get_tree().get_nodes_in_group("enemy_team")

	if units:
		return units.pick_random()
	else:
		return null
