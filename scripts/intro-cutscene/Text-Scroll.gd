extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text = ['Today I went to the store.' , 'I got green beans, salsa, and tomatoes.', 'My name? Joseph Madre.']

var counter = 0
var prev = -1
var nodes = 0
var delay = 200

var default_separation = 1
var separation = default_separation
var sep_inc = .07

var container
var subcontainer
var top
var prev_child

# Called when the node enters the scene tree for the first time.
func _ready():
	container = get_node("VBoxContainer")
	subcontainer = get_node("VBoxContainer/VBoxContainer")
	top = get_node("VBoxContainer/Text")

func _process(_delta):
	counter += 1
	nodes = counter / delay
	_add_node()

func _add_node():
	
	if nodes != prev and nodes < len(text):
		container.add_constant_override("separation", default_separation)
		separation = default_separation
		
		var new = Label.new()
		new.text = text[nodes]
		
		subcontainer.add_child(new)
		subcontainer.move_child(new, 0)

	else:
		separation += sep_inc
		container.add_constant_override("separation", separation)
		
	prev = nodes
