image_yscale=0;
image_xscale=10;
focoXScale=0.5;
focoYScale=0.5;
fadeTela=0;

estado=estadosMenu.pressioneBotao;
estadoComoJogar=0;
estadoFaseSelecionada=0;

function executarMenu(argMenu) {
	show_debug_message(argMenu);
	estado=argMenu;
}

verificarTamanhoJanela(true);

executarMusica(musUmbrellaPants);