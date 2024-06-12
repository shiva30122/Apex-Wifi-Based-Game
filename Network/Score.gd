#extends Node2D
#
#func _ready():
	## Initialize UI elements
	#update_scores()
#
#func _process(delta):
	#
	#update_scores()
	##print(update_scores())
#
#func update_scores():
	## Clear previous scores
	##clear_scores()
#
	## Get all players
	#var players = get_tree().get_nodes_in_group("Player")
##		var id = players.multiplayer.get_unique_id()
##	 Iterate through players and display scores
	#for i in GameManager.Players:
		#var score_label = Label.new()
		#var id = multiplayer.get_unique_id()
		#score_label.text = str("Player " , GameManager.Players[id]["score"])
		#print("                                Scoreeeeeeeeeeeeeeeeeeeee  :",GameManager.Players[id]["score"])
		#
##	for i in range(players.size()):, str(i + 1) + ": ", str(
		##var player = players[i]
		##var score_label = Label.new()
		##var id = multiplayer.get_unique_id()
		##score_label.text = "Player " + str(i + 1) + ": " + str(multiplayer.get_player_score(id))
#
		#
		## Customize label properties if needed
		#$VBoxContainer.add_child(score_label)
		#if $VBoxContainer.get_child_count() >= 2 :
			#$VBoxContainer.remove_child(score_label)
			##clear_scores()
#
		##
		##for ii in range($VBoxContainer.get_child_count()):
				###var multiplayer_id = i.multiplayer.get_unique_id()
				##var child_node = $VBoxContainer.get_child(ii)
				##
				### Check if child node's multiplayer_id matches
				##if child_node.multiplayer.get_unique_id() == multiplayer.get_unique_id():
					### Remove child node from VBoxContainer
					##$VBoxContainer.remove_child(child_node)
					##
					### Free the removed child node
					##child_node.queue_free()
#
#
#func clear_scores():
	## Remove previous score labels
	#for child in get_children():
		#remove_child(child)
