extends Node2D



func _ready():
	apply_xp()

func _on_Back_button_up():
	hide()
	get_node('../Main').show()

func apply_xp():
	for xp_name in g.PET_STATE.xp:
		var xp_node = get_node(xp_name)
		for xp_bar in xp_node.get_node('XPContainer').get_children():
			if int(xp_bar.name[2]) <= g.PET_STATE.xp[xp_name]:
				print( int(xp_bar.name[2]))
				xp_bar.texture = load('res://assets/uiArt/full-xp.png')
			else:
				xp_bar.texture = load('res://assets/uiArt/empty-xp.png')
				
