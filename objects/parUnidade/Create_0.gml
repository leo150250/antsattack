velocidadeAtual=velocidade
localAtual="Nada";
frequenciaTiroAtual=frequenciaTiro;
defesaMultiplicador=1;
selecionado=false;
emSelecaoCaixa=false;

direcao=0;
direcaoAbs=0;
direcaoVar=0;
emMovimento=false;
direcaoAtaque=0;
direcaoAbsAtaque=0;
direcaoVarAtaque=0;
emAtaque=false;

pontoMovimento=new Vector2(x,y);
pontoDestinoMover=new Vector2(x,y);
pontoDestinoAtirar=new Vector2(x,y);

vidaMax=vida;

autoMover=false;
pontoAutoMoverFallBack=new Vector2(x,y);

image_speed=0;


tilemapPos=new Vector2(tilemap_get_cell_x_at_pixel(ctrlFase.tilemapSemantico,x,y),tilemap_get_cell_x_at_pixel(ctrlFase.tilemapSemantico,x,y));
tilemapIndice=0;

function atirar() {
	if (frequenciaTiroAtual==frequenciaTiro) {
		var novoProjetil=instance_create_layer(x,y,layer,projetil,{time:time});
		//novoProjetil.time=time;
		var direcaoTiro=direcaoAtaque-dispersao+random(dispersao*2);
		novoProjetil.pontoDestinoTiro.definir(x+lengthdir_x(point_distance(x,y,pontoDestinoAtirar.x,pontoDestinoAtirar.y),direcaoTiro),y+lengthdir_y(point_distance(x,y,pontoDestinoAtirar.x,pontoDestinoAtirar.y),direcaoTiro));
		novoProjetil.image_angle=direcaoTiro;
		frequenciaTiroAtual=0;
	}
	if (autoMover) && (emMovimento) {
		autoMover=false;
		pontoAutoMoverFallBack.definir(pontoDestinoAtirar.x,pontoDestinoAtirar.y);
		pontoAutoMoverFallBack.definido0=true;
		pontoDestinoMover.definir(pontoMovimento.x,pontoMovimento.y);
	}
}

function danificar(argQuantidade,argProjetil=noone) {
	vida-=argQuantidade / defesaMultiplicador;
	if (vida<=0) {
		vida=0;
		selecionado=false;
		ctrlFase.atualizarUnidadesSelecionadas(self);
		instance_create_layer(x,y,layer,objFXUnidadeMorta);
		instance_destroy();
	}
	switch (formaMover) {
		case formaComandos.revidar:
		case formaComandos.agredir: {
			if (!emAtaque)
			&& (!emMovimento)
			&& (argProjetil!=noone) {
				pontoDestinoMover.definir(argProjetil.xstart,argProjetil.ystart);
				autoMover=true;
			}
		} break;
	}
}

unidadesConstruir=ds_list_create();
mouseConstrutor=false;
function incluirBotaoConstrutor(argSprite,argValor,argNome,argObjeto) {
	var novoBotao=new BotaoConstrutor(argSprite,argValor,argNome,argObjeto);
	ds_list_add(unidadesConstruir,novoBotao);
}

/**
 * Function Description
 * @param {BotaoConstrutor} argConstrutor Description
 */
function construirUnidade(argConstrutor) {
	if (ctrlFase.dinheiro[time]>=argConstrutor.valor) {
		var novaUnidade=instance_create_layer(x-1+random(2),y-1+random(2),layer,argConstrutor.objeto);
		novaUnidade.definirTime(time);
		var direcaoNovaUnidade = random(360);
		if (velocidade==0) {
			novaUnidade.pontoDestinoMover.definir(x+lengthdir_x(96,direcaoNovaUnidade),y+lengthdir_y(96,direcaoNovaUnidade));
		} else {
			pontoDestinoMover.definir(x+lengthdir_x(96,direcaoNovaUnidade),y+lengthdir_y(96,direcaoNovaUnidade));
		}
		ctrlFase.dinheiro[time]-=argConstrutor.valor;
		show_debug_message("UNIDADE CONSTRUÍDA ("+string(time)+"): "+argConstrutor.nome);
	}
}

function definirTime(argTime) {
	time=argTime;
	image_index=time;
	if (time!=global.timeJogador) {
		alarm[0]=60+random(600);
	} else {
		alarm[0]=0;
	}
}
definirTime(time);