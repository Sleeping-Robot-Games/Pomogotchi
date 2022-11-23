extends WindowDialog

onready var main = get_parent()
onready var timer = main.get_node('Timer')
onready var ready_button = main.get_node("Ready")

const DESCRIPTION_THEME_TEXT = {
	'Adventure': "",
	'Exercise': "",
	'Study': "",
	'Play': ""
}

func _ready():
	pass


func _on_Start_button_up():
	if main.focus_theme_mode:
		# Start the timer if a focus theme is selected and update start button text
		timer.start()
		ready_button.text = 'Pause'
		hide()

func _on_FocusTheme_pressed():
	main.focus_theme_mode = main.focus_theme_group.get_pressed_button().name
	$ThemeDescription.bbcode_text = '[center]' + DESCRIPTION_THEME_TEXT[main.focus_theme_mode]
	$ThemeDescription.show()


func _on_FocusPopUp_popup_hide():
	$ThemeDescription.hide()
	# Untoggle the focus theme button so a new one can be chosen
	if main.focus_theme_group.get_pressed_button():
		main.focus_theme_group.get_pressed_button().pressed = false
