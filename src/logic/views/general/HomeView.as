
import com.greensock.TweenLite;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

import mielophone.ui.views.search.ArtistSearchView;

import mx.core.FlexGlobals;

public function doWork():void{
	this.dispatchEvent(new Event(Event.COMPLETE));
}

private function onArtistClick(e:Event):void{
	FlexGlobals.topLevelApplication.changeView(FlexGlobals.topLevelApplication.artistView);
}

private function onAlbumClick(e:Event):void{
	FlexGlobals.topLevelApplication.changeView(FlexGlobals.topLevelApplication.albumView);
}

private function onSongClick(e:Event):void{
	FlexGlobals.topLevelApplication.changeView(FlexGlobals.topLevelApplication.songView);
}

private function onSettingsClick(e:Event):void{
	FlexGlobals.topLevelApplication.changeView(FlexGlobals.topLevelApplication.settingsView);
}

private function onMarketClick(e:Event):void{
	FlexGlobals.topLevelApplication.changeView(FlexGlobals.topLevelApplication.marketView);
}

private function onVideoClick(e:Event):void{
	FlexGlobals.topLevelApplication.changeView(FlexGlobals.topLevelApplication.videoView);
}

private function onRadioStreamClick(e:Event):void{
	FlexGlobals.topLevelApplication.changeView(FlexGlobals.topLevelApplication.radioView);
}

private function onSearchKey(e:KeyboardEvent):void{
	if(e.keyCode == Keyboard.ENTER && searchInput.text.length > 1){
		FlexGlobals.topLevelApplication.searchResView.query = searchInput.text;
		
		FlexGlobals.topLevelApplication.changeView(FlexGlobals.topLevelApplication.searchResView);
		
		searchInput.text = '';
	}else if(e.keyCode == Keyboard.ESCAPE){
		searchInput.text = '';
	}
}