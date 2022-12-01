extends Node2D


func _ready():
	apply_xp()
	apply_stats()

func _on_Back_button_up():
	hide()
	get_node('../Main').show()
	
func apply_stats():
	$Hunger.value = g.PET_STATE.hunger
	$Happiness.value = g.PET_STATE.happiness
	$Clean.value = g.PET_STATE.clean

func apply_xp():
	for xp_name in g.PET_STATE.xp:
		## Updates current level xp label
		var xp_label = get_node(xp_name+'/XPLabel')
		xp_label.text = str(g.PET_STATE.xp[xp_name].currentLevelXP)+"/100"
		## Fills level xp bars
		var xp_bar_container = get_node(xp_name+'/XPBarContainer')
		for xp_bar in xp_bar_container.get_children():
			var bar_level = int(xp_bar.name[5])
			if bar_level < g.PET_STATE.xp[xp_name].level:
				xp_bar.value = 100
			elif bar_level == g.PET_STATE.xp[xp_name].level:
				xp_bar.value = g.PET_STATE.xp[xp_name].currentLevelXP
			else:
				xp_bar.value = 0
		


func _on_Profile_visibility_changed():
	if visible:
		apply_xp()
		apply_stats()
