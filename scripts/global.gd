extends Node

const PET_STATE = {
	'gold': 0,
	'hunger': 70,
	'happiness': 80,
	'clean': 20,
	'fp': 0,
	'xp': {
		'Strength': {
			'level': 0,
			'currentLevelXP': 20
			},
		'Intelligence': {
			'level': 7,
			'currentLevelXP': 90
		},
		'Luck': {
			'level': 5,
			'currentLevelXP': 45
		}
	}
}

func change_pet_state(state, num):
	PET_STATE[state] += num
