if (time==global.timeJogador) {
	if (mouse_check_button_released(mb_left)) {
		if (mouseUpUnidade(mb_left,self)) {
			selecionado=true;
			ctrlFase.atualizarUnidadesSelecionadas(self);
			audio_play_sound(somAlerta,0,false);
		} else {
			if (selecionado) && (!mouseConstrutor) {
				selecionado=false;
				ctrlFase.atualizarUnidadesSelecionadas(self);
			}
			if (emSelecaoCaixa) {
				selecionado=true;
				ctrlFase.atualizarUnidadesSelecionadas(self);
				audio_play_sound(somAlerta,0,false);
			}
		}
	}
	if (selecionado) {
		if (mouse_check_button_pressed(mb_right)) {
			pontoDestinoMover.definir(mouse_x,mouse_y);
			autoMover=false;
			pontoAutoMoverFallBack.definido0=false;
			audio_play_sound(somComando,0,false);
		}
	}
	if (emSelecaoCaixa) {
		emSelecaoCaixa=false;
	}
}

#region Detecção de mapa semântico
if (round((x-16)/32)!=tilemapPos.x)
|| (round((y-16)/32)!=tilemapPos.y) {
	tilemapPos.definir(tilemap_get_cell_x_at_pixel(ctrlFase.tilemapSemantico,x,y),tilemap_get_cell_y_at_pixel(ctrlFase.tilemapSemantico,x,y));
	tilemapIndice=tilemap_get(ctrlFase.tilemapSemantico,tilemapPos.x,tilemapPos.y);
	if (selecionado) {
		//show_debug_message(tilemapIndice);
	}
	var contextos=identificarContexto(tilemapIndice);
	localAtual=contextos[2];
	if (contextos[0]!=contextosTileset.nada) {
		velocidadeAtual = velocidade * informacaoContexto(contextos[0])[0];
		defesaMultiplicador = informacaoContexto(contextos[0])[1];
		if (contextos[1]!=contextosTileset.nada) {
			velocidadeAtual = velocidade * ((informacaoContexto(contextos[0])[0] + informacaoContexto(contextos[1])[0]) / 2);
			defesaMultiplicador = ((informacaoContexto(contextos[0])[1] + informacaoContexto(contextos[1])[1]) / 2);
		}
	} else {
		velocidadeAtual = velocidade;
		defesaMultiplicador = 1;
	}
}
#endregion

#region Cálculo de movimento
if (formaMover==formaComandos.agredir) && (!emMovimento) && (!emAtaque) {
	if (pontoAutoMoverFallBack.definido0) {
		other.pontoDestinoMover.definir(pontoAutoMoverFallBack.x,pontoAutoMoverFallBack.y);
		pontoAutoMoverFallBack.definido0=false;
		other.autoMover=true;
	} else {
		with (parUnidade) {
			if (time!=other.time) {
				if (point_distance(x,y,other.x,other.y)<other.raioAlcance) {
					other.pontoDestinoMover.definir(x,y);
					other.autoMover=true;
				}
			}
		}
	}
}
if (pontoDestinoMover.x!=pontoMovimento.x)
|| (pontoDestinoMover.y!=pontoMovimento.y) {
	if (velocidade>0) {
		emMovimento=true;
	} else {
		emMovimento=false;
		pontoDestinoMover.definir(pontoMovimento.x,pontoMovimento.y);
	}
} else {
	emMovimento=false;
}
if (emMovimento) {
	direcaoAbs = point_direction(x,y,pontoDestinoMover.x,pontoDestinoMover.y);
	pontoMovimento.definir(x+lengthdir_x(velocidadeAtual,direcao),y+lengthdir_y(velocidadeAtual,direcao));
	var obstaculo = collision_circle(pontoMovimento.x,pontoMovimento.y,velocidadeAtual*3,parUnidade,true,true);
	if (obstaculo!=noone) {
		var pontoColisao = new Vector2(pontoMovimento.x,pontoMovimento.y);
		pontoColisao.x = obstaculo.x+lengthdir_x((obstaculo.sprite_width/2)+(sprite_width/2),point_direction(obstaculo.x,obstaculo.y,pontoMovimento.x,pontoMovimento.y));
		pontoColisao.y = obstaculo.y+lengthdir_y((obstaculo.sprite_height/2)+(sprite_height/2),point_direction(obstaculo.x,obstaculo.y,pontoMovimento.x,pontoMovimento.y));
		pontoMovimento.definir(pontoColisao.x,pontoColisao.y);
	}
	if (abs(pontoDestinoMover.x - pontoMovimento.x)<velocidadeAtual*3)
	&& (abs(pontoDestinoMover.y - pontoMovimento.y)<velocidadeAtual*3) {
		pontoDestinoMover.definir(pontoMovimento.x,pontoMovimento.y);
	}
}
direcaoVar = direcaoAbs - direcao;
if (direcaoVar >= 180) {
	direcao += 360;
	direcaoVar = direcaoAbs - direcao;
} else if (direcaoVar < -180) {
	direcao -= 360;
	direcaoVar = direcaoAbs - direcao;
}
#endregion

#region Cálculo de ataque
if (emAtaque) {
	if (instance_exists(alvoAtirar)) {
		if (point_distance(x,y,alvoAtirar.x,alvoAtirar.y)<raioAlcance) {
			pontoDestinoAtirar.focar(alvoAtirar);
			direcaoAbsAtaque = point_direction(x,y,pontoDestinoAtirar.x,pontoDestinoAtirar.y);
			atirar();
		} else {
			emAtaque = false;
		}
	} else {
		emAtaque = false;
	}
} else {
	direcaoAbsAtaque = direcaoAbs;
	with (parUnidade) {
		if (time!=other.time) && (other.formaAtirar==formaComandos.agredir) {
			if (point_distance(x,y,other.x,other.y)<other.raioAlcance) {
				other.emAtaque=true;
				other.alvoAtirar=self;
			}
		}
	}
}
direcaoVarAtaque = direcaoAbsAtaque - direcaoAtaque;
if (direcaoVarAtaque >= 180) {
	direcaoAtaque += 360;
	direcaoVarAtaque = direcaoAbsAtaque - direcaoAtaque;
} else if (direcaoVarAtaque < -180) {
	direcaoAtaque -= 360;
	direcaoVarAtaque = direcaoAbsAtaque - direcaoAtaque;
}
if (ctrlFase.estadoJogo==estadosJogo.emExecucao) {
	if (frequenciaTiroAtual<frequenciaTiro) {
		frequenciaTiroAtual++;
	} else {
		frequenciaTiroAtual=frequenciaTiro;
	}
}
#endregion

#region Movimentar-se
if (ctrlFase.estadoJogo==estadosJogo.emExecucao) {
	direcao += clamp(direcaoVar,-velocidadeAtual*3,velocidadeAtual*3)/3;
	direcaoAtaque += clamp(direcaoVarAtaque,-velocidadeAtual*4,velocidadeAtual*4)/3;
	image_angle = direcao;
	x += (pontoMovimento.x - x)/3;
	y += (pontoMovimento.y - y)/3;
} else {
	if (time!=global.timeJogador) {
		alarm[0]++;
	}
	if (object_index==objBase) {
		alarm[1]++;
	}
}
#endregion

#region Menu de Construtor
mouseConstrutor=false;
if (selecionado) {
	if (device_mouse_x_to_gui(0)>=display_get_gui_width()-256-8)
	&& (device_mouse_x_to_gui(0)<display_get_gui_width()) {
		for (var i = 0; i < ds_list_size(unidadesConstruir); i++) {
			if (device_mouse_y_to_gui(0)>=256-8+(i*80))
			&& (device_mouse_y_to_gui(0)<256+80-8+(i*80)) {
				mouseConstrutor=true;
				if (device_mouse_check_button_pressed(0,mb_left)) {
					construirUnidade(unidadesConstruir[|i]);
					audio_play_sound(sfxMenuClick,0,false);
				}
			}
		}
	}
}
#endregion