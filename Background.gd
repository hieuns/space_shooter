extends Node

const BACKGROUND_VELOCITY = Vector2(0, 2)

func init(screensize):
  $ParallaxBackground/ParallaxLayer/Sprite.region_enabled = true
  $ParallaxBackground/ParallaxLayer/Sprite.region_rect = Rect2(0, 0, screensize.x, screensize.y)
  $ParallaxBackground/ParallaxLayer.motion_mirroring = Vector2(0, screensize.y)

func _process(delta):
  $ParallaxBackground.scroll_offset += BACKGROUND_VELOCITY
