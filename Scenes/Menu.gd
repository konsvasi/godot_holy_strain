extends Patch9Frame

#menu, stands for menu button 
var menu = false
var open = false

var up = false
var down = false

var currentLabel = 0
var labels
var pointer

onready var player = get_node("/root/testWorld/Player")

func _ready():
	set_process_unhandled_key_input(true)
	set_fixed_process(true)
	labels =  get_node("Labels").get_children()
	pointer = get_node("Sprite")
	pointerUpdate()
	
func _fixed_process(delta):
	if open:
		#add code to move arrow
		print("Add code to move arrow")
		#if open and menu button pressed
		print("MENU:", menu)
		if menu:
			set_hidden(true)
			#let player move again
			player.canMove = true
			open = false
			
		if up:
			if currentLabel == 0:
				currentLabel = labels.size() - 1
			else:
				currentLabel -= 1
			pointerUpdate()
		
		if down:
			if currentLabel == labels.size() - 1:
				currentLabel = 0
			else:
				currentLabel += 1
			pointerUpdate()
		menu = false
		up = false
		down = false
		
func _unhandled_key_input(key_event):
	if open:
		if key_event.is_action_pressed("menu"):
			menu = true
		if key_event.is_action_released("menu"):
			menu = false
		if key_event.is_action_pressed("ui_down"):
			down = true
		if key_event.is_action_released("ui_down"):
			down = false
		if key_event.is_action_pressed("ui_up"):
			up = true
		if key_event.is_action_released("ui_up"):
			up = false
			
func openMenu():
	set_hidden(false)
	player.canMove = false
	menu = false
	open = true
	
func pointerUpdate():
	var offSet = 4
	var newPos = Vector2(pointer.get_global_pos().x, labels[currentLabel].get_global_pos().y + offSet)
	pointer.set_global_pos(newPos)
