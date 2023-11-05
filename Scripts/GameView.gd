extends Node

class_name GameView 

@onready var players := {
	"1": {
		viewport = $HBoxContainer/SubViewportContainer/SubViewport,
		camera = $HBoxContainer/SubViewportContainer/SubViewport/Camera2D2,
		player = $HBoxContainer/SubViewportContainer/SubViewport/Node2D/Human
	},
	"2": {
		viewport = $HBoxContainer/SubViewportContainer2/SubViewport,
		camera = $HBoxContainer/SubViewportContainer2/SubViewport/Camera2D2,
		player = $HBoxContainer/SubViewportContainer/SubViewport/Node2D/Alien
	}
}


func _ready() -> void:
	players["2"].viewport.world_2d = players["1"].viewport.world_2d
	
	for node in players.values():
		var remote_transform := RemoteTransform2D.new()
		remote_transform.remote_path = node.camera.get_path()
		print(remote_transform, "test2")
		node.player.add_child(remote_transform)
