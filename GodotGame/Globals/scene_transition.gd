extends CanvasLayer

signal manual_fade #TESTING PURPOSES ONLY

func change_scene(target: String) -> void:
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("fade")

#**********TEST BUTTONS***********#
func fade_part1():
	$AnimationPlayer.play("fade_part1")
	

func fade_part2():
	$AnimationPlayer.play("fade_part2")

func _on_animation_player_animation_finished(anim_name):
	pass # Replace with function body.
	if anim_name == "fade_part1":
		manual_fade.emit()
#*********************************#
