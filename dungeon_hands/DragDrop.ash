// DragDrop is open source under the MIT License.
//
// TERMS OF USE - DragDrop MODULE
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

#ifndef __MOUSE_DRAGDROP_MODULE__
#define __MOUSE_DRAGDROP_MODULE__

#define MOUSE_DRAGDROP_VERSION_00_01_00_00

// Comment this line out to completely disable DragDrop during compilation
#define ENABLE_MOUSE_DRAGDROP

#ifdef ENABLE_MOUSE_DRAGDROP

enum DragDropMode
{
  eDragDropNone = 0
};

// An action to do when the hook key is released
enum DragDropUnhookAction
{
  eDDUnhookDrop,  // drop the dragged object at current cursor position
  eDDUnhookRevert // revert the dragged object to its initial position
};

struct DragDrop
{
  ///////////////////////////////////////////////////////////////////////////
  //
  // Setting up
  // ------------------------------------------------------------------------
  // Functions and properties meant to configure the drag'n'drop behavior.
  //
  ///////////////////////////////////////////////////////////////////////////
  
  /// Enables or disables DragDrop work, without cancelling any settings
  import static attribute bool        Enabled;
  
  /// Get/set default hook key
  import static attribute eKeyCode    DefaultHookKey;
  /// Get/set default hook mouse button
  import static attribute MouseButton DefaultHookMouseButton;
  /// Get/set minimal number of pixels the mouse should move before it is considered to be dragging
  import static attribute int         DragMinDistance;
  /// Get/set minimal time (in milliseconds) the mouse should move before it is considered to be dragging
  import static attribute int         DragMinTime;
  
  /// Get/set if the module should automatically track hook key press and release
  import static attribute bool        AutoTrackHookKey;
  /// Get/set the default action that should be done to dragged object when the hook key is released;
  /// this action may be overriden by user by explicitly calling Drop() or Revert()
  import static attribute DragDropUnhookAction DefaultUnhookAction;
  
  
  ///////////////////////////////////////////////////////////////////////////
  //
  // Event signals
  // ------------------------------------------------------------------------
  // Properties meant to signal user about drag'n'drop events.
  //
  ///////////////////////////////////////////////////////////////////////////
  
  /// Gets if the hook key was pushed down and the module is looking for the actual
  /// draggable object under the cursor; this is when the user should supply module
  /// with draggable object
  readonly import static attribute bool EvtWantObject;
  /// Gets if the draggable object was just hooked; this is when the user may take
  /// some action right before the object will be actually dragged around
  readonly import static attribute bool EvtObjectHooked;
  /// Gets if mouse drag just started; this event takes place if the draggable object
  /// was found and drag conditions were met (minimal drag time and/or distance)
  readonly import static attribute bool EvtDragStarted;
  /// Gets if the mouse drag was just released; the event takes place just a tick
  /// before object is actually dropped on a new place, letting user to choose a drop
  /// coordinates or revert the drag
  readonly import static attribute bool EvtWantDrop;
  /// Gets if the object was just dropped on a new position
  readonly import static attribute bool EvtDropped;
  
  
  ///////////////////////////////////////////////////////////////////////////
  //
  // State control
  // ------------------------------------------------------------------------
  // Properties and functions meant to tell about current drag'n'drop process
  // and control its state.
  //
  ///////////////////////////////////////////////////////////////////////////
  
  /// Gets if the module is currently doing nothing
  readonly import static attribute bool         IsIdle;
  /// Gets if the module has an object hooked (during pre-dragging, dragging or dropping states)
  readonly import static attribute bool         HasObjectHooked;
  /// Gets if the mouse is currently being dragged (drag button held down and mouse moved)
  readonly import static attribute bool         IsDragging;
  /// Gets the current hook key
  readonly import static attribute int          CurrentKey;
  /// Gets the current drag mouse button
  readonly import static attribute MouseButton  CurrentMouseButton;
  /// Gets the current drag mode (this hints the type of object being dragged)
  readonly import static attribute int          CurrentMode;
  /// Gets the user-defined dragged object integer tag
  readonly import static attribute int          ObjectTag;
  /// Gets the user-defined dragged object String tag
  readonly import static attribute String       ObjectSTag;
  /// Gets X coordinate of cursor position at which the hook key was pushed down
  readonly import static attribute int          DragStartX;
  /// Gets Y coordinate of cursor position at which the hook key was pushed down
  readonly import static attribute int          DragStartY;
  /// Gets X coordinate of initial object's position
  readonly import static attribute int          ObjectStartX;
  /// Gets Y coordinate of initial object's position
  readonly import static attribute int          ObjectStartY;
  /// Gets X coordinate of the dragged object's position
  readonly import static attribute int          ObjectX;
  /// Gets Y coordinate of the dragged object's position
  readonly import static attribute int          ObjectY;
  
  /// Notify hook key push down; this does not have to be real keycode
  import static void  HookKeyDown(int user_key = 0, MouseButton mbtn = 0);
  /// Assign a draggable object for the module when it expects to find one under the mouse cursor
  import static void  HookObject(int user_mode, int obj_x, int obj_y, int tag = 0, String stag = 0);
  /// Notify hook key release
  import static void  HookKeyUp();
  
  /// Drop the object now
  import static void  Drop();
  /// Drop the object now and position it at the given coordinates
  import static void  DropAt(int x, int y);
  /// Reset drag; if an AGS object was dragged, return it to original position
  import static void  Revert();
};

#endif  // ENABLE_MOUSE_DRAGDROP

#endif  // __MOUSE_DRAGDROP_MODULE__
