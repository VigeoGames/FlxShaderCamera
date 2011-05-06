package pl.vigeo.flixel {
    import flash.display.BlendMode;
    import flash.display.shaders.*;


    import org.flixel.*;
    
    /**
     * A camera that uses UltimateBlendModeShader blend modes for blending. At the moment it's very basic but it should be too
     * hard to attach other shaders to it, not only the blending ones. It should overlap some other camera to let the blending
     * happen.
     *
     * Because of the way Flixel cameras operate (they are basically containers for flash.display.Sprite objects put on top of the
     * FlxGame sprite) this camera needs access to FlxCamera's _flashSprite. The reason for choosing FlxCamera for shader blending
     * is also that shaders cannot be used for neither BitmapData's draw() nor copyPixels() methods. You've got to have a
     * DisplayObject on top of another DisplayObject.
     * 
     * @see http://code.google.com/p/blendmodes4flash
     * 
     * @author Adrian K.
     */
    public class FlxShaderCamera extends FlxCamera {
    
        /**
         * List of available blend modes (eg. a list of blending shaders from UltimateBlendModeShader).
         */
        public static var blendModes:Array = [
            new BlendModeAdd(),
            new BlendModeAlpha(),
            new BlendModeAverage(),
            new BlendModeColor(),
            new BlendModeColorBurn(),
            new BlendModeColorDodge(),
            new BlendModeDarken(),
            new BlendModeDarkerColor(),
            new BlendModeDesaturate(),
            new BlendModeDifference(),
            new BlendModeDissolve(),
            new BlendModeExclusion(),
            new BlendModeExtrapolate(),
            new BlendModeFreeze(),
            new BlendModeGlow(),
            new BlendModeHardlight(),
            new BlendModeHardMix(),
            new BlendModeHeat(),
            new BlendModeHue(),
            new BlendModeLighten(),
            new BlendModeLighterColor(),
            new BlendModeLinearBurn(),
            new BlendModeLinearDodge(),
            new BlendModeLinearLight(),
            new BlendModeLuminosity(),
            new BlendModeMultiply(),
            new BlendModeNegation(),
            new BlendModeOverlay(),
            new BlendModePhoenix(),
            new BlendModePinLight(),
            new BlendModeReflect(),
            new BlendModeSaturation(),
            new BlendModeScreen(),
            new BlendModeSilhouetteAlpha(),
            new BlendModeSilhouetteLuma(),
            new BlendModeSoftlight(),
            new BlendModeStamp(),
            new BlendModeStencilAlpha(),
            new BlendModeStencilLuma(),
            new BlendModeSubtract(),
            new BlendModeVividLight()
        ];
        
        protected var _blendModeIndex:int;
        protected var _blendMode:AbstractBlendMode;
        
        /**
         * Creates a new shader blended camera with a given position, dimensions and blending mode.
         */
        public function FlxShaderCamera( x:int, y:int, width:int, height:int, zoom:Number = 0, blendModeIndex:int = -1,
            alpha:Number = 1, multiply:Number = 1 ) {
            super( x, y, width, height, zoom );
            switchBlendMode( blendModeIndex, alpha, multiply );
        }
        
        /**
         * Gets alpha of the blend mode (falls back to camera's bitmap).
         */
        override public function get alpha():Number {
            if ( _blendMode != null ) {
                return _blendMode.alpha;
            }
            return _flashBitmap.alpha;
        }
        
        /**
         * Sets alpha of the blend mode and camera's bitmap.
         */
        override public function set alpha( alpha:Number ):void {
            if ( _blendMode != null ) {
                _blendMode.alpha = alpha;
            }
            _flashBitmap.alpha = alpha;
        }
        
        public function get positionY():Number {
            return this.y;
        }

        /**
         * A little HACK to actually move the whole camera.
         */
        public function set positionY( y:Number ):void {
            _flashSprite.y = y;
            this.y = y;
        }
        
        /**
         * Gets the blend mode index.
         */
        public function get blendMode():int {
            return _blendModeIndex;
        }

        /**
         * Sets a new blend mode index and triggers blend mode switch.
         */
        public function set blendMode( index:int ):void {
            switchBlendMode( index );
        }
        
        /**
         * Switches to a blend mode by a given index (if it exists).
         */
        private function switchBlendMode( index:int, alpha:Number = 1.0, multiply:Number = 1.0 ):void {
            if ( index >= 0 && index < blendModes.length ) {
                _blendModeIndex = index;
                _blendMode = blendModes[_blendModeIndex];
                this.alpha = alpha;
                _blendMode.multiply = multiply;
                _flashSprite.blendMode = BlendMode.SHADER;
                // HACK: MXMLC complained that there's no blendShader field in flash.display.Sprite but I KNOW it's there! ;-)
                _flashSprite["blendShader"] = _blendMode;
            }
        }
    }
}

