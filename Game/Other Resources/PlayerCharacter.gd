class_name PlayerCharacter

extends CharacterBody3D

var playerClass: ClassData
@export var playerName: String
var playerLvl: int
var playerHP: int
var playerMaxHP: int
var playerXP: int
var playerInv: Array
var playerSpeed: int = 2

var playerModel: AnimatedSprite3D




func _init():
	playerClass = preload("res://Other Resources/Wizard.tres") # TEMPORARY, MOVE INTO "Class" AFTER CREATION!!!!!!!!!!
	playerHP = playerClass.strength * 10
	playerMaxHP = playerHP
	playerInv = playerClass.startItems
	_create_model(playerClass.texture)
	#creating


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _create_model(pm: SpriteFrames):
	playerModel = AnimatedSprite3D.new()
	playerModel.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	playerModel.scale = Vector3(5,5,5) #FIGURE OUT PROPER HANDLING OF SIZING HERE!!!!!
	playerModel.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	playerModel.set_sprite_frames(pm)
	playerModel.alpha_cut = SpriteBase3D.ALPHA_CUT_OPAQUE_PREPASS
	playerModel.shaded = true
	add_child(playerModel)
	
	var colShape = CollisionShape3D.new()
	var boxShape = BoxShape3D.new()
	#boxShape.size(model.get_size)
	colShape.set_shape(boxShape)
	add_child(colShape)
	
	
func _player_controls(delta):
	var target_velocity = Vector3.ZERO
	var is_moving: bool
	var direction = Vector3.ZERO
	var fall_acceleration = 100
	
	if velocity != Vector3.ZERO:
		is_moving = true
	else:
		is_moving = false
		pass
	
	
	playerModel.speed_scale = playerSpeed
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		direction.z -= 1
		playerModel.play("right-walking")
	elif Input.is_action_pressed("move_left"):
		direction.x -= 1
		direction.z += 1
		playerModel.play("left-walking")
	elif  Input.is_action_pressed("move_down"):
		direction.x += 1
		direction.z += 1
		playerModel.play("down-walking")
	elif Input.is_action_pressed("move_up"):
		direction.x -= 1
		direction.z -= 1
		playerModel.play("up-walking")
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	# Ground Velocity
	target_velocity.x = direction.x * playerSpeed
	target_velocity.z = direction.z * playerSpeed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	# Moving the Character
	velocity = target_velocity
	move_and_slide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_player_controls(delta)
	pass
