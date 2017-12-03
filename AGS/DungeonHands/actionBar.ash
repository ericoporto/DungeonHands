// new module header
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
};