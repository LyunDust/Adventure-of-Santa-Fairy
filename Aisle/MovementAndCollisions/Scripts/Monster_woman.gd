extends KinematicBody2D

class_name MonsterWoman

export (int) var monsterWomanSpeed = 300

var velocity = Vector2()

func _physics_process(delta):
	velocity.x += 1
	velocity = velocity.normalized() * monsterWomanSpeed
	
	var collision = move_and_collide(velocity*delta)
	
	if collision and collision.collider is Block:
		print("woman collided with an Block!")
		monsterWomanSpeed *= -1
