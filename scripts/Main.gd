extends Node2D

var timer_mode = c.FOCUS
var focus_theme_mode = ''
var timer_seconds =  c.STANDARD_FOCUS_SECONDS

export(ButtonGroup) var focus_theme_group

onready var ui_to_hide_on_focus = [
	$FocusThemeContainer,
	$TaskContainer,
	$Hunger,
	$Happiness,
	$Intelligence,
	$Strength,
	$FPLabel,
	$GoldLabel
]

func _ready():
	$Mode.text = timer_mode
	update_display_time()
	for button in focus_theme_group.get_buttons():
		button.connect("pressed", self, "_on_FocusTheme_pressed")


func update_display_time():
	var minutes = (int(timer_seconds) / 60) % 60
	var seconds = (int(timer_seconds)) % 60
	$Time.text = "%02d:%02d" % [minutes, seconds]

func _on_FocusTheme_pressed():
	if timer_mode == c.BREAK or $Timer.is_stopped():
		focus_theme_mode = focus_theme_group.get_pressed_button().name


func _on_Start_button_up():
		if $Timer.is_stopped():
			if focus_theme_mode:
				# Start the timer if a focus theme is selected and update start button text
				$Timer.start()
				$Start.text = 'Pause'
				# Hide all the UI elements during FOCUS
				if timer_mode == c.FOCUS:
					for element in ui_to_hide_on_focus:
						element.hide()
		else:
			$Timer.paused = !$Timer.paused
			if $Timer.paused:
				$Start.text = 'Resume'
			else: 
				$Start.text = 'Pause'


func _on_Timer_timeout():
	timer_seconds -= 1
	if timer_seconds == 0:
		# Stop the timer when it gets to zero
		$Timer.stop()
		# Flip from Focus to Break or Vis Versa
		timer_seconds = c.STANDARD_BREAK_SECONDS if timer_mode == c.FOCUS else c.STANDARD_FOCUS_SECONDS
		timer_mode = c.BREAK if timer_mode == c.FOCUS else c.FOCUS
		# Update the start button and mode text
		$Start.text = 'Start'
		$Mode.text = timer_mode
		# Start the timer again automatically if just turned to break
		if timer_mode == c.BREAK:
			$Timer.start()
			$Start.text = "Pause"
			# Untoggle the focus theme button so a new one can be chosen
			if focus_theme_group.get_pressed_button():
				focus_theme_group.get_pressed_button().pressed = false
			focus_theme_mode = ""
			# Show all the UI elements during BREAK
			for element in ui_to_hide_on_focus:
				element.show()
		
	update_display_time()
