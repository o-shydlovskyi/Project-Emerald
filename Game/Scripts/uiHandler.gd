extends Control


# Called when the node enters the scene tree for the first time.
	
func _ready() -> void:
	
	$InvButton.connect("toggled",_output)
	
	var player = $"../PlayableCharacter"
	
	if player == null:
		print("Player not found!")
		return
	
	if player.inventory == null:
		print("Inventory not initialized!")
		return
	

	

# INVENTORY CODE #
	for i in player.inventory.size:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.Weapon, Vector2(16,16))
		%InvGrid.add_child(slot)
		
	await player
	for i in range(player.inventory.items.size()):
		var item = player.inventory.items[i]
		print("Slotadded")
		if item != null:
			var item_node = InventoryItem.new()
			item_node.init(item)
			%InvGrid.get_child(i).add_child(item_node)
			
	



func _output(state: bool):
	if state:
		%InvGrid.show()
		print("show")
	else:
		%InvGrid.hide()
		print("show")

# Called every frame. 'delta' is the elapsed time since the previous frame.

	
