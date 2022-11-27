extends WindowDialog


onready var main = get_parent()
onready var timer = main.get_node('Timer')
onready var ready_button_label = main.get_node("ReadyButtonLabel")


func _ready():
	pass 


func _on_Start_button_up():
	# Start the timer if a focus theme is selected and update start button text
	timer.start()
	ready_button_label.text = 'Pause'
	main.focus_theme_mode = ""
	
	hide()
