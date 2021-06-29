extends KinematicBody2D

var input_direction = 0
var direction = 0
var jump_speed = -400 
var speed = 0
const MAX_SPEED = 9000
const ACCELERATION = 9000
const DECELERATION = 12000
# Velocity is the X component of our motion vector.
var velocity = 0
var vector = Vector2()
var gravity = 300
 
func _ready():
	pass
 
func _physics_process(delta):
	# INPUT
	# If the player pressed a key on the last tick,
	# We set the character's direction to the input
	if input_direction:
		direction = input_direction
	
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
		$AnimatedSprite.play("skate")
		$AnimatedSprite.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
		$AnimatedSprite.play("skate")
		$AnimatedSprite.set_flip_h(false)
	elif Input.is_action_just_pressed("ui_accept"):
		vector.y = jump_speed
	else:
		input_direction = 0
		vector.y -= DECELERATION * delta
	
	# MOVEMENT
	# If the player changed direction since last frame,
	# it means the character will turn around.
	# In that case, we lower the character's speed
	if input_direction == - direction:
		speed /= 3
 
	if input_direction:
		speed += ACCELERATION * delta
	else:
		speed -= DECELERATION * delta
		speed = clamp(speed, 0, MAX_SPEED)
	velocity = speed * delta * direction
	move_and_slide(Vector2(velocity, vector.y))
