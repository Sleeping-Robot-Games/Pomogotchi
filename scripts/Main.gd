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
			$Ready.text = 'Resume'
		else: 
			$Ready.text = 'Pause'


func _on_Timer_timeout():
	timer_seconds -= 1
	if timer_seconds == 0:
		# Stop the timer when it gets to zero
		$Timer.stop()
		# Flip from Focus to Break or Vis Versa
		timer_seconds = c.STANDARD_BREAK_SECONDS if timer_mode == c.FOCUS else c.STANDARD_FOCUS_SECONDS
		timer_mode = c.BREAK if timer_mode == c.FOCUS else c.FOCUS
		# Update the ready button and mode text
		$Ready.text = 'Ready'
		$Mode.text = timer_mode
		
		if timer_mode == c.BREAK:
			$BreakPopUp.popup()
			# Show other UI not relevant to the focus
			for element in ui_to_hide_on_focus:
				element.show()
		else:
			$FocusPopUp.popup()
		
	update_display_time()
