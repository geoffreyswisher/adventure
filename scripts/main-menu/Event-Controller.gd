extends MarginContainer

func _ready():
	
	# connecting button presses to corresponding functions
	get_node("HBoxContainer/VBoxContainer/Play-Button").connect("pressed", self, "_play_button_pressed")


func _play_button_pressed():
	print('Play Pressed')
