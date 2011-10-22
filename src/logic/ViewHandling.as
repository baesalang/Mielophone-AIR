import com.codezen.skins.scroll.SmallScroll;
import com.codezen.skins.scroll.SmallVScrollThumb;
import com.codezen.skins.scroll.SmallVScrollTrack;
import com.greensock.TweenLite;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.ui.Mouse;
import flash.utils.Timer;

import mielophone.ui.skins.MielophoneApplication;

import mx.messaging.messages.ErrorMessage;
import mx.utils.ObjectUtil;

import spark.components.Group;

/******************************************************/
/**						VARS						 **/
/******************************************************/
// current view
private var currentView:String;
// views array
private var viewHistory:Array;
// 
public var animationEnabled:Boolean = true;

/******************************************************/
/**					INITIALIZATION					 **/
/******************************************************/
private function initViewHelpers():void{
	viewHistory = [];
	currentView = "homeView";
}

/******************************************************/
/**				BACK BUTTON HANDLING			 	 **/
/******************************************************/

public function navigateBack(home:Boolean = false):void{
	if( viewHistory.length == 0 ) return;
	
	// new view var
	var newView:String;
	
	// if home button pressed - go home
	if( home ){
		// pop and hide all old views
		while(viewHistory.length > 1){
			newView = viewHistory.pop();
			this[newView].visible = false;
		}
	}
	
	// get new view string
	newView = viewHistory.pop();
	
	// get current view
	var view:Group = this[currentView];
	// reset size and position to absolute 
	view.horizontalCenter = view.verticalCenter = 0;
	view.height = stage.stageHeight-64; 
	view.width = nativeWindow.width;
	
	// show new view
	this[newView].visible = true;
	
	// animate move-out
	if(animationEnabled){
		TweenLite.to(view, 0.3, {width:nativeWindow.width-100, height:stage.height-100, onComplete:function():void{
			TweenLite.to(view, 0.5, {horizontalCenter:nativeWindow.width, onComplete:function():void{
				view.visible = false;
			}});
		}});
	}else{
		view.visible = false;
	}
	
	currentView = newView;
}

/******************************************************/
/**					VIEW CHANGING					 **/
/******************************************************/

public function changeView(view:*):void{	
	// show loader
	loadingOn();
	
	// do view work
	view.addEventListener(Event.COMPLETE, onViewWork);
	view.addEventListener(ErrorEvent.ERROR, onViewError);
	view.doWork();
}

private function onViewError(e:ErrorEvent):void{
	e.target.removeEventListener(Event.COMPLETE, onViewWork);
	e.target.removeEventListener(ErrorEvent.ERROR, onViewError);
	
	loadingOff();
}

private function onViewWork(e:Event):void{
	e.target.removeEventListener(Event.COMPLETE, onViewWork);
	
	// remove loading indicator 
	loadingOff();
	// get view
	var view:Group = e.target as Group;
	
	// if view is already active - do nothing;
	if(currentView == view.id)
		return;
	
	// check if it's reverse
	var reverse:Boolean = this.getElementIndex(view) < this.getElementIndex(this[currentView]);
	
	if(reverse){
		// remove old view
		viewHistory.pop();
		
		// get current view
		var viewOld:Group = this[currentView];
		// reset size and position to absolute 
		viewOld.horizontalCenter = viewOld.verticalCenter = 0;
		viewOld.height = stage.stageHeight-64; 
		viewOld.width = nativeWindow.width;
		
		// show new view
		view.x = view.y = 0;
		view.horizontalCenter = view.verticalCenter = 0;
		view.percentHeight = view.percentWidth = 100;
		view.visible = true;
		
		trace(view.horizontalCenter, view.id, view.visible);
		
		// animate move-out
		if(animationEnabled){
			TweenLite.to(viewOld, 0.3, {width:nativeWindow.width-100, height:stage.height-100, onComplete:function():void{
				TweenLite.to(viewOld, 0.5, {horizontalCenter:nativeWindow.width, onComplete:function():void{
					viewOld.visible = false;
					viewOld.horizontalCenter = 0;
				}});
			}});
		}else{
			viewOld.visible = false;
			viewOld.horizontalCenter = 0;
		}
	}else{
		// save last view
		viewHistory.push(currentView);
		
		// position window outside
		//view.percentWidth = view.percentHeight = 95;
		view.width = this.stage.stageWidth - 100;
		view.height = this.stage.stageHeight - 100;
		view.horizontalCenter = this.stage.stageWidth; 
		view.verticalCenter = 0;
		view.visible = true;
		
		// get old view
		var oldView:Group = this[viewHistory[viewHistory.length-1]] as Group;
		
		// animate move-in
		if(animationEnabled){
			TweenLite.to(view, 0.5, {horizontalCenter:0, onComplete:function():void{
				TweenLite.to(view, 0.3, {width:stage.stageWidth, height:stage.stageHeight-64, onComplete:function():void{
					// set new params
					view.x = view.y = 0;
					view.percentHeight = view.percentWidth = 100;
					// hide old view
					oldView.visible = false;
					oldView.horizontalCenter = 0;
				}});
			}});
		}else{
			view.horizontalCenter = 0;
			// set new params
			view.x = view.y = 0;
			view.percentHeight = view.percentWidth = 100;
			// hide old view
			oldView.visible = false;
			oldView.horizontalCenter = 0;
		}
	}
	
	// set new current view
	currentView = view.id;
}

/******************************************************/
/**					LOADING INDICATION				 **/
/******************************************************/
public function loadingOn():void{
	(this.skin as MielophoneApplication).loadingIndicator.visible = (this.skin as MielophoneApplication).loadingIndicator.isLoading = true;
}

public function loadingOff():void{
	(this.skin as MielophoneApplication).loadingIndicator.visible = (this.skin as MielophoneApplication).loadingIndicator.isLoading = false;
}