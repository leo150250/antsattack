verificarTamanhoJanela();
image_xscale += (focoXScale - image_xscale) / 25;
image_yscale += (focoYScale - image_yscale) / 50;
focoXScale+=-0.002+random(0.004);
focoYScale+=-0.002+random(0.004);


if (keyboard_check_pressed(vk_anykey))
|| (mouse_check_button_pressed(mb_any)) {
	if (estado == estadosMenu.pressioneBotao) {
		if (global.jaExibiuInforme) {
			estado = estadosMenu.menuPrincipal;
		} else {
			estado = estadosMenu.textoSPADE;
			global.jaExibiuInforme = true;
		}
	}
}

if (estado==estadosMenu.iniciarFase) {
	focoXScale+=focoXScale/10;
	focoYScale+=focoYScale/10;
	fadeTela+=0.01;
	if (fadeTela>1) {
		switch (estadoFaseSelecionada) {
			case 1: room_goto(roomFase01); break;
			case 2: room_goto(roomFase02); break;
			case 3: room_goto(roomFase03); break;
			case 4: room_goto(roomFase04); break;
		}
	}
} else {
	focoXScale=clamp(focoXScale,0.4,0.6);
	focoYScale=clamp(focoYScale,0.4,0.6);
	if (estado==estadosMenu.opcoes) {
		
	}
}