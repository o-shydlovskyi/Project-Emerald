extends Control
var player

# Called when the node enters the scene tree for the first time.
	
func _ready() -> void:
	player = PlayerCharacter.new()
	player.position = Vector3(1,1,1)
	add_child(player)
	var itemsLoad = player.inventory
	print(itemsLoad.items.size())
	#_new_item(player,"res://Other Resources/Items/Poisoned-Sword.tres")
	
	$Button.connect("toggled",_output)
	#var playableClassList = $"../PlayableCharacter".fantasy_classes
	#for key in playableClassList:
		#$ItemList.add_item(key)
	#pass # Replace with function body.
	#$ItemList.select($"../PlayableCharacter".currentClassID)
	

# INVENTORY CODE #
	
	for i in player.inventory.size:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.Weapon, Vector2(16,16))
		%InvGrid.add_child(slot)

	for i in range(player.inventory.items.size()):
		var item = player.inventory.items[i]
		if item != null:
			var item_node = InventoryItem.new()
			item_node.init(item)
			%InvGrid.get_child(i).add_child(item_node)

func _output(state: bool):
	if state:
		print("Open")
		%InvGrid.show()
	else:
		%InvGrid.hide()
		print("Hide")

# Called every frame. 'delta' is the elapsed time since the previous frame.

	
