class_name PlayerStateMachine extends Node

var states: Array[State]
var prev_state: State
var curr_state: State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(curr_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state(curr_state.physics(delta))

func __unhandled_input(event: InputEvent):
	change_state(curr_state.handle_input(event))

func initialize(_player: Player) -> void:
	states = []
	for c in get_children():
		if c is State:
			states.append(c)
	if states.size() > 0:
		states[0].player = _player
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state: State) -> void:
	if new_state == null || new_state == curr_state:
		return
	if curr_state:
		curr_state.exit()
		
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()
