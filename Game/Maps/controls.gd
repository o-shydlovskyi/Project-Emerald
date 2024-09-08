extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 0.7
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

@onready var sprite = $AnimatedSprite3D;

var is_moving
var target_velocity = Vector3.ZERO

func _ready():
	sprite.connect("frame_changed",_on_animation_started)

func _on_animation_started():
		if sprite.frame == 1:
			$AudioStreamPlayer3D.set_pitch_scale(randf_range(0.5,1.5))
			$AudioStreamPlayer3D.play()
			print($AudioStreamPlayer3D.pitch_scale)





func _physics_process(delta):
	var direction = Vector3.ZERO
	sprite.speed_scale = speed
	
	if Input.is_action_pressed("ui_accept"):
		speed = 1.7
	else:
		speed = 0.7
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		direction.z -= 1
		sprite.play("right-walking")
		is_moving = true
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		direction.z += 1
		sprite.play("left-walking")
		is_moving = true
	elif  Input.is_action_pressed("ui_down"):
		direction.x += 1
		direction.z += 1
		sprite.play("down-walking")
		is_moving = true
	elif Input.is_action_pressed("ui_up"):
		direction.x -= 1
		direction.z -= 1
		sprite.play("up-walking")
		is_moving = true
	else:
		is_moving = false
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed



	
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	if !is_moving:
		sprite.stop()  # Stop the currently playing animation
		sprite.frame = 0
		
	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	
					
