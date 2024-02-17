draw_set_color(c_black);
draw_set_alpha(fadeTela);
draw_rectangle(0,0,display_get_gui_width(),display_get_gui_height(),false);

switch (estadoJogo) {
	case estadosJogo.emExecucao: {
		draw_set_valign(fa_top);
		var textoRetrato="";
		draw_set_alpha(1);
		if (ds_list_size(unidadesSelecionadas)==0) {
			textoRetrato="Clique em uma unidade para selecioná-la";
		} else if (ds_list_size(unidadesSelecionadas)==1) {
			textoRetrato=unidadesSelecionadas[|0].nomeUnidade;
			draw_sprite_ext(unidadesSelecionadas[|0].spriteRetrato,0,display_get_gui_width()-160,64,1,1,0,c_white,1);
			draw_set_color(c_red);
			draw_rectangle(display_get_gui_width()-304,144,display_get_gui_width()-176,160,false);
			draw_set_color(c_lime);
			draw_rectangle(display_get_gui_width()-304,144,display_get_gui_width()-304+((unidadesSelecionadas[|0].vida/unidadesSelecionadas[|0].vidaMax)*128),160,false);
			draw_set_font(fntGUImenor);
			draw_set_halign(fa_center);
			draw_text_fx(display_get_gui_width()-240,144,string(unidadesSelecionadas[|0].vida)+" / "+string(unidadesSelecionadas[|0].vidaMax));
			draw_set_halign(fa_right);
			draw_text_fx(display_get_gui_width()-176,64,unidadesSelecionadas[|0].localAtual);
			if (unidadesSelecionadas[|0].construtor) {
				draw_set_font(fntGUImenor);
				draw_set_halign(fa_left);
				for (var i = 0; i < ds_list_size(unidadesSelecionadas[|0].unidadesConstruir); i++) {
					draw_set_alpha(0.2);
					if (device_mouse_x_to_gui(0)>=display_get_gui_width()-256-8)
					&& (device_mouse_x_to_gui(0)<display_get_gui_width()) {
						if (device_mouse_y_to_gui(0)>=256-8+(i*80))
						&& (device_mouse_y_to_gui(0)<256+80-8+(i*80)) {
							draw_set_alpha(0.5);
							if (opcaoSelecionada!=i) {
								opcaoSelecionada=i;
								audio_play_sound(sfxMenuHover,0,false);
							}
						}
					} else {
						opcaoSelecionada=-1;
					}
					if (dinheiro[global.timeJogador]>=unidadesSelecionadas[|0].unidadesConstruir[|i].valor) {
						draw_set_color(c_lime);
					} else {
						draw_set_color(c_red);
					}
					draw_rectangle(display_get_gui_width()-256-8,256-8+(i*80),display_get_gui_width(),256+80-8+(i*80),false);
					draw_set_alpha(1);
					draw_sprite_ext(unidadesSelecionadas[|0].unidadesConstruir[|i].sprite,0,display_get_gui_width()-256,256+(i*80),0.5,0.5,0,c_white,1);
					draw_text_fx(display_get_gui_width()-256+80,256+(i*80),unidadesSelecionadas[|0].unidadesConstruir[|i].nome);
					draw_text_fx(display_get_gui_width()-256+80,256+32+(i*80),"$"+string(unidadesSelecionadas[|0].unidadesConstruir[|i].valor));
				}
			} else {
				opcaoSelecionada=-1;
			}
		} else {
			textoRetrato=string(ds_list_size(unidadesSelecionadas))+" unidades selecionadas";
			draw_sprite_ext(sprRetratoBatalhao,0,display_get_gui_width()-160,64,1,1,0,c_white,1);
		}
		draw_set_font(fntGUI);
		draw_set_halign(fa_right);
		draw_text_fx(display_get_gui_width()-32,16,textoRetrato);
		draw_set_halign(fa_left);
		draw_text_fx(32,16,"$"+string(dinheiro[global.timeJogador]));
		//draw_text_fx(32,48,"$"+string(dinheiro[1]));
	} break;
	case estadosJogo.emPausa: {
		draw_caixaGUI(128,display_get_gui_height()/3,"PAUSA\n\nDeseja retornar ao menu?\n\n ");
		draw_set_color(c_lime);
		if (device_mouse_y_to_gui(0)>=display_get_gui_height()-(display_get_gui_height()/3)-48-32)
		&& (device_mouse_y_to_gui(0)<display_get_gui_height()-(display_get_gui_height()/3)-48+32) {
			if (device_mouse_x_to_gui(0)>display_get_gui_width()/2-256)
			&& (device_mouse_x_to_gui(0)<display_get_gui_width()/2) {
				draw_set_alpha(0.2);
				if (mouse_check_button(mb_left)) {
					draw_set_alpha(0.5);
				}
				if (opcaoSelecionada!=0) {
					opcaoSelecionada=0;
					audio_play_sound(sfxMenuHover,0,false);
				}
				if (mouse_check_button_pressed(mb_left)) {
					audio_play_sound(sfxMenuClick,0,false);
				}
				draw_rectangle(display_get_gui_width()/2-256,display_get_gui_height()-(display_get_gui_height()/3)-48-32,display_get_gui_width()/2,display_get_gui_height()-(display_get_gui_height()/3)-48+32,false);
			} else if (device_mouse_x_to_gui(0)>display_get_gui_width()/2)
			&& (device_mouse_x_to_gui(0)<display_get_gui_width()/2+256) {
				draw_set_alpha(0.2);
				if (mouse_check_button(mb_left)) {
					draw_set_alpha(0.5);
				}
				if (opcaoSelecionada!=1) {
					opcaoSelecionada=1;
					audio_play_sound(sfxMenuHover,0,false);
				}
				if (mouse_check_button_pressed(mb_left)) {
					audio_play_sound(sfxMenuClick,0,false);
				}
				draw_rectangle(display_get_gui_width()/2,display_get_gui_height()-(display_get_gui_height()/3)-48-32,display_get_gui_width()/2+256,display_get_gui_height()-(display_get_gui_height()/3)-48+32,false);
			} else {
				opcaoSelecionada=-1;
			}
		} else {
			opcaoSelecionada=-1;
		}
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_alpha(1);
		draw_text_fx(display_get_gui_width()/2-128,display_get_gui_height()-(display_get_gui_height()/3)-48,"Não");
		draw_text_fx(display_get_gui_width()/2+128,display_get_gui_height()-(display_get_gui_height()/3)-48,"Sim");
	} break;
	case estadosJogo.vitoria: {
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_sprite(sprVitoria,0,display_get_gui_width()/2,display_get_gui_height()/2);
	} break;
	case estadosJogo.derrota: {
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_sprite(sprDerrota,0,display_get_gui_width()/2,display_get_gui_height()/2);
	} break;
}