extends Node

const PET_STATE = {
	'gold': 0,
	'intelligence': 0,
	'strength': 0,
	'hunger': 0,
	'happiness': 0,
	'fp': 0,
}

func change_pet_state(state, num):
	PET_STATE[state] += num
