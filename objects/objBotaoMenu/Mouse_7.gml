if (estadoBotao == 2) {
	estadoBotao = 1;
	if (acaoMenu!=estadosMenu.nenhum) {
		objTitulo.executarMenu(acaoMenu);
	}
	if (acaoBotao!=acoesMenu.nenhuma) {
		switch (acaoBotao) {
			case acoesMenu.sairJogo: game_end(); break;
			case acoesMenu.comoJogar_jogo: objTitulo.estadoComoJogar=0; break;
			case acoesMenu.comoJogar_unidades: objTitulo.estadoComoJogar=1; break;
			case acoesMenu.comoJogar_estrategia: objTitulo.estadoComoJogar=2; break;
			case acoesMenu.iniciar_fase01: objTitulo.estadoFaseSelecionada=1; break;
			case acoesMenu.iniciar_fase02: objTitulo.estadoFaseSelecionada=2; break;
			case acoesMenu.iniciar_fase03: objTitulo.estadoFaseSelecionada=3; break;
			case acoesMenu.iniciar_fase04: objTitulo.estadoFaseSelecionada=4; break;
			case acoesMenu.opcoes_telaCheia: window_set_fullscreen(!window_get_fullscreen()); break;
		}
	}
}