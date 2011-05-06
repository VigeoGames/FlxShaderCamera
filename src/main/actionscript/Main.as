package  {
    import org.flixel.*;

    import pl.vigeo.test.MenuState;
	
	/**
	 * @author Adrian K.
	 */
	 [SWF( width="400", height="300", backgroundColor="#000000" )]
	[Frame( factoryClass="Preloader" )]
	public class Main extends FlxGame {
		public function Main() {
			super( 400, 300, MenuState, 1, 60, 60 );
			forceDebugger = true;
		}
	}
}

