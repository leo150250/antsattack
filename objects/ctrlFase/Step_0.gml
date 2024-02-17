#region Controle e movimentação
if (mouse_check_button_pressed(mb_left)) {
	selecaoCaixa=true;
	selecaoP1.x=mouse_x;
	selecaoP1.y=mouse_y;
}
if (selecaoCaixa) {
	selecaoP2.x=mouse_x;
	selecaoP2.y=mouse_y;
	if (mouse_check_button_released(mb_left)) {
		selecaoCaixa=false;
		selecionarUnidadesCaixa(selecaoP1,selecaoP2);
	}
}
if (device_mouse_x_to_gui(0)<32) {
	x-=8;
}
if (device_mouse_x_to_gui(0)>display_get_gui_width()-32) {
	x+=8;
}
if (device_mouse_y_to_gui(0)<32) {
	y-=8;
}
if (device_mouse_y_to_gui(0)>display_get_gui_height()-32) {
	y+=8;
}
if (x<camera_get_view_width(view_camera[0])/2) {
	x=camera_get_view_width(view_camera[0])/2;
}
if (y<camera_get_view_height(view_camera[0])/2) {
	y=camera_get_view_height(view_camera[0])/2;
}
if (x>room_width-camera_get_view_width(view_camera[0])/2) {
	x=room_width-camera_get_view_width(view_camera[0])/2;
}
if (y>room_height-camera_get_view_height(view_camera[0])/2) {
	y=room_height-camera_get_view_height(view_camera[0])/2;
}
#endregion

#region Estado da fase
switch (estadoJogo) {
	case estadosJogo.emExecucao: {
		if (fadeTela>0) {
			fadeTela-=0.02;
		} else {
			fadeTela=0;
		}
		unidadesTimes=array_create(2,0);
		with (parUnidade) {
			other.unidadesTimes[time]++;
		}
		for (var i = 0; i<array_length(unidadesTimes); i++) {
			if (unidadesTimes[i]==0) {
				if (i==global.timeJogador) {
					estadoJogo=estadosJogo.derrota;
				} else {
					estadoJogo=estadosJogo.vitoria;
				}
			}
		}
		if (keyboard_check_pressed(vk_escape)) {
			estadoJogo=estadosJogo.emPausa;
		}
	} break;
	case estadosJogo.emPausa: {
		if (fadeTela>0) {
			fadeTela-=0.02;
		} else {
			fadeTela=0;
		}
		if (mouse_check_button_released(mb_left)) {
			if (opcaoSelecionada==0) {
				estadoJogo=estadosJogo.emExecucao;
			} else if (opcaoSelecionada==1) {
				room_goto(roomTitulo);
			}
		}
		if (keyboard_check_pressed(vk_escape)) {
			estadoJogo=estadosJogo.emExecucao;
		}
	} break;
	case estadosJogo.vitoria:
	case estadosJogo.derrota: {
		if (fadeTela<1) {
			fadeTela+=0.002;
		} else {
			room_goto(roomTitulo);
		}
	} break;
}
#endregion

#region Exibição semântica
if (keyboard_check_pressed(ord("S"))) {
	var layerFundo=layer_get_id("Background");
	layer_set_visible(layerFundo,!layer_get_visible(layerFundo));
}
#endregion