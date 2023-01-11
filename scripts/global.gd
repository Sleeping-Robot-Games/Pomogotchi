extends Node

const PET_STATE = {
	'gold': 0,
	'hunger': 50,
	'happiness': 50,
	'clean': 50,
	'fp': 0,
	'xp': {
		'Strength': {
			'level': 0,
			'currentLevelXP': 0
			},
		'Intelligence': {
			'level': 0,
			'currentLevelXP': 0
		},
		'Luck': {
			'level': 0,
			'currentLevelXP': 0
		}
	}
}

func update_pet_gold(gold):
	PET_STATE.gold += gold

func update_pet_statuses(status_dict):
	# status_dict = {'hunger': 1, clean: -1}
	for status in status_dict.keys():
		# Prevent negative statuses
		if PET_STATE[status] == 0 and status_dict[status] < 0:
			return
		PET_STATE[status] += status_dict[status]

func update_pet_xp(xp_dict):
	# xp_dict = {'Strength': 1, 'Luck': 1}
	for xp_name in xp_dict.keys():
		PET_STATE.xp[xp_name].currentLevelXP += xp_dict[xp_name]
		# level up!
		if PET_STATE.xp[xp_name].currentLevelXP == 100:
			PET_STATE.xp[xp_name].currentLevelXP = 0
			PET_STATE.xp[xp_name].level += 1
