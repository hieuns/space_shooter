extends Sprite

func init(_position):
  position = _position
  $AnimationPlayer.play("explosion")

func _on_AnimationPlayer_animation_finished(anim_name):
  queue_free()
