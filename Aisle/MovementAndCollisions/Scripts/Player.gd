extends KinematicBody2D

class_name Player

export (int) var playerSpeed = 200

var velocity = Vector2()

const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var direction = Vector2(DIRECTION_RIGHT, 1)

var sitdown = false

func get_input():
	velocity = Vector2()
	sitdown = false
	if Input.is_action_pressed("right"):
		set_direction(DIRECTION_RIGHT)
		velocity.x += 1
	if Input.is_action_pressed("left"):
		set_direction(DIRECTION_LEFT)
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		sitdown = true
#	if Input.is_action_pressed("up"):
#		velocity.y -= 1

	velocity = velocity.normalized() * playerSpeed


func _physics_process(delta):
	get_input()
	
	var collision = move_and_collide(velocity*delta)
	
	if !sitdown and collision:
		if collision.collider is MonsterMan:
			print("Collided with an MonsterMan!")
		if collision.collider is MonsterWoman:
			print("Collided with an MonsterWoman!")
		if collision.collider is Evil:
			print("Collided with an Evil!")
	if sitdown and collision:
		if collision.collider is MonsterMan:
			print("Escape from an MonsterMan!")
		if collision.collider is MonsterWoman:
			print("Escape from an MonsterWoman!")
		if collision.collider is Evil:
			print("Escape from an Evil!")


func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT
	var hor_dir_mod = hor_direction / abs(hor_direction)
	apply_scale(Vector2(hor_dir_mod * direction.x, 1))
	direction = Vector2(hor_dir_mod, direction.y)
