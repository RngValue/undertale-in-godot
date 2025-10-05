class_name NpcRotationComponent extends Node

@export var NpcSpriteNode: Sprite2D
@export var PlayerNode: CharacterBody2D
@export var NpcDown: Texture2D
@export var NpcUp: Texture2D
@export var NpcLeft: Texture2D
@export var NpcRight: Texture2D

func activate():
	if PlayerNode.facing.x < 0:
		NpcSpriteNode.texture = NpcRight
	elif PlayerNode.facing.x > 0:
		NpcSpriteNode.texture = NpcLeft
	if PlayerNode.facing.y < 0:
		NpcSpriteNode.texture = NpcDown
	elif PlayerNode.facing.y > 0:
		NpcSpriteNode.texture = NpcUp
