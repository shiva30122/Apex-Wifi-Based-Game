extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GetDeafaultPosition()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var Touch = 0

func _on_touch_screen_button_pressed() -> void:
	#$"../Right".scale.x +=10
	#$"../Left".scale.y +=10
	
	Touch +=1
	
	if Touch != 1:
		$Setting.hide()
		$Setting/Reset.hide()
		GameManager.Touch = false
		Touch = 0
		$Setting/Size.hide()
		$Setting/Size2.hide()
	
	#$"../Left".ChangeSize()
	if Touch == 1:
		$Setting.show()
		$Setting/Reset.show()
		GameManager.Touch = true
		$Setting/Size.show()
		$Setting/Size2.show()
	
	
	




func _up() -> void:
	pass # Replace with function body.


func _down() -> void:
	pass # Replace with function body.


func _right() -> void:
	pass # Replace with function body.


func _left() -> void:
	pass # Replace with function body.


func _increse() -> void:
	#$"../Left".Pl()
	if GameManager.TouchedNode != null:
		GameManager.TouchedNode.Pl()
	pass # Replace with function body.


func _decrease() -> void:
	#$"../Left".Mi()
	if GameManager.TouchedNode != null:
			GameManager.TouchedNode.Mi()
	pass # Replace with function body.


func _on_reset_pressed() -> void:
	SetDeafaultPosition()
	pass # Replace with function body.
	


@onready var JoyLeft : Vector2
@onready var JoyRight : Vector2


func GetDeafaultPosition():
	
	JoyRight = $"../Right".global_position
	JoyLeft = $"../Left".global_position
	
	


func SetDeafaultPosition():
	
	$"../Right".global_position = JoyRight
	$"../Left".global_position = JoyLeft
	
	
	
	
	
