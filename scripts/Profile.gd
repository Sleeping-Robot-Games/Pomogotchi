extends Node2D


func _ready():
	pass # Replace with function body.


func _on_Back_button_up():
	hide()
	get_node('../Main').show()
