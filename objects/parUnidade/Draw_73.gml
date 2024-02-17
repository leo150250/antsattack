draw_set_alpha(1);
draw_set_color(c_red);
draw_rectangle(x-16,y-19,x+16,y-16,false);
draw_set_color(c_lime);
draw_rectangle(x-16,y-19,x-16+((vida/vidaMax)*32),y-16,false);