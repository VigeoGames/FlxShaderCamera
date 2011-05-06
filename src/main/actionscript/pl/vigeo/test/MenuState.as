package pl.vigeo.test {
	import org.flixel.*;
	
	/**
     * @author Adrian K.
     */
    public class MenuState extends FlxState {
        override public function create():void {
            add( new FlxText( 0, FlxG.height / 2 - 20 , FlxG.width, "FlxShaderCamera" ).
                setFormat( "system", 32, 0xFFFFFFFF, "center" ) );
            add( new FlxText( 0, FlxG.height - 30, FlxG.width, "click to test" ).
                setFormat( "system", 16, 0xFFFFFFFF, "center" ) );
            FlxG.mouse.show();
        }

        override public function update():void {
            super.update();
            if ( FlxG.mouse.justPressed() ) {
                FlxG.switchState( new PlayState() );
            }
        }
    }
}

