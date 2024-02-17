draw_self();
if (fxMuzzle>0) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprite_index,image_index,x,y,fxMuzzle*(image_xscale*5),fxMuzzle*(image_yscale*5),image_angle,image_blend,image_alpha/2);
	gpu_set_blendmode(bm_normal);
}