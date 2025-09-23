class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(take_damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func take_damage(_hurt_box: HurtBox) -> void:
	queue_free()
