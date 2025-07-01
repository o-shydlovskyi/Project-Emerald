# TooltipUI.gd
extends Control

#@onready var name_label = %NameLabel
#
#func _ready() -> void:


func set_item_data(data) -> void:
	var label = %NameLabel
	var desc_label = %DescLabel
	if label:
		label.text = data.name
	desc_label.text = data.description
	#icon.texture = data.texture
