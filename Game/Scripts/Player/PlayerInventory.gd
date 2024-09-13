class_name PlayerInventory

extends Node

var items : Array[ItemData]
var size = 8


func add_item(itm:ItemData):
	items.append(itm)

func remove_item(itm):
	items.erase(itm)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
