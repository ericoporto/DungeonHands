AGSScriptModule        �.  // new module script
String LeftClickText;
String RightClickText;
int y_inventory_modifier;
String cur_obj;
String cur_verb;
String action_text;
String shown_action_text;
bool cur_right_click;
bool cur_left_click;
int i_action_type_writer;
int i_life_time;
int action_life_time;
bool in_click_animation;
int i_show_text;
String previous_text;

int original_left_click_graphic;
int original_right_click_graphic;
DynamicSprite * ds_left_click_mouse;
DynamicSprite * ds_right_click_mouse;
DrawingSurface * DSurf_left_click;
DrawingSurface * DSurf_right_click;


bool isRightClickAvailable(){
  if (player.ActiveInventory == null)
  {
    int thisLocationType = GetLocationType(mouse.x, mouse.y);
    if (thisLocationType != eLocationNothing)
    {
      if(thisLocationType == eLocationHotspot)
      {
        Hotspot *thisHotspot = Hotspot.GetAtScreenXY(mouse.x, mouse.y);
        return thisHotspot.IsInteractionAvailable(eModeLookat);
      }else if(thisLocationType == eLocationCharacter){ 
        Character *thisCharacter = Character.GetAtScreenXY(mouse.x, mouse.y);
        return thisCharacter.IsInteractionAvailable(eModeLookat);
      }else if(thisLocationType == eLocationObject){
        Object *thisObject = Object.GetAtScreenXY(mouse.x, mouse.y);
        return thisObject.IsInteractionAvailable(eModeLookat);
      }   
    } else {
      InventoryItem *i = InventoryItem.GetAtScreenXY(mouse.x, mouse.y);
      if (i != null)
      {
        return i.IsInteractionAvailable(eModeLookat);
      }
    }
  } else {
    return false;
  }
  return false;
}



int countNonEmpty;

bool isLeftClickAvailable(){
  int thisLocationType = GetLocationType(mouse.x, mouse.y);
      
  if (thisLocationType != eLocationNothing)
  {
    if(thisLocationType == eLocationHotspot)
    {
      Hotspot *thisHotspot = Hotspot.GetAtScreenXY(mouse.x, mouse.y);
      if (player.ActiveInventory == null)
      {
        return thisHotspot.IsInteractionAvailable(eModeInteract); //true = interact, false = walk
      }
      else
      {
        return thisHotspot.IsInteractionAvailable(eModeUseinv); //use item
      }    
    } else if(thisLocationType == eLocationCharacter){ 
      Character *thisCharacter = Character.GetAtScreenXY(mouse.x, mouse.y);
      if (player.ActiveInventory == null)
      {
        return thisCharacter.IsInteractionAvailable(eModeInteract); //true = talk, false = walk
      }
      else
      {
        return thisCharacter.IsInteractionAvailable(eModeUseinv); //use item
      } 
    } else if(thisLocationType == eLocationObject){
      Object *thisObject = Object.GetAtScreenXY(mouse.x, mouse.y);
      if (player.ActiveInventory == null)
      {
        return thisObject.IsInteractionAvailable(eModeInteract); //interact
      }
      else
      {
        return thisObject.IsInteractionAvailable(eModeUseinv); //use item
      } 
    }
  }
  else
  {
    if (player.ActiveInventory == null)
    {
      InventoryItem *i = InventoryItem.GetAtScreenXY(mouse.x, mouse.y);
      if (i != null)
      {
        chuckleItemSprite(i);
        return true;
      }
    }
    else
    {
      InventoryItem *i = InventoryItem.GetAtScreenXY(mouse.x, mouse.y);
      if (i != null && (i.ID == player.ActiveInventory.ID))
      {
        return false; //nothing
      }
      else
      {
        if (i != null){
          chuckleItemSprite(i);
        }
        //LeftClickText = Game.GetLocationName(mouse.x, mouse.y);
        return true;
      }
    }
  }
  return false;		  
}

void UpdateMouseActions(){
  if(!bool_optimizeForTouch){
    buttonLeftMouseClick.Visible = isLeftClickAvailable();
    buttonRightMouseClick.Visible = isRightClickAvailable();
  } else {
    buttonLeftMouseClick.Visible = false;
    buttonRightMouseClick.Visible = false;
  }
}


void AdjustActionTextPosition() 
{
  bool showmouse;
  showmouse = (GetGuiOvertext() == "" && !bool_optimizeForTouch);
  
  int txtHeight = GetTextHeight(lblActionText.Text, eFontSmallFontOutlined, lblActionText.Width);
  int ymouse = 14-txtHeight;
  int txtWidth = GetTextWidth(lblActionText.Text, eFontSmallFontOutlined);
  if(txtWidth > lblActionText.Width){
    txtWidth = lblActionText.Width;
  }
  int actionLabelWidth = txtWidth + 4+9*showmouse;
  
  if(actionLabelWidth <= 14 || InteractionDetector.isShown()){
    gActionText.Transparency = 100;
  } else {
    //gActionText.Transparency = 0;  
    if(i_show_text>11){
      gActionText.Transparency=16;
    } else if(i_show_text<3){
      gActionText.Transparency=75;
    } else if(i_show_text<6){
      gActionText.Transparency=60;
    } else if(i_show_text<9){
      gActionText.Transparency=40;
    } else if(i_show_text<12){
      gActionText.Transparency=25;
    } 
    
    if(ControlsTutorial.inTutorial()){
      countNonEmpty++;
      if(countNonEmpty>100){
        ControlsTutorial.mouseAround();  
      }
    }
  }
  int actionLabelHalf = actionLabelWidth / 2;
  int xpos;
  int ypos;
  
  if(!bool_optimizeForTouch){
    if(InventoryItem.GetAtScreenXY(mouse.x, mouse.y)!=null){
      if(y_inventory_modifier<28){
        y_inventory_modifier++;  
      }
    } else {
      if(y_inventory_modifier>1){
        y_inventory_modifier--;  
      }
    }
    
    //prefer mouse
    xpos = mouse.x - actionLabelHalf ;
    ypos = mouse.y - Game.SpriteHeight[mouse.GetModeGraphic(mouse.Mode)] - 4 +ymouse+y_inventory_modifier;
    
    if (xpos + actionLabelWidth >= System.ScreenWidth) xpos = System.ScreenWidth - actionLabelWidth;
    else if (xpos < 0) xpos = 0;
    
    
    if (ypos + txtHeight+2 >= System.ScreenHeight) ypos = System.ScreenHeight - txtHeight -2;  //untested
    else {
      if (ypos < 0 ) ypos = 0;
    }
  } else {
    //ignore mouse, we are using touch!
    xpos = System.ViewportWidth/2 - actionLabelHalf ;
    ypos = System.ViewportHeight - 18;
  }
  
  gActionText.X = xpos;
  gActionText.Y = ypos;
  if(showmouse){
    lblActionText.X = 11;
    buttonActionMouse.Visible = true;
  } else {
    lblActionText.X = 2;
    buttonActionMouse.Visible = false;
  }
  
  gActionText.Height = txtHeight+2;
  lblActionText.Height = txtHeight;
  gActionText.Width = actionLabelWidth; 
  
  i_show_text++;
  if(gActionText.Transparency!=100){
    if(lblActionText.Text.Length > 1 && lblActionText.Text.CompareTo(previous_text)!=0){
      i_show_text=0;
      previous_text = lblActionText.Text;
    }
  }
  
  
}

//--------------------------------------------------------------------
//public functions
static void actionBar::show(){
  
}
static void  actionBar::hide(){
  
}

bool didnt_reset_click_images;

void resetClickImages(){
  DSurf_left_click = ds_left_click_mouse.GetDrawingSurface();
  DSurf_left_click.Clear();
  DSurf_left_click.DrawImage(0, 0, original_left_click_graphic);
  DSurf_left_click.Release();
  DSurf_right_click = ds_right_click_mouse.GetDrawingSurface();
  DSurf_right_click.Clear();
  DSurf_right_click.DrawImage(0, 0, original_right_click_graphic);
  DSurf_right_click.Release();
}

function doClick(bool click_lt_rf, String verb, String clicked_obj){
  if(clicked_obj.Length <= 1){
    return false;
  }
  
  if(in_click_animation){
    return false;  
  }
  
  cur_left_click = click_lt_rf;
  cur_right_click = !click_lt_rf;
  cur_verb = verb;
  cur_obj = clicked_obj;
  shown_action_text = String.Format(" %s", cur_obj);
  action_text = String.Format("%s %s", cur_verb, cur_obj);
  i_life_time = 0;
  i_action_type_writer = 0;
  action_life_time = SecondsToLoops(2.0);
  in_click_animation = true;
  return true;
}

function updateClickAnimation(){
  if(!in_click_animation){
    if(didnt_reset_click_images){
      resetClickImages();
      didnt_reset_click_images = false;
    }
    return;  
  }
  
  i_life_time++;  
  if(i_life_time>action_life_time){
    in_click_animation = false;
    lblActionText.Text = "";
    resetClickImages();
    didnt_reset_click_images = false;
    return;
  }
  
  int tint_c = 100*(action_life_time-i_life_time)/action_life_time;
  if(cur_left_click){
    DSurf_left_click = ds_left_click_mouse.GetDrawingSurface();
    DSurf_left_click.Clear();
    DSurf_left_click.DrawImage(0, 0, original_left_click_graphic);
    DSurf_left_click.Release();
    ds_left_click_mouse.Tint(255, 255, 255, tint_c, tint_c/2+50);
    didnt_reset_click_images = true;
  } else {
    DSurf_right_click = ds_right_click_mouse.GetDrawingSurface();
    DSurf_right_click.Clear();
    DSurf_right_click.DrawImage(0, 0, original_right_click_graphic);
    DSurf_right_click.Release();
    ds_right_click_mouse.Tint(255, 255, 255, tint_c, tint_c/2+50);
    didnt_reset_click_images = true;
  }
  
  shown_action_text = String.Format("%s %s",cur_verb.Substring(0, i_action_type_writer), cur_obj);
  if(i_action_type_writer<cur_verb.Length){
    i_action_type_writer++;  
  }
  lblActionText.Text=shown_action_text;
}

static bool  actionBar::leftclick(String verb, String clicked_obj){
  //TopHeadNotification.notify(String.Format("left-click: %s %s", verb, clicked_obj));
  if(doClick(true, verb, clicked_obj)){
    Wait(SecondsToLoops(0.3));
    return true;
  }
  return false;
}

static bool  actionBar::rightclick(String verb, String clicked_obj){
  //TopHeadNotification.notify(String.Format("right-click: %s %s", verb, clicked_obj));
  if(doClick(false, verb, clicked_obj)){
    Wait(SecondsToLoops(0.3));
    return true;
  }
  return false;

}

//end public functions
//--------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------
// repeatedly_execute_always()
//----------------------------------------------------------------------------------------------------
function repeatedly_execute_always(){
  updateClickAnimation();
  AdjustActionTextPosition();
}


//----------------------------------------------------------------------------------------------------
// repeatedly_execute()
//----------------------------------------------------------------------------------------------------
function repeatedly_execute()
{
	// Action Text
	// We always display the name of what is under the mouse, with one exception:
	// IF the player has an inventory item selected and hovers over the same inventory item, 
	// we display nothing to indicate that an item can not be used on itself
  UpdateMouseActions();
  in_click_animation = false;
	if (player.ActiveInventory == null)
	{
		lblActionText.Text = Game.GetLocationName(mouse.x, mouse.y);
    if(lblActionText.Text == ""){
      lblActionText.Text = GetGuiOvertext();  
    }
	}
	else
	{
		InventoryItem *i = InventoryItem.GetAtScreenXY(mouse.x, mouse.y);
		if (i != null && (i.ID == player.ActiveInventory.ID))
		{
			lblActionText.Text = "";
		}
		else
		{
			lblActionText.Text = Game.GetLocationName(mouse.x, mouse.y);
		}
	}
}

//----------------------------------------------------------------------------------------------------
// game_start()
//----------------------------------------------------------------------------------------------------
function game_start(){
  previous_text = "";
	lblActionText.Text = "";	
  original_left_click_graphic = buttonLeftMouseClick.NormalGraphic;
  original_right_click_graphic = buttonRightMouseClick.NormalGraphic;
  ds_left_click_mouse = DynamicSprite.CreateFromExistingSprite(original_left_click_graphic, true);
  ds_right_click_mouse = DynamicSprite.CreateFromExistingSprite(original_right_click_graphic, true);
  buttonLeftMouseClick.NormalGraphic = ds_left_click_mouse.Graphic;
  buttonRightMouseClick.NormalGraphic = ds_right_click_mouse.Graphic;
}

 T  // new module header
#define GRAPHIC_ACT_LOOK 1586
#define GRAPHIC_ACT_TALK 1587
#define GRAPHIC_ACT_PICK 1588
#define GRAPHIC_ACT_INTERACT 1589
#define GRAPHIC_ACT_LOOK_TALK 1590
#define GRAPHIC_ACT_LOOK_PICK 1591
#define GRAPHIC_ACT_LOOK_INTERACT 1592
#define GRAPHIC_ACT_TALK_INTERACT 1593
#define GRAPHIC_ACT_TALK_PICK 1594
#define GRAPHIC_ACT_PICK_INTERACT 1595

struct actionBar
{
  import static void show();
  import static void hide();
  import static bool leftclick(String verb, String clicked_obj);
  import static bool rightclick(String verb, String clicked_obj);
}; ���0        ej��