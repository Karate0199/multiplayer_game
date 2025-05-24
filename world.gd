extends Node2D

var thread :Thread

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	thread = Thread.new()
	thread.start(_on_save_world)

func _on_save_world():
	while true:
		await get_tree().create_timer(5).timeout
		var node_to_save = self
		var scene = PackedScene.new()
		scene.pack(node_to_save)
		ResourceSaver.save(scene, "user://world.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
