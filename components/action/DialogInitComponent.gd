class_name DialogInitComponent extends Node

@export var Dialog: Resource
@export var AnimPlayer: AnimationPlayer
@export var Character: CharacterBody2D

@onready var dialogBox = preload("res://nodes/gui/dialog_box.tscn")

func activate():
	var dialInstance = dialogBox.instantiate()
	dialInstance.Dialog = Dialog
	if AnimPlayer != null: dialInstance.AnimPlayer = AnimPlayer
	if Character != null: dialInstance.Orientation = Character.facing.y
	get_tree().root.add_child(dialInstance)
