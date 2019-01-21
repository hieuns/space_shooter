extends Node

const BACKGROUND_VELOCITY = Vector2(0, 2)

func _process(delta):
  $ParallaxBackground.scroll_offset += BACKGROUND_VELOCITY
