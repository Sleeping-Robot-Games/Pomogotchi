extends WindowDialog

onready var main = get_parent()
onready var timer = main.get_node('Timer')
onready var ready_button_label = main.get_node("ReadyButtonLabel")

const DESCRIPTION_THEME_TEXT = {
	'Adventure': "Your pet will adventure during this focus session! Gains gold",
	'Exercise': "Your pet will exercise during this focus session! Gains strength",
	'Study': "Your pet will study during this focus session! Gains intelligence",
	'Play': "Your pet will play during this focus session! Gains happiness"
}

func _ready():
	pass


func _on_Start_button_up():
	if main.focus_theme_mode:
		# Start the timer if a focus theme is selected and update start button text
		timer.start()
		ready_button_label.text = 'Pause'
		hide()
		# Hide other UI not relevant to the focus
		for element in main.ui_to_hide_on_focus:
			element.hide()

func _on_FocusTheme_pressed():
	main.focus_theme_mode = main.focus_theme_group.get_pressed_button().name
	$ThemeDescription.bbcode_text = '[center]' + DESCRIPTION_THEME_TEXT[main.focus_theme_mode]
	$ThemeDescription.show()


func _on_FocusPopUp_popup_hide():
	$ThemeDescription.hide()
	# Untoggle the focus theme button so a new one can be chosen
	if main.focus_theme_group.get_pressed_button():
		main.focus_theme_group.get_pressed_button().pressed = false
