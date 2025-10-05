extends CharacterBody2D

@export var SPEED = 5500

var facing = Vector2.ZERO
var direction = Vector2.ZERO

func halt_this_goober(yes): Global.haltPlayer = yes

func determine_direction():
	# clean, standard, movement one-liner
	direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	# fuck
	if !Global.shitPlayerMovement: return
	if Input.is_action_pressed("ui_up"): direction.y = -1
	elif Input.is_action_pressed("ui_down"): direction.y = 1
	if Input.is_action_pressed("ui_left"): direction.x = -1
	elif Input.is_action_pressed("ui_right"): direction.x = 1
	if is_on_ceiling() and Input.is_action_pressed("ui_down"): direction.y = 1

func _physics_process(delta):
	if Global.haltPlayer:
		$DirAnimationComponent.animate(direction)
		return
	determine_direction()
	if direction != Vector2.ZERO: facing = direction
	$MovementComponent.movement(delta, direction, SPEED)
	$DirAnimationComponent.animate(direction)
