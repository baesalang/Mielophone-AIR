
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import mx.core.FlexGlobals;

private function initHotkeys():void{
	this.nativeApplication.addEventListener(KeyboardEvent.KEY_UP, onKeyPress);
}

private function onKeyPress(e:KeyboardEvent):void{
	switch(e.keyCode){
		// simple spacebar play-pause
		case Keyboard.SPACE:
			FlexGlobals.topLevelApplication.musicPlayer.togglePlayPause();
			break;
		
		// Media keys
		case Keyboard.PAUSE:
			FlexGlobals.topLevelApplication.musicPlayer.pausePlayback();
			break;
		case Keyboard.PLAY:
			FlexGlobals.topLevelApplication.musicPlayer.resumePlayback();
			break;
		case Keyboard.NEXT:
			FlexGlobals.topLevelApplication.musicPlayer.findNextSong();
			break;
		case Keyboard.PREVIOUS:
			FlexGlobals.topLevelApplication.musicPlayer.findPrevSong();
			break;
		case Keyboard.STOP:
			FlexGlobals.topLevelApplication.musicPlayer.stopPlayback();
			break;
	}
}