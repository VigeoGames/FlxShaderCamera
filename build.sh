#!/bin/sh

export WORKSPACE="`pwd`/.."

mxmlc -warnings -strict -optimize -incremental -target-player "10.1.0" -static-link-runtime-shared-libraries -l+=../ultimate-blendmode-shader/UltimateBlendModeShader.swc -sp=src/main/actionscript -sp+=../flixel/flixel-2.53-dev-0fa2087 src/main/actionscript/Main.as && mv src/main/actionscript/Main.swf ./bin/FlxShaderCameraTest.swf
