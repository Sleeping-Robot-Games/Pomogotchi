extends Node2D

var timer_mode = c.FOCUS
var focus_theme_mode = ''
var timer_seconds =  c.STANDARD_FOCUS_SECONDS

export(ButtonGroup) var focus_theme_group

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
				# Disable the focus theme buttons while the timer runs
				for button in focus_theme_group.get_buttons():
						button.disabled = true
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
			# Enable the focus theme buttons 
			for button in focus_theme_group.get_buttons():
					button.disabled = false
			focus_theme_mode = ""
		
	update_display_time()
