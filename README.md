# FlxShaderCamera #

A simple extension of Flixel's FlxCamera that uses [UltimateBlendModeShader][ubmsHomePage] for blending. It's more a
proof-of-concept that shaders can be used with Flixel than a complete solution. But it should be a nice start to get you going. :-)

## Demo ##

You can see it in action [here](http://vigeo.pl/labs/flxshadercamera/). The demo follows the Flixel feature template format.

It basically creates a second camera (on top of default camera) of FlxShaderCamera type and lets the user interact with it by
cycling trough available blend modes. The camera itself moves by default to better visualize the blending effects (the whole
camera is moved not just the scroll rect of what it sees) but the movement can be disabled by toggling the "Animation" button.

The fact that the second camera overlaps the default camera makes it possible for blending to happen.

Oh, and it requires Flash Player 10. Or 10.1, I'm not sure. ;P

## Compilation ##

You will need Flex SDK (for example 4.1.0.16076), Java 6, [Flixel 2.50][flixelRepository] in your classpath and
[UltimateBlendModeShader][ubmsHomePage] SWC in your library path to compile it. You will also need to enable static linking of
runtime shared libraries so the compiled shader files from UBMC SWC get embedded in your SWF.

You will also need to make a little modification in Flixel's FlxCamera: the field _flashSprite must be public (instead of internal).
Or you can add a getter for this field and modify the way it's accessed in FlxShaderCamera.

## Shortcomings ##

Because shaders cannot be used in Bitmap's draw() or copyPixels() methods the only reasonable place to add shaders was FlxCamera.
Flixel cameras are basically containers for flash.display.Sprite objects put on top of the FlxGame sprite so for blending the
visible area must be drawn in at least two cameras).

The other thing to keep in mind is that some shaders can be really heavy-weight. Some of the shaders in demo make the framerate
drop by half.

[flixelRepository]: http://github.com/AdamAtomic/flixel
[ubmsHomePage]: http://code.google.com/p/blendmodes4flash/
