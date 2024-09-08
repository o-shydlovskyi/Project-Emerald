extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var playableClassList = $"../PlayableCharacter".fantasy_classes
	for key in playableClassList:
		$ItemList.add_item(key)
	pass # Replace with function body.
	$ItemList.select($"../PlayableCharacter".currentClassID)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
