class_name Plant extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(TakeDamage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func TakeDamage(_damage: int) -> void:
	queue_free()
