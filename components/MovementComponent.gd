class_name MovementComponent extends Node

@export var Character: CharacterBody2D

func movement(delta, direction, SPEED):
	Character.velocity.x = direction.x * SPEED * delta
	Character.velocity.y = direction.y * SPEED * delta
	Character.move_and_slide()
