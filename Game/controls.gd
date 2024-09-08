class_name PlayableChar
extends CharacterBody3D

@onready var playableClasses = load("res://Other Resources/classes.tres")

@onready var sprite = $AnimatedSprite3D

# Declaring possible Classes
@onready var fantasy_classes = {
	"Warrior": {
		"max_health": 150,
		"max_mana": 50,
		"speed": 3
	},
	"Mage": {
		"max_health": 80,
		"max_mana": 150,
		"speed": 2
	},
	"Rogue": {
		"max_health": 100,
		"max_mana": 80,
		"speed": 3
	},
	"Paladin": {
		"max_health": 120,
		"max_mana": 100,
		"speed": 2
	},
	"Druid": {
		"max_health": 110,
		"max_mana": 120,
		"speed": 3
	}
}


func _class_selection(playableClassIndex:int):
	var keys = fantasy_classes.keys()
	currentClassID = playableClassIndex
	var playableClassName = keys[playableClassIndex]
	
	#Assigning attributes
	currentHealth = fantasy_classes[playableClassName].max_health
	maxHealth = fantasy_classes[playableClassName].max_health
	charSpeed = fantasy_classes[playableClassName].speed
	
	print("Selected class max HP:", currentHealth, currentClassID)


# Attributes
var currentHealth: int
var maxHealth: int
var currentMana: int
var maxMana: int
var currentClassID
var charSpeed = 2
var fall_acceleration = 25

var is_moving
var target_velocity = Vector3.ZERO

func _ready():
	_class_selection(2)
	print()
	sprite.connect("frame_changed",_on_animation_started)
	$"../UI/ItemList".connect("item_selected",_class_selection) #Signal from selector

	

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
