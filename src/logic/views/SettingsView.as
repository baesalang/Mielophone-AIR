
import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.core.FlexGlobals;
import mx.utils.ObjectUtil;

[Bindable]
private var pluginsCollection:ArrayCollection;

public function doWork():void{
	this.dispatchEvent(new Event(Event.COMPLETE));
}

public function initSettings():void{
	pluginsCollection = new ArrayCollection( FlexGlobals.topLevelApplication.mse.getActivePlugins() );
}

private function onBufferChange(e:Event):void{
	FlexGlobals.topLevelApplication.musicPlayer.setBuffer(bufferingSlider.value * 1000);
}

private function pluginName(p:Object):String{
	return p.index + ". " + p.name + " (by " + p.author + ")";
}