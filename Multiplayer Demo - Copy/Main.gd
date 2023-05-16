extends Node

var multiplayer_peer = ENetMultiplayerPeer.new() #multiplayer_peer manages server creation and client connection\

@onready var id = get_node("/root/Singleton")
@onready var menu = $Menu


func _on_join_pressed():
	var port = str($Menu/Port.text).to_int() #converts the port to string
	multiplayer_peer.create_client("localhost", port) #connects to the address "localhost" using the port
	multiplayer.multiplayer_peer = multiplayer_peer #enables RPC system
	menu.visible = false #hides the menu


func _on_host_pressed():
	var port = str($Menu/Port.text).to_int()
	multiplayer_peer.create_server(port) #creates a server based on the port
	multiplayer.multiplayer_peer = multiplayer_peer 
	multiplayer_peer.peer_connected.connect(func(id): add_player_character(id)) #adds a player character once a client has connected
	menu.visible = false
	add_player_character()


func add_player_character(id=1):
	var character = preload("res://Player.tscn").instantiate() #preloads the player scene
	character.name = str(id) #sets the unique id for the player node
	add_child(character) #adds the player as a child
