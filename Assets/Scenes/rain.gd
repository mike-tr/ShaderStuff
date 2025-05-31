extends MeshInstance3D

@export var player:Node3D;
@export var follow = true;

func _process(delta: float) -> void:
	if follow:
		position = player.position;
