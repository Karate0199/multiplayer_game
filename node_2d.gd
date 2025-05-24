extends Node2D

var Port = 23456
var Ip_address = '127.0.0.1'
var send_scene

func _ready() -> void:
	multiplayer.allow_object_decoding = true



func _on_createhost_btn_pressed() -> void:
	if $Control/LineEdit.text == "" :
		$Game_ui/eror_username.show()
	elif $Control/LineEdit.text.length() < 5:
		$Game_ui/eror_username.show()
	else:
		var peer = ENetMultiplayerPeer.new()
		peer.create_server(Port, 5)
		multiplayer.multiplayer_peer = peer
		$Control.hide()
		$Game_ui/ChatBtn.show()
		multiplayer.peer_connected.connect(connect_player)
		multiplayer.peer_disconnected.connect(disconnect_player)
		add_player(1)
		var scene
		if FileAccess.file_exists("user://world.tscn"):
			scene = ResourceLoader.load("user://world.tscn").instantitate()
		else:
			scene = preload("res://world.tscn").instantiate()
		$World.add_child(scene)
		
		
@rpc("any_peer", "call_remote")
func send_world(scene):
	$World.add_child(scene.instantiate())
	
func connect_player(id):
	if multiplayer.is_server():
		var node_send = PackedScene.new()
		send_scene = $World.get_node("World")
		node_send.pack(send_scene)
		rpc("send_world", node_send)
	add_player(id)
	$Game_ui.show()

func disconnect_player(id):
	if not $Players.has_node(str(id)): return
	$Players.get_node(str(id)).queue_free()

func add_player(id):
	var player = preload("res://character_body_2d.tscn").instantiate()
	player.name = str(id)
	$Players.add_child(player)

func _on_join_host_btn_pressed() -> void:
	if $Control/LineEdit.text == "" :
		$Game_ui/eror_empty_username.show()
	elif $Control/LineEdit.text.length() < 5:
		$Game_ui/eror_username.show()
	else:
		var peer = ENetMultiplayerPeer.new()
		peer.create_client(Ip_address, Port)
		multiplayer.multiplayer_peer = peer
		$Control.hide()
		$Game_ui.show()
		$Game_ui/ChatBtn.show()




func _on_chat_btn_pressed() -> void:
	$Game_ui/Panel.show()


func _on_back_btn_pressed() -> void:
	$Game_ui/Panel.hide()
@rpc("any_peer", "call_local")
func msg_rpc(usrnm, msg):
	$Game_ui/Panel/TextEdit.text += str(usrnm, ": ", msg, "\n")
	$Game_ui/Panel/TextEdit.scroll_vertical = INF
	


func _on_send_btn_pressed() -> void:
	if not $Game_ui/Panel/LineEdit.text == "":
		rpc("msg_rpc", $Control/LineEdit.text, $Game_ui/Panel/LineEdit.text)
		$Game_ui/Panel/LineEdit.text = ""

func _on_backpanel_btn_pressed() -> void:
	$Game_ui/Panel2.hide()

func _on_backpanel_3_btn_pressed() -> void:
	$Game_ui/eror_username.hide()
