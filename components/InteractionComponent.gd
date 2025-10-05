class_name InteractionComponent extends Node

@export var AreaNode: Area2D
@export var ActionNodes: Array[Node]

var inBounds: bool = false

func _ready():
	AreaNode.body_entered.connect(func(body):
		if body.name == "Frisk": inBounds = true
	)
	AreaNode.body_exited.connect(func(body):
		if body.name == "Frisk": inBounds = false
	)

func _process(_delta):
	if inBounds and Input.is_action_just_pressed("ui_accept") and !Global.haltPlayer:
		for x in ActionNodes: x.activate()
