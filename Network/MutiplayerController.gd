extends  Control

@export var Address = "255.255.255.255"
@export var port = 8910
var peer


# Called when the node enters the scene tree for the first time.
func _ready():
	$ServerBrowser.hide()
	$LineEdit2.hide()
	$Join2.hide()
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	if "--server" in OS.get_cmdline_args():
		hostGame()
	#$StartGame.hide()
	$ServerBrowser.joinGame.connect(JoinByIP)
	pass # Replace with function body.


# this get called on the server and clients
func peer_connected(id):
	print("Player Connected " + str(id))
	
# this get called on the server and clients
func peer_disconnected(id):
	print("Player Disconnected " + str(id))
	GameManager.Players.erase(id)
	var players = get_tree().get_nodes_in_group("Player")
	for i in players:
		if i.name == str(id):
			i.queue_free()
# called only from clients
func connected_to_server():
	print("connected To Sever!")
	SendPlayerInformation.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())

# called only from clients
func connection_failed():
	print("Couldnt Connect")

@rpc("any_peer")
func SendPlayerInformation(name, id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] ={
			"name" : name,
			"id" : id,
			"score": 0,
			"health":0
		}
		#GameManager.Players.score

	
	if multiplayer.is_server():
		for i in GameManager.Players:
			SendPlayerInformation.rpc(GameManager.Players[i].name, i)



@rpc("any_peer","call_local")
func StartGame() -> void:
	$BG.stop()
	var scene = preload("res://Map/Classic/clasic.tscn").instantiate()
	self.hide()
	get_tree().root.add_child(scene)
	

func hostGame():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 10)
	if error != OK:
		print("cannot host: " + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting For Players!")
	
	
func _on_host_button_down():
	$Click.play()
	$ServerBrowser.show()
	$LineEdit4.hide()
	$StartGame.show()
	$Join2.hide()
	$LineEdit2.hide()
	hostGame()
	
	
	SendPlayerInformation($LineEdit.text, multiplayer.get_unique_id())
	$ServerBrowser.setUpBroadCast($LineEdit.text + "'s server")
	pass # Replace with function body.
	


func _on_join_button_down():
	$Click.play()
	$LineEdit4.hide()
	$LineEdit2.show()
	$Join2.show()
	$LineEdit4.hide()
	$ServerBrowser.show()
	JoinByIP(Address)
	pass # Replace with function body.

func JoinByIP(ip):
	peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	

func _on_start_game_button_down() -> void:
	$Click.play()
	$Start.play()
	
	$BG.stop()
	StartGame.rpc()
	pass # Replace with function body.


func _on_button_button_down():
	GameManager.Players[GameManager.Players.size() + 1] ={
			"name" : "test",
			"id" : 1,
			"score": 0
		}
	pass # Replace with function body.


func _on_join_2_pressed():
	$Click.play()
	$Join2.show()
	$LineEdit4.hide()

	$ServerBrowser.show()
	$LineEdit2.show()
	JoinByIP($LineEdit2.text)
	pass # Replace with function body.


func _on_join_3_pressed():
	$Click.play()
	var ip
	var all_ip = IP.get_local_addresses()
	for address in all_ip:
		if (address.split('.').size() == 4):
			ip = address
			$LineEdit4.text = "IP : " +ip 
	
		break  # Exit the loop after finding the first valid IPv4 address
		$LineEdit5.text = "All_IP : "+  str(IP.get_local_addresses())
		print("jnvjndfvsfnv  ",IP.get_local_addresses())





#
#func _on_start_game_pressed():
	#StartGame.rpc()
	##
	#pass # Replace with function body.


func _on_button_2_pressed() -> void:
	#StartGame.rpc()
	pass # Replace with function body.




func _on_bg_finished() -> void:
	
	$BG.play()
	pass # Replace with function body.
