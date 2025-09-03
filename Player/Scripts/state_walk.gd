class_name State_Walk extends State

@export var move_speed: float = 100.0
@onready var idle: State_Idle = $"../Idle"


func enter() -> void:
	player.update_animation("walk")
	

func process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	player.velocity = player.direction * move_speed
	if player.set_direction():
		player.update_animation("walk")
	return null
