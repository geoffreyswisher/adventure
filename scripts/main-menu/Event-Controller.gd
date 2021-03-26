extends MarginContainer

func _ready():
	save_data(0,0)
	# connecting button presses to corresponding functions
	get_node("HBoxContainer/VBoxContainer/Play-Button").connect("pressed", self, "_play_button_pressed")


func _play_button_pressed():
	get_tree().change_scene("res://scenes/intro-cutscene/Main.tscn")


func save_data(fuel, parts):
	var f = File.new()
	f.open('user://data.save', File.WRITE)
	f.store_string('%02d\n%02d' % [fuel, parts])
