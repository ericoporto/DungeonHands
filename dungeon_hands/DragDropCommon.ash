// DragDropCommon is open source under the MIT License.
//
// TERMS OF USE - DragDropCommon MODULE
//
// Copyright (c) 2016-present Ivan Mogilko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#ifndef __MOUSE_DRAGDROPCOMMON_MODULE__
#define __MOUSE_DRAGDROPCOMMON_MODULE__

#ifndef __MOUSE_DRAGDROP_MODULE__
#error DragDropCommon requires DragDrop module
#endif

#define MOUSE_DRAGDROPCOMMON_VERSION_00_01_00_00

// Comment this line out to completely disable DragDropCommon during compilation
#define ENABLE_MOUSE_DRAGDROPCOMMON

#ifdef ENABLE_MOUSE_DRAGDROPCOMMON

enum DragDropCommonMode
{
  eDragDropCharacter = 1, 
  eDragDropGUI, 
  eDragDropGUIControl,
  eDragDropRoomObject, 
  eDragDropInvItem, 
  NUM_DRAGDROPCOMMON_MODES
};

// DragDropCommonMove enumeration determines the way hooked object is being dragged around
enum DragDropCommonMove
{
  // drag actual object itself (position updates real-time)
  eDDCmnMoveSelf,
  // drag overlay with object's image, while object stays in place until drag ends;
  // this currently works only for characters and room objects!
  eDDCmnMoveGhostOverlay, 
  // drag GUI with object's image; this is currently only way to drag inventory items
  eDDCmnMoveGhostGUI
};

struct DragDropCommon
{
  ///////////////////////////////////////////////////////////////////////////
  //
  // Setting up
  // ------------------------------------------------------------------------
  // Functions and properties meant to configure the drag'n'drop behavior.
  //
  ///////////////////////////////////////////////////////////////////////////
  
  /// Get/set whether particular drag'n'drop mode is enabled
  import static attribute bool  ModeEnabled[];
  /// Disable drag'n'drop for all the modes
  import static void            DisableAllModes();
  
  /// Get/set whether click on AGS object should be tested using pixel-perfect detection
  /// (alternatively only hit inside bounding rectangle is tested)
  import static attribute bool  PixelPerfect;
  /// Get/set whether only Clickable AGS objects should be draggable
  import static attribute bool  TestClickable;
  
  /// Get/set the way object's drag around is represented
  import static attribute DragDropCommonMove DragMove;
  /// Get/set transparency of a representation used when DragStyle is NOT eDragDropMoveSelf
  import static attribute int   GhostTransparency;
  /// Get/set whether representation should keep sprite's alpha channel
  import static attribute bool  GhostAlpha;
  /// Get/set the GUI used to represent dragged object
  import static attribute GUI*  GhostGUI;
  
  
  ///////////////////////////////////////////////////////////////////////////
  //
  // State control
  // ------------------------------------------------------------------------
  // Properties and functions meant to tell about current drag'n'drop process
  // and control its state.
  //
  ///////////////////////////////////////////////////////////////////////////
  
  /// Gets current dragged character
  readonly import static attribute Character*   _Character;
  /// Gets current dragged GUI
  readonly import static attribute GUI*         _GUI;
  /// Gets current dragged GUIControl
  readonly import static attribute GUIControl*  _GUIControl;
  /// Gets current dragged room Object
  readonly import static attribute Object*      _RoomObject;
  /// Gets current dragged Inventory Item
  readonly import static attribute InventoryItem* _InvItem;
  /// Gets current dragged object's or its representation width
  readonly import static attribute int          ObjectWidth;
  /// Gets current dragged object's or its representation height
  readonly import static attribute int          ObjectHeight;
  /// Gets current dragged overlay's graphic (only if drag style is NOT eDragDropMoveSelf)
  readonly import static attribute int          UsedGhostGraphic;
  
  /// Start dragging a character under cursor
  import static bool  TryHookCharacter();
  /// Start dragging a GUI under cursor
  import static bool  TryHookGUI();
  /// Start dragging a GUI Control under cursor
  import static bool  TryHookGUIControl();
  /// Start dragging a room Object under cursor
  import static bool  TryHookRoomObject();
  /// Start dragging an Inventory Item under cursor
  import static bool  TryHookInventoryItem();
  /// Try to find an applicable object to drag under cursor, based on currently enabled modes
  import static bool  TryHookDraggableObject();
};

#endif  // ENABLE_MOUSE_DRAGDROPCOMMON

#endif  // __MOUSE_DRAGDROPCOMMON_MODULE__
