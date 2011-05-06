package pl.vigeo.test  {
    import org.flixel.*;
    
    import pl.vigeo.flixel.FlxShaderCamera;
	
    /**
     * This test basically creates a second camera (on top of default camera) of FlxShaderCamera type and lets the user interact
     * with it by cycling trough available blend modes. The camera itself moves by default to better visualize the blending
     * effects (the whole camera is moved not just the scroll rect of what it sees) but the movement can be disabled by toggling
     * the "Animation" button.
     *
     * The fact that the second camera overlaps the default camera makes it possible for blending to happen.
     * 
     * @author Adrian K.
     */
    public class PlayState extends FlxState {
        [Embed( source = '../../../../resources/flixel.png')]
        private static var ImgFlixel:Class;
        
        private var image:FlxSprite;
        private var cameraDriver:FlxSprite;
        private var camera:FlxShaderCamera;
        
        private var animating:Boolean = true;
        
        private var currentBlendMode:int;
        private var blendingInfo:FlxText;
        
        override public function create():void {
            generateImage();
            generateCameraDriver();
            generateShaderCamera();
            generateUi();
        }
        
        /**
         * This image will be observed by two cameras: a default one and our shader blended camera.
         */
        private function generateImage():void {
            image = new FlxSprite( 0, 0, ImgFlixel );
            add( image );
        }
        
        /**
         * Generates a 2-node path that will be followed by camera driver in a "yoyo" style.
         */
        private function generatePath():FlxPath {
            return new FlxPath( [ new FlxPoint( 0, 120 ), new FlxPoint( 0, 0 ) ] );
        }
        
        /**
         * Generates a camera driver - a little 1x1 px helper that will follow a path (the camera itself cannot follow a path) in
         * a "yoyo" style.
         */
        private function generateCameraDriver():void {
            cameraDriver = new FlxSprite( 0, 0 ).makeGraphic( 1, 1, 0xFFFF0000 );
            cameraDriver.followPath( generatePath(), 25, FlxObject.PATH_YOYO );
            add( cameraDriver );
        }
        
        /**
         * Generates a shader blended camera. It must be on top of default camera for the effect to be visible.
         */
        private function generateShaderCamera():void {
            camera = new FlxShaderCamera( 0, 0, FlxG.width, image.height, 0, 0 );
            FlxG.addCamera( camera );
        }
        
        /**
         * Generates UI controls.
         */
        private function generateUi():void {
            add( new FlxButton( 4, FlxG.height - 24, "Prev blending", onPreviousBlending ) );
            add( new FlxButton( 88, FlxG.height - 24, "Next blending", onNextBlending ) );
            add( new FlxButton( FlxG.width - 168, FlxG.height - 24, "Animation", onAnimationToggle ) );
            add( new FlxButton( FlxG.width - 84, FlxG.height - 24, "Quit", onQuit ) );
            blendingInfo = new FlxText( 168, FlxG.height - 22, 45, "1 of " + FlxShaderCamera.blendModes.length );
            blendingInfo.alignment = "right";
            add( blendingInfo );
        }
        
        /**
         * Cycles to the next blend mode.
         */
        private function onNextBlending():void {
            currentBlendMode += 1;
            if ( currentBlendMode == FlxShaderCamera.blendModes.length ) {
                currentBlendMode = 0;
            }
            camera.blendMode = currentBlendMode;
            updateBlendingInfo();
        }
        
        /**
         * Cycles to the previous blend mode.
         */
        private function onPreviousBlending():void {
            currentBlendMode -= 1;
            if ( currentBlendMode < 0 ) {
                currentBlendMode = FlxShaderCamera.blendModes.length - 1;
            }
            camera.blendMode = currentBlendMode;
            updateBlendingInfo();
        }
        
        /**
         * Toggles animation of camera.
         */
        private function onAnimationToggle():void {
            animating = !animating;
            if ( !animating ) {
                cameraDriver.stopFollowingPath( true );
                cameraDriver.velocity.y = 0;
                cameraDriver.y = 0;
            }
            else {
                cameraDriver.followPath( generatePath(), 25, FlxObject.PATH_YOYO );
            }
        }
        
        /**
         * Returns to menu.
         */
        private function onQuit():void {
            FlxG.switchState( new MenuState() );
        }

        /**
         * Updates the whole state and camera parameters.
         */
        override public function update():void {
            super.update();
            updateCamera();
        }
        
        /**
         * Updates blend mode info text.
         */
        private function updateBlendingInfo():void {
            blendingInfo.text = "" + ( currentBlendMode + 1 ) + " of " + FlxShaderCamera.blendModes.length;
        }
        
        /**
         * Updates camera alpha and position based on camera driver parameters.
         */
        private function updateCamera():void {
            // Retain at least 0.5 alpha
            camera.alpha = 1.0 - ( cameraDriver.y / 120.0 / 2.0 );
            camera.positionY = cameraDriver.y;
        }
    }
}

