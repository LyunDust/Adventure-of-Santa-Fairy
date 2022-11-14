

extends KinematicBody2D

# (editable) variables for movement/physics
export (int) var run_speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()
var jumping = false

func get_input():
	
	# left/right for movement, mouse click for jumping
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('click')

	# only jump if we are on the floor (i.e. no mid-air jumps)
	if jump and is_on_floor():
		jumping = true
		velocity.y = -jump_speed
		
	# left/right change the running speed 
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func _physics_process(delta):
	get_input()
	
	# Apply gravity. We need to do this because
	# player is a KinematicBody2D that doesn't have built-in physics.
	velocity.y += gravity * delta
	
	# landed?
	if jumping and is_on_floor():
		jumping = false
	
	# Move and slide works well for platformers.
	# The second parameter tells which direction is "up".
	# This is needed for is_on_floor() to work properly.
	velocity = move_and_slide(velocity, Vector2(0, -1))
