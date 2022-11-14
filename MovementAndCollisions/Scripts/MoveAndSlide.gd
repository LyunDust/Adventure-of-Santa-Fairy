extends KinematicBody2D

# exporting makes the variable editable in the editor
export (int) var speed = 200

var velocity = Vector2()

const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var direction = Vector2(DIRECTION_RIGHT, 1)

func get_input():
	# set velocity based on the keys pressed
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		set_direction(DIRECTION_RIGHT)
		velocity.x += 1
	if Input.is_action_pressed("left"):
		set_direction(DIRECTION_LEFT)
		velocity.x -= 1
#	if Input.is_action_pressed("down"):
#		velocity.y += 1
#	if Input.is_action_pressed("up"):
#		velocity.y -= 1

	# use normalized vector (length = 1) so that the velocity 
	# is calculated correctly based on the speed.
	velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_input()
	
	# call move_and_slide and save the resulting velocity vector
	velocity = move_and_slide(velocity)

	# loop through all slides that happened.
	# collision object gives more information about the collision.
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.collider.name, " at ", collision.position)


func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT
	var hor_dir_mod = hor_direction / abs(hor_direction)
	apply_scale(Vector2(hor_dir_mod * direction.x, 1))
	direction = Vector2(hor_dir_mod, direction.y)
