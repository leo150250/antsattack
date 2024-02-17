selecaoP1=new Vector2(0,0);
selecaoP2=new Vector2(0,0);
selecaoCaixa=false;

unidadesSelecionadas = ds_list_create();
function atualizarUnidadesSelecionadas(argUnidade) {
	if (argUnidade.time==0) {
		unidade=ds_list_find_index(unidadesSelecionadas,argUnidade)
		if (unidade==-1) && (argUnidade.selecionado) {
			ds_list_add(unidadesSelecionadas,argUnidade);
		} else {
			if (!argUnidade.selecionado) {
				ds_list_delete(unidadesSelecionadas,unidade);
			}
		}
	}
}

dinheiro=array_create(2,300);
unidadesTimes=array_create(2,0);
estadoJogo=estadosJogo.emExecucao;
opcaoSelecionada=-1;

#region Surface semântica
tilemapSemantico = layer_tilemap_get_id("Tiles");
surfaceTilemapSemantico = surface_create(sprite_get_width(sprTilesetSemantico),sprite_get_height(sprTilesetSemantico));
tilesetX=sprite_get_width(sprTilesetSemantico)/32;
tilesetY=sprite_get_height(sprTilesetSemantico)/32;	
function criarSurfaceSemantica() {
	if (!surface_exists(surfaceTilemapSemantico)) {
		surfaceTilemapSemantico = surface_create(sprite_get_width(sprTilesetSemantico),sprite_get_height(sprTilesetSemantico));
	}
	surface_set_target(surfaceTilemapSemantico);
	draw_sprite(sprTilesetSemantico,0,0,0);
	surface_reset_target();
}
criarSurfaceSemantica();
#endregion

executarMusicaFase();
verificarTamanhoJanela(true);
fadeTela=1;