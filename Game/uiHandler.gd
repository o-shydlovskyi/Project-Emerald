extends Control



@export var InvSize = 15
var itemsLoad = [
	"res://Other Resources/Items/Wand.tres",
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Button.connect("toggled",_output)
	var playableClassList = $"../PlayableCharacter".fantasy_classes
	for key in playableClassList:
		$ItemList.add_item(key)
	pass # Replace with function body.
	$ItemList.select($"../PlayableCharacter".currentClassID)
	
	for i in InvSize:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.Weapon, Vector2(64,64))
		%InvGrid.add_child(slot)
		
	for i in itemsLoad.size():
		var item := InventoryItem.new()
		item.init(load(itemsLoad[i]))
		%InvGrid.get_child(i).add_child(item)
	

func _output(state: bool):
	if state:
		print("Open")
		%InvGrid.show()
	else:
		%InvGrid.hide()
		print("Hide")
	
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
