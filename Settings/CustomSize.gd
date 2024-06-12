extends  TouchScreenButton
#
#var isDragging = false
#var touchStartPosition = Vector2.ZERO
#
#func _input(event: InputEvent) -> void:
	#if event is InputEventScreenTouch:
		#if event.pressed:
#
			#isDragging = true
			#touchStartPosition = event.position
		#elif event.is_action_released("touch"):
			#isDragging = false
		#elif isDragging:
			## Move the object only if it's being dragged
			 ## Check if the touched object is the same as 'self'
				#self.position += event.position - touchStartPosition
				#touchStartPosition = event.position
