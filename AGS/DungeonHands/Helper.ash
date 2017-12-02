
struct Rect
{
  int x;
  int y;
  int x2;
  int y2;
};

import void DrawFrame(this DrawingSurface*, int x1, int y1, int x2, int y2);

import bool IsObjectOverRect(int o_x, int o_y, int o_w, int o_h, int r_x, int r_y, int r_x2, int r_y2);
import bool IsPointOverRect(int x, int y, int r_x, int r_y, int r_x2, int r_y2);
import void SnapObjectToRect(int o_x, int o_y, int o_w, int o_h, int r_x, int r_y, int r_x2, int r_y2, bool center);
