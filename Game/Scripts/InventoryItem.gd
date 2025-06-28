class_name InventoryItem
extends TextureRect

@export var data: ItemData
static var TooltipScene: PackedScene = preload("res://Resources/ItemTooltip.tscn")

func init(d: ItemData) -> void:
	data = d

func _ready():
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture = data.texture
	tooltip_text = "%s\n%s" % [data.name, data.description]
	if data.stackable == true:
		var label = Label.new()
		label.text = "1"
		label.set_theme_type_variation("HeaderSmall")
		add_child(label)


func _get_drag_data(at_position:Vector2):
	set_drag_preview(make_drag_preview(at_position))
	return self
	
func make_drag_preview(at_position: Vector2):
	var t := TextureRect.new()
	t.texture = texture
	t.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	t.custom_minimum_size = size
	t.modulate.a = 0.5
	t.position = Vector2(-at_position)
	
	var c: = Control.new()
	c.add_child(t)
	
	return c

# Godot calls this to get custom tooltip Control
func _make_custom_tooltip(for_text: String) -> Object:
	if TooltipScene:
		var tooltip = TooltipScene.instantiate()
		if tooltip.has_method("set_item_data"):
			tooltip.set_item_data(data)
		return tooltip
	return null
