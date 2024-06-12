extends Node2D

var ran = randi()
var c : int
# Called when the node enters the scene tree for the first time.
func _ready():
	if ! is_multiplayer_authority():return
	$Label.text =str(ran ,"   :  Invesible" , multiplayer.get_unique_id())
	$AnimatedSprite2D.play("Idle")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_multiplayer_authority():
	
		Inv.rpc()

	pass


func _on_area_2d_body_entered(body):
	if body.has_method("Playerr"):

		c+=1
		
		print(c," : Snake Animation By :", body.get_multiplayer_authority())
		
		body.invisible.rpc()
		#body.inv()
		
		await get_tree().create_timer(2).timeout 
		#queue_free()
	pass # Replace with function body.

@rpc("any_peer","call_local")
func Inv():
	if c>=2:
		c = 0
	if c == 1:
		$AnimatedSprite2D.play("Playe")
	if c == 0:
		$AnimatedSprite2D.play("Idle")
