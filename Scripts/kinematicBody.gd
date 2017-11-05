extends KinematicBody2D

onready var world = get_world_2d().get_direct_space_state()
var direction = Vector2()
var previousDirection = Vector2()
onready var sprite = get_node("Sprite")
#onready var animationPlayer = get_node("AnimationPlayer")
const SPEED = 1
var moving = false
var startPos = Vector2(0,0)
var canMove = true
var interact = false
var menu = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("interact"):
		interact = true
	if event.is_action_released("interact"):
		interact = false
		
	if event.is_action_pressed("menu"):
		menu = true
	if event.is_action_released("menu"):
		menu = false
		
func _fixed_process(delta):
	var left = Input.is_action_pressed("LEFT")
	var right = Input.is_action_pressed("RIGHT")
	var up = Input.is_action_pressed("UP")
	var down = Input.is_action_pressed("DOWN")
	
	var result = world.intersect_point(get_pos())
	if canMove:
		if down:
			moving = true
			direction.y = 1
			sprite.set_frame(0)
			if (direction != previousDirection):
				print("walk_down_animation");
				#animationPlayer.play("walk_down")
		elif right:
			moving = true
			direction.x = 1
			sprite.set_frame(1)
			if (direction != previousDirection):
				print("walk_right_animation");
				#animationPlayer.play("walk_right")
		elif left:
			moving = true
			direction.x = -1
			sprite.set_frame(2)
			if (direction != previousDirection):
				print("walk_left_animation");
				#animationPlayer.play("walk_left")
		elif up:
			moving = true
			direction.y = -1
			sprite.set_frame(3)
			if (direction != previousDirection):
				print("walk_up_animation");
				#animationPlayer.play("walk_up")
				
		else:
			direction = Vector2(0,0)
			#animationPlayer.stop(true)
			moving = false
			
			if menu and !interact:
				get_node("Camera2D/Menu").openMenu()
	

	if interact:
		var frame = sprite.get_frame()
		#down
		if frame == 0:
			result = world.intersect_point(get_pos() + Vector2(0, 16))
		#right
		elif frame == 1:
			result = world.intersect_point(get_pos() + Vector2(16, 0))
		#left
		elif frame == 2:
			result = world.intersect_point(get_pos() + Vector2(-16, 0))
		#up
		elif frame == 3:
			result = world.intersect_point(get_pos() + Vector2(0, -16))
		
		interact(result)
	
	
	var motion = direction.normalized() * delta * 40
	previousDirection = direction
	move(motion)
	
	interact = false
	menu = false

func interact(result):
	print(sprite.get_frame())
	
	for dict in result:
		if typeof(dict.collider) == TYPE_OBJECT && dict.collider.has_node("Interact"):
			get_node("Camera2D/DialogBox").set_hidden(false)
			
			#get interact node from other body and pass it's text to the function
			get_node("Camera2D/DialogBox").printDialog(dict.collider.get_node("Interact").text)
