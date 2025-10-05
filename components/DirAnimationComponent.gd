class_name DirAnimationComponent extends Node

@export var AnimTree: AnimationTree

func animate(direction):
	if direction == Vector2.ZERO or Global.haltPlayer:
		AnimTree.get("parameters/playback").travel("idle")
	else:
		AnimTree.get("parameters/playback").travel("move")
		AnimTree.set("parameters/idle/blend_position", direction)
		AnimTree.set("parameters/move/blend_position", direction)
