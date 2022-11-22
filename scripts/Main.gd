extends Node2D

var timer_mode = 'focus'
var focus_theme_mode = ''
var timer_seconds = 1500

export(ButtonGroup) var focus_theme_group

func _ready():
	for button in focus_theme_group.get_buttons():
		button.connect("pressed", self, "_on_FocusTheme_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_display_time():
	var minutes = (int(timer_seconds) / 60) % 60 # Using modulo returns the number of mins
	var seconds = (int(timer_seconds)) % 60
	$Time.text = "{min}:{sec}".format({"min": minutes, "sec": seconds})


func _on_FocusTheme_pressed():
	focus_theme_mode = focus_theme_group.get_pressed_button().name
	


func _on_Start_button_up():
	if focus_theme_mode:
		$Timer.start()


func _on_Timer_timeout():
	timer_seconds -= 1
	update_display_time()
