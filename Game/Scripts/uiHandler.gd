extends Control


# Called when the node enters the scene tree for the first time.
	
func _ready() -> void:
	
	$Button.connect("toggled",_output)
	
	var player = $"../PlayableCharacter"
	if player == null:
		print("Player not found!")
		return
	
	var playerInv = player.inventory
	if playerInv == null:
		print("Inventory not initialized!")
		return
	
	for i in playerInv.inventory.size:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.Weapon, Vector2(16,16))
		%InvGrid.add_child(slot)

	for i in range(playerInv.inventory.size):
		var item = playerInv.inventory.items[i]
		if item != null:
			var item_node = InventoryItem.new()
			item_node.init(item)
			%InvGrid.get_child(i).add_child(item_node)
	

# INVENTORY CODE #
	


func _output(state: bool):
	if state:
		%InvGrid.show()
		print("show")
	else:
		%InvGrid.hide()
		print("show")

# Called every frame. 'delta' is the elapsed time since the previous frame.

	
