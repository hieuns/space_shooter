# Things I learned:
## Miscelaneous
  - When you define an inherited scene which inherites a scene extends the Area2D or KinematicBody2D, the parent scene **must** have a collision node, otherwise you can't call user-defined methods of that scene's script. In the inherite scene, define a shape for that collision node.
  - The Timer must be added into scene to be able to work.
  - Create an infinite background: See [this](https://github.com/hieuns/space_shooter#infinite-background).

## Infinite background
This is an instruction on how to create a background scrolling downward infinitely.

  - Create a scene with this hierachy: `Node` > `ParallaxBackground` > `ParallaxLayer` > `Sprite`.
  - Import an background image (this image can be a small image, we can repeat it to fill the entire background). Godot will import it with `Repeat` and `Mipmaps` flags disabled. You should select that image, inspect it in `Import` tab, enable `Repeat` and `Mipmaps` flags, then click `Reimport`.
  - In `Sprite`, load the background image.
  - To repeat the image to fill the background, reveal the `Inspector`/`Region` panel, check the `Enable` flag, and fill the `w` and `h` field of the `Rect` with the `width` and `height` of the screen size of the game.
  - In `ParallaxLayer`, reveal the `Inspector`/`Motion` panel, edit the `Mirroring` property. In my case, I want the background move downward, so I will set the `y` field to the height of the screen's height (I misunderstood that the value of `x` (or `y`) field should be double of the screen's `width` (or `height`) and set that wrong value, then a blank gap (which the height is the same as the screen, if I'm correct) appeared between the original background and the mirrored one, so don't do that :D).
  - Create a script for the `Node`. In the `_process()` function, increase the `scroll_offset` of `ParallaxBackground` with a `Vector2`, which represent the scrolling speed of the background. My background moves downward, so the value of that `Vector2` is `(0, 2)`.

```gdscript

const BACKGROUND_SPEED = Vector2(0, 2)

func _process(delta):
  $ParallaxBackground.scroll_offset += BACKGROUND_SPEED
```

Play the scene, then the background should scroll infinitely.

