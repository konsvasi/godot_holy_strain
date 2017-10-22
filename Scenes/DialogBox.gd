extends Patch9Frame

var printing = false
var timer = 0
var textToPrint = ""
var currentChar = 0
var currentText = 0
var pressed = false
var donePrinting = false

onready var textLabel = get_node("RichTextLabel")

const SPEED = 0.1

func _ready():
	set_fixed_process(true)
	set_process_unhandled_key_input(true)
	
func _unhandled_key_input(event):
	if event.is_action_pressed("interact"):
		pressed = true
	if event.is_action_released("interact"):
		pressed = false
	
func _fixed_process(delta):
	if printing:
		if !donePrinting:
			timer += delta
			if timer > SPEED:
				timer = 0
				textLabel.set_bbcode(textLabel.get_bbcode() + textToPrint[currentText][currentChar])
				currentChar += 1
				
			if currentChar >= textToPrint[currentText].length():
				currentChar = 0
				timer = 0
				donePrinting = true
				currentText += 1
		elif pressed:
			donePrinting = false
			get_node("RichTextLabel").set_bbcode("")
			if currentText >= textToPrint.size():
				currentText = 0
				textToPrint = []
				printing = false
				set_hidden(true)
				get_node("/root/testWorld/Player").canMove = true
		
	pressed = false
	
func printDialog(text):
	printing = true
	textToPrint = text
	get_node("/root/testWorld/Player").canMove = false
