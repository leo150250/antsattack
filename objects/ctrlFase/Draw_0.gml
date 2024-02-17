criarSurfaceSemantica();
if (selecaoCaixa) {
	draw_set_color(c_lime);
	draw_set_alpha(1);
	draw_rectangle(selecaoP1.x,selecaoP1.y,selecaoP2.x,selecaoP2.y,true);
}