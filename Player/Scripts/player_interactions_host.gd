class_name PlayerInteractionsHost extends Node2D

@onready var player: Player = $".."

var hurtbox_position_dn: Vector2 = Vector2(0, 10)
var hurtbox_position_up: Vector2 = Vector2(0, -40)
var hurtbox_position_lt: Vector2 = Vector2(-18, -20)
var hurtbox_position_rt: Vector2 = Vector2(18, -20)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.DirectionChanged.connect(UpdatePosition)


func UpdateDirection(new_direction: Vector2) -> void:
	match new_direction:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = 270
		_:
			rotation_degrees = 0

func UpdatePosition(new_direction: Vector2) -> void:
	match new_direction:
		Vector2.DOWN:
			position = hurtbox_position_dn
		Vector2.UP:
			position = hurtbox_position_up
		Vector2.LEFT:
			position = hurtbox_position_lt
		Vector2.RIGHT:
			position = hurtbox_position_rt
		_:
			rotation_degrees = 0
