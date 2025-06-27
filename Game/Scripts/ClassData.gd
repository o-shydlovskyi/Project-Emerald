class_name PlayerClassData
extends Resource

enum mainAttribute {Strength,Intelligence,Agility}

@export var mmainAttribute: mainAttribute
@export var name: String
@export var texture: SpriteFrames
@export var strength: int
@export var intelligence : int
@export var agility: int
@export var startItems: Array[ItemData]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
