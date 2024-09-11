class_name PlayerCharacter

extends CharacterBody3D

@export var playerName: String
@export var playerLvl: int
@export var playerClass: int
@export var playerHP: int
@export var playerXP: int
@export var playerInv: Array

var texture = load("res://Other Resources/wizard-ani-frames.tres") # TEMPORARY, MOVE INTO "Class" AFTER CREATION!!!!!!!!!!


func _init():
	_create_model(texture)
	#creating


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _create_model(pm: SpriteFrames):
	var model = AnimatedSprite3D.new()
	model.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	model.scale = Vector3(5,5,5) #FIGURE OUT PROPER HANDLING OF SIZING HERE!!!!!
	model.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	model.set_sprite_frames(pm)
	add_child(model)
	
	var colShape = CollisionShape3D.new()
	var boxShape = BoxShape3D.new()
	boxShape.size(model.get_size)
	colShape.set_shape(boxShape)
	add_child(colShape)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
