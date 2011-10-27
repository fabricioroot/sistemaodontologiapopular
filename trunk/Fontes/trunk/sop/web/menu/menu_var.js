/***********************************************************************************
*	(c) Ger Versluis 2000 version 5.411 24 December 2001 (updated Jan 31st, 2003 by Dynamic Drive for Opera7)
*	For info write to menus@burmees.nl		          *
*	You may remove all comments for faster loading	          *
***********************************************************************************/


var LowBgColor='#B0FFAE';			// Background color when mouse is not over
var LowSubBgColor='#B0FFAE';			// Background color when mouse is not over on subs
var HighBgColor='#93FF93';			// Background color when mouse is over
var HighSubBgColor='#72FF72';			// Background color when mouse is over on subs
var FontLowColor='#000';			// Font color when mouse is not over
var FontSubLowColor='#222';			// Font color subs when mouse is not over
var FontHighColor='#111';			// Font color when mouse is over
var FontSubHighColor='#333';			// Font color subs when mouse is over
var BorderColor='#54FF9F';			// Border color
var BorderSubColor='#54FF9F';			// Border color for subs
var BorderWidth=0;				// Border width
var BorderBtwnElmnts=1;				// Border between elements 1 or 0
var FontFamily="verdana"			// Font family menu items
var FontSize=8;					// Font size menu items
var FontBold=1;					// Bold menu items 1 or 0
var FontItalic=0;				// Italic menu items 1 or 0
var MenuTextCentered='left';			// Item text position 'left', 'center' or 'right'
var MenuCentered='left';			// Menu horizontal position 'left', 'center' or 'right'
var MenuVerticalCentered='top';                 // Menu vertical position 'top', 'middle','bottom' or static
var ChildOverlap=0;				// horizontal overlap child/ parent
var ChildVerticalOverlap=.0;			// vertical overlap child/ parent
var StartTop=0;					// Menu offset x coordinate
var StartLeft=0;				// Menu offset y coordinate
var VerCorrect=0;				// Multiple frames y correction
var HorCorrect=0;				// Multiple frames x correction
var LeftPaddng=3;				// Left padding
var TopPaddng=2;				// Top padding
var FirstLineHorizontal=1;			// SET TO 1 FOR HORIZONTAL MENU, 0 FOR VERTICAL
var MenuFramesVertical=1;			// Frames in cols or rows 1 or 0
var DissapearDelay=50;				// delay before menu folds in
var TakeOverBgColor=0;				// Menu frame takes over background color subitem frame
var FirstLineFrame='navig';			// Frame where first level appears
var SecLineFrame='space';			// Frame where sub levels appear
var DocTargetFrame='space';			// Frame where target documents appear
var TargetLoc='';				// span id for relative positioning
var HideTop=0;					// Hide first level when loading new document 1 or 0
var MenuWrap=0;					// enables/disables menu wrap 1 or 0
var RightToLeft=0;				// enables/disables right to left unfold 1 or 0
var UnfoldsOnClick=0;				// Level 1 unfolds onclick/ onmouseover
var WebMasterCheck=1;				// menu tree checking on or off 1 or 0
var ShowArrow=0;				// Uses arrow gifs when 1
var KeepHilite=1;				// Keep selected path highligthed
var altura=24;					//Altura dos sub-menus
var largura=190;				//Largura dos sub-menus
var alturaMenu=24;				//Altura dos menus
var larguraMenu=110;				//Largura dos menus
var Arrws=['images/tri.gif',5,10,'images/tridown.gif',10,5,'images/trileft.gif',5,10];	// Arrow source, width and height

function BeforeStart(){
    return
}
function AfterBuild(){
    return
}
function BeforeFirstOpen(){
    return
}
function AfterCloseAll(){
    return
}