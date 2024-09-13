extends Control



var player

#var itemsLoad = %Player.playerInv
var invSize = 12

# Called when the node enters the scene tree for the first time.


func _new_item(p:PlayerCharacter,r:String):
	p.playerInv.append(load(r))
	
func _ready() -> void:
	player = PlayerCharacter.new()
	player.position = Vector3(1,1,1)
	add_child(player)
	var itemsLoad = player.playerInv
	print(itemsLoad.size())
	_new_item(player,"res://Other Resources/Items/Poisoned-Sword.tres")
	
	$Button.connect("toggled",_output)
	#var playableClassList = $"../PlayableCharacter".fantasy_classes
	#for key in playableClassList:
		#$ItemList.add_item(key)
	#pass # Replace with function body.
	#$ItemList.select($"../PlayableCharacter".currentClassID)
	

	
	for i in invSize:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.Weapon, Vector2(16,16))
		%InvGrid.add_child(slot)
		
	for i in itemsLoad.size():
		var item := InventoryItem.new()
		item.init(itemsLoad[i])
		%InvGrid.get_child(i).add_child(item)

func _output(state: bool):
	if state:
		print("Open")
		%InvGrid.show()
		_new_item(player,"res://Other Resources/Items/Poisoned-Sword.tres")
	else:
		%InvGrid.hide()
		print("Hide")

# Called every frame. 'delta' is the elapsed time since the previous frame.

	
