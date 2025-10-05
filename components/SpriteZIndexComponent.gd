class_name SpriteZIndexComponent extends Sprite2D

@export var OriginPoint: NodePath
@export var Character: CharacterBody2D

func _process(_delta):
	z_index = 2 if Character.position.y < get_node(OriginPoint).position.y else 0
