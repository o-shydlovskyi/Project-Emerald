class_name ItemData
extends Resource

enum Type {Weapon, Furniture, Consumable, Cloth}


@export var type: Type
@export var name: String
@export var texture: Texture2D
@export_multiline var description: String
@export var is_stackable: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
