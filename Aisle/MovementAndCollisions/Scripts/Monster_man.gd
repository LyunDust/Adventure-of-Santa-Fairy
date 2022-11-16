extends KinematicBody2D

class_name MonsterMan

export (int) var monsterManSpeed = 500

var leftbloking = false;
var velocity = Vector2()

func _physics_process(delta):	
#	var mPos = get_position().x
#	print("mPos:", mPos)
	
	if !leftbloking:
		print("no")
		velocity.x -= 1
	if leftbloking:
		print("yes")
		velocity.x += 1
	
	velocity = velocity.normalized() * monsterManSpeed
	
#	var collision = move_and_collide(velocity*delta)
	
#	if collision and collision.collider is Block:
#		print("Collided with an Block!")
#		leftbloking = !leftbloking
		
		
	

