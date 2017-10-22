extends Patch9Frame

#menu, stands for menu button 
var menu = false
var open = false
onready var player = get_node("/root/testWorld/Player")

func _ready():
	set_process_unhandled_key_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	if open:
		#add code to move arrow
		
		#if open and menu button pressed
		print("MENU:", menu)
		if menu:
			set_hidden(true)
			#let player move again
			player.canMove = true
			open = false
		menu = false
		
func _unhandled_key_input(key_event):
	if open:
		if key_event.is_action_pressed("menu"):
			menu = true
		if key_event.is_action_released("menu"):
			menu = false
		print("handlemenu: ", menu)
		
func openMenu():
	set_hidden(false)
	player.canMove = false
	menu = false
	open = true
	
