extends Patch9Frame

onready var pointer = get_node("Arrow")

var down = false

func _ready():
	print("Inventory size: ", globals.inventory.size())
	set_fixed_process(true)
	
func _fixed_process(delta):
	if down:
		pointerUpdate()
	

func _unhandled_key_input(key_event):
	if key_event.is_action_pressed("ui_down"):
		down = true
	if key_event.is_action_released("ui_down"):
			down = false
	
func pointerUpdate():
	print("Update arrow position")
	
