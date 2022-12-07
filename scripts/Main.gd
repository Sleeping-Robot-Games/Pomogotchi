extends Node2D

var timer_mode = c.FOCUS
var focus_theme_mode = ''
var timer_seconds =  c.STANDARD_FOCUS_SECONDS

export(ButtonGroup) var focus_theme_group

onready var ui_to_hide_on_focus = [
	$TaskContainer,
]

func _ready():
	$Mode.text = timer_mode
	update_display_time()
	for button in focus_theme_group.get_buttons():
		button.connect("pressed", $FocusPopUp, "_on_FocusTheme_pressed")


func update_display_time():
	var minutes = (int(timer_seconds) / 60) % 60
	var seconds = (int(timer_seconds)) % 60
	$Time.text = "%02d:%02d" % [minutes, seconds]


func _on_Ready_button_up():
	if $Timer.is_stopped():
		if timer_mode == c.FOCUS:
			$FocusPopUp.popup()
		else:
			$BreakPopUp.popup()
	else:
		$Timer.paused = !$Timer.paused
		if $Timer.paused:
			$ReadyButtonLabel.text = 'Resume'
		else: 
			$ReadyButtonLabel.text = 'Pause'
			
func update_points_from_focus():
	var main_increase = ""
	var bonus_increase = ""
	if focus_theme_mode == 'Adventure':
		# Increase Gold
			# Strength level increases
		var gold = 1 + g.PET_STATE.xp.Strength.level
		main_increase = str(gold)+' Gold'
		g.update_pet_gold(gold)
		randomize()
		if randi()%10+1 >= 7:
		# 30% chance to find an item
			# TODO: Function to find items
			# Intelligence level increase quality
			bonus_increase = "AND found a ball!"
		# If the pet didn't find an item and their happy get Luck
		if not bonus_increase and g.PET_STATE.happiness >= 60:
				bonus_increase = "AND gained +1 bonus Luck from being happy!"
				g.update_pet_xp({'Luck': 1})
		# Decrease all statuses
		g.update_pet_statuses({'hunger': -1, 'happiness': -1, 'clean': -1})
	elif focus_theme_mode == 'Exercise':
		pass
	elif focus_theme_mode == 'Study':
		pass
	elif focus_theme_mode == 'Play':
		pass
		
	$BreakPopUp/Results.text = "Your pet gained +{main_increase} from {focus_theme_mode} {bonus_increase}".format({'main_increase': main_increase, 'focus_theme_mode': focus_theme_mode, 'bonus_increase': bonus_increase})


func _on_Timer_timeout():
	timer_seconds -= 1
	if timer_seconds == 0:
		# Stop the timer when it gets to zero
		$Timer.stop()
		# Update the points if focus was on
		if timer_mode == c.FOCUS:
			update_points_from_focus()
		# Flip from Focus to Break or Vis Versa
		timer_seconds = c.STANDARD_BREAK_SECONDS if timer_mode == c.FOCUS else c.STANDARD_FOCUS_SECONDS
		timer_mode = c.BREAK if timer_mode == c.FOCUS else c.FOCUS
		# Update the ready button and mode text
		$ReadyButtonLabel.text = 'Ready'
		$Mode.text = timer_mode
		
		if timer_mode == c.BREAK:
			$BreakPopUp.popup()
			# Show other UI not relevant to the focus
			for element in ui_to_hide_on_focus:
				element.show()
		else:
			$FocusPopUp.popup()
		
	update_display_time()


func _on_Profile_button_up():
	hide()
	get_node('../Profile').show()

