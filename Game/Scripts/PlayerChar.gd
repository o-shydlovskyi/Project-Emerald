class_name PlayableChar

extends CharacterBody3D

@onready var playableClasses = load("res://Other Resources/classes-lib.tres")
@onready var sprite = $AnimatedSprite3D
var playerClass: PlayerClassData 


func _class_selection():
	
	playerClass = preload("res://Other Resources/Wizard.tres")
	currentHealth = playerClass.strength*0.5
	maxHealth = playerClass.strength*0.5
	charSpeed = playerClass.agility*2
	
	print("Selected class max HP:", currentHealth)


# Attributes
var currentHealth: int
var maxHealth: int
var currentMana: int
var maxMana: int
var currentClassID
var charSpeed: int
var fall_acceleration = 25

@export var inventory: PlayerInventory

var is_moving
var target_velocity = Vector3.ZERO



func _ready():
	_class_selection()
	print("Output",charSpeed)
	sprite.connect("frame_changed",_on_animation_started)
	inventory = PlayerInventory.new()
	for i in playerClass.startItems:
		inventory.add_item(i)
	print(inventory.items)
	
	var tween = get_tree().create_tween()
	tween.tween_property($Camera3D, "size", 8, 1).set_trans(Tween.TRANS_SINE)

	

func _on_animation_started():
		if sprite.frame == 1:
			$AudioStreamPlayer3D.set_pitch_scale(randf_range(0.5,1.5))
			$AudioStreamPlayer3D.play()





func _physics_process(delta):
	var direction = Vector3.ZERO
	sprite.speed_scale = charSpeed
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		direction.z -= 1
		sprite.play("right-walking")
		is_moving = true
	elif Input.is_action_pressed("move_left"):
		direction.x -= 1
		direction.z += 1
		sprite.play("left-walking")
		is_moving = true
	elif  Input.is_action_pressed("move_down"):
		direction.x += 1
		direction.z += 1
		sprite.play("down-walking")
		is_moving = true
	elif Input.is_action_pressed("move_up"):
		direction.x -= 1
		direction.z -= 1
		sprite.play("up-walking")
		is_moving = true
	else:
		is_moving = false
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	# Ground Velocity
	target_velocity.x = direction.x * charSpeed
	target_velocity.z = direction.z * charSpeed


	
	if is_moving:
		$CPUParticles3D.set_emitting(true)
	
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	if !is_moving:
		sprite.stop()  # Stop the currently playing animation
		sprite.frame = 0
		$CPUParticles3D.set_emitting(false)
		
	# Moving the Character
	velocity = target_velocity
	move_and_slide()
