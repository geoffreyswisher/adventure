#warnings-disable

extends Control


var text = ['In the year 2076 the perfect cheeseburger was forged;' , 'with its toasted buns, delicious cheese, crunchy pickles, and medium well done juicy double patties...', 'it highlighted the progress of humankind.', 'The creator of such an extraordinary burger was Dr. W,...', 'an expert in the creation of burgers.', 'While in space, aliens stole the distinguished Cheeseburger, damaging his ship in the process.', 'Now, Dr. W must fix his ship and begin the quest for the lost cheeseburger.', '', 'Acting as Dr. W, you must acquire 2 parts from different planets...', 'and 3 containers of fuel.', 'Use WASD/arrow keys to move and jump and use Space to jump.', 'In order to enter a planet, press Enter when near it.', 'Press Enter to Continue']
var text2 = ['Congratulations! You have succesfully acquired...', 'all the necessary parts in order to fix your ship!', 'After rebuilding his ship,', 'Dr. W will continue his quest:', 'The QUEST FOR THE LOST CHEESEBURGER']

var counter = 0
var prev = -1
var nodes = 0
var delay = 300

var default_separation = 50
var paragraph_spacing = 100
var separation = default_separation
var sep_inc = .4

var container
var subcontainer
var top
var prev_child

# Called when the node enters the scene tree for the first time.
func _ready():
	container = get_node("VBoxContainer")
	subcontainer = get_node("VBoxContainer/VBoxContainer")
	subcontainer.add_constant_override("separation", paragraph_spacing)
	top = get_node("VBoxContainer/Text")
	
	if (get_tree().get_current_scene().name == "Final"):
		top.text = "Resolution"
		text = text2

func _process(_delta):
	check_input()
	
	counter += 1
	nodes = counter / delay
	_add_node()

func _add_node():
	
	if nodes != prev and nodes < len(text):
		container.add_constant_override("separation", default_separation)
		separation = default_separation
		
		var new = Label.new()
		new.add_font_override("font", load("res://assets/fonts/loaded-fonts/Ubuntu-16.tres"))
		new.align= Label.ALIGN_LEFT
		new.text = text[nodes]
		
		subcontainer.add_child(new)
		subcontainer.move_child(new, 0)

	else:
		separation += sep_inc
		container.add_constant_override("separation", separation)
		
	prev = nodes

func next_scene():
	get_tree().change_scene("res://scenes/open-space/Main.tscn")

func check_input():
	if Input.is_action_just_pressed("skip_dialogue"):
		if (get_tree().get_current_scene().name != "Final"):
			next_scene()
	if Input.is_action_just_pressed("ui_cancel"):
		if (get_tree().get_current_scene().name == "Final"):
			get_tree().quit()
