//Apenas DEBUG
if (global.debug) {
	if (selecionado) {
		draw_surface(ctrlFase.surfaceTilemapSemantico,0,0);
		var pontoX=((tilemapIndice%ctrlFase.tilesetX)*32);
		var pontoY=(floor(tilemapIndice/ctrlFase.tilesetX)*32);
		draw_rectangle(pontoX,pontoY,pontoX+32,pontoY+32,true);
		draw_circle(pontoX+(x%32),pontoY+(y%32),2,false);
	}
}