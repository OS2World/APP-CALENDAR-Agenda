unit agendtel;  (* endereáos & telefones *)

(*                    A G E N D A                 *)
(*                vers∆o 2.3.3  2001              *)
(*                       OS/2                     *)
(*            por Geraldo M. Fontes Jr.           *)
(*             gfontes@tropical.com.br            *)
(* Este programa pode ser livremente distribuido  *)
(* e modificado segundo os termos da licenáa GPL. *)

interface
{$V-}
uses crt,
     mylib,
     agtelas,
     agoutros;

procedure endtel;

implementation

procedure endtel;
          
const nada = '______________________________';   
      vago = '*_____________________________';

type matnome  = string[30];
     endereco = record
                  fone   : string[10];
                  nome   : matnome;
                  rua    : string[40];
                  num,
                  cep    : string[8];
                  bairro : string[20];
                  cidade : string[25];
                  estado : string[2];
                end;
     arqend   = file of endereco;
     ordemTab = (nome,fone,rua,num,bairro,cidade,estado,cep);

var opcao    : byte;
    erro     : integer;
    fe       : arqend;
    endtelef : endereco;
    nom      : matnome;
    telef    : string[10];


procedure  procura(alt : boolean; var achei : boolean; var erro : integer);

var flag    : boolean;
    foneAux : string[10];

begin {$I-}
  seek(fe,0);
  erro:=ioresult;
  if erro = 0 then
  begin
    flag:= alt and (endtelef.nome = vago);
    achei:=false;         (* inicializaá‰es para *)
    endtelef.nome:= '';     (* loop de procura *)
    while (not eof(fe)) and (not(achei)) and (not flag) do
    begin
      read(fe,endtelef);
      foneAux:= extraiBrancos(endtelef.fone) + nada;
      flag:= alt and (endtelef.nome = vago);
      erro:=ioresult;
      if erro = 0 then
        with endtelef do
          achei:= (nome = nom) or ((fone <> '') and (telef = foneAux));
    end; (* while *)
    if endtelef.nome = vago then   (* reposiciona ponteiro de arquivo *)
      seek(fe,filepos(fe) - 1);        (* se registro foi apagado *)
    erro:= ioresult;
    if achei and (erro = 0) then
      with endtelef do
      begin           
        gotoxy(23,13);write(nome);
        gotoxy(59,13);write('__________'); (* limpeza para garantir n∆o haver lixo *)
        gotoxy(59,13);write(fone);
        gotoxy(28,14);write(rua);
        gotoxy(26,15);write(num);
        gotoxy(49,15);write(bairro);
        gotoxy(26,16);write(cidade);
        gotoxy(67,16);write(estado);
        gotoxy(26,17);write(copy(cep,1,5),'-',copy(cep,6,3));
      end; (* with *)
  end
end; (* procura *) {$I+}

procedure pesquisa;

var  achou,
     mais       : boolean; 
     
procedure parametrosConsulta(var nome,telefone : string);

var teclaSaida : char;
    lerNome    : boolean; 

begin
  lerNome:= true;
  repeat       
    if lerNome then     
    begin       
      gotoxy(23,13);
      if telefone = '' then teclaSaida:= editStr(nome,30);
    end
    else
    begin
      gotoxy(59,13);
      if nome = '' then teclaSaida:= editStr(telefone,10);
    end;
    lerNome:= not lerNome;
  until teclaSaida = mylib.enter;
  nome:= copy((nome + nada),1,30);
  maiusc(nome);
  telefone:= extraiBrancos(telefone);
  telefone:=copy((telefone + nada),1,10);
end; (* parametrosConsulta *)

begin
  textbackground(black);
  clrscr;
  textcolor(yellow);
  textbackground(black);
  write('AGENDA',' ':66,'Pesquisa');
  repeat
    entratel;      {$I-}
    reset(fe);     {$I+}
    erro:=ioresult;
    if erro = 0 then
    begin
      textbackground(blue);
      textcolor(white);
      nom:='';
      telef:=''; 
      parametrosConsulta(nom,telef);   
      procura(false,achou,erro);
      if not(achou) and (erro = 0) then
      begin
        gotoxy(29,22);
        textcolor(white);
        textbackground(black);
        write('Nome/telefone n∆o encontrado');
      end;
      if erro = 0 then
      begin
        textcolor(white);
        textbackground(black);
        gotoxy(38,24);
        write('Mais (s/n)?');
        mais:=sn;
        gotoxy(29,22);
        clreol;
        gotoxy(38,24);
        clreol;
      end
    end;
  until (not(mais)) or (erro <> 0);
  clrscr;
end; (* pesquisa *)    

procedure editaTela(var dados : endereco;nomeTambem : boolean);

var teclaSaida : char;
    campo      : ordemTab;

begin
  if nomeTambem then
    campo:= nome
  else
    campo:= fone;
  repeat                         
    case campo of
      nome   : begin
                 gotoxy(23,13);
                 teclaSaida:= editStr(dados.Nome,30);
                 dados.nome:= dados.nome + nada;
                 maiusc(dados.nome);
               end;      
      fone   : begin
                 gotoxy(59,13);
                 teclaSaida:= editStr(dados.fone,10);
               end;
      rua    : begin
                 gotoxy(28,14);
                 teclaSaida:= editStr(dados.rua,40);
               end;
      num    : begin
                 gotoxy(26,15);
                 teclaSaida:= editStr(dados.num,5);
               end;
      bairro : begin
                 gotoxy(49,15);
                 teclaSaida:= editStr(dados.bairro,20);
               end;
      cidade : begin
                 gotoxy(26,16);
                 teclaSaida:= editStr(dados.cidade,25);
               end;
      estado : begin
                 gotoxy(67,16);
                 teclaSaida:= editStr(dados.estado,2);
                 maiusc(dados.estado);
               end; 
      cep    : begin  
                 gotoxy(26,17);
                 write('_________');
                 gotoxy(26,17);       
                 teclaSaida:= editStr(dados.cep,8);
               end;
    end; (* case campo *)
    case teclaSaida of
      tab   : if campo < cep
                then inc(campo)
                else campo:= nome;
      s_tab : if campo > nome
                then dec(campo)
                else campo:= cep;
    end; (* case teclaSaida *) 
  until (teclaSaida = mylib.enter) or ((teclaSaida = mylib.esc) and (campo = nome));
end; (* editaTela *)

procedure altera;

var altera,
    mais,
    achou   : boolean;
    arqpos  : integer;
    cod     : char;

function excluir : boolean;
begin
  textbackground(black);
  gotoxy(31,24);
  write('Excluir registro (s/n)? ',bs);
  excluir:= sn;
  gotoxy(31,24);
  clreol;
end; (* excluir *)

function entra : boolean; 
  (* Retorna false se n∆o desejar excluir um registro *)
begin
  entra:= true;
  endtelef.nome:= nom;
  procura(true,achou,erro);
  if erro <> 0 then
    exit;
  if not(achou) then
    arqpos:=filepos(fe)
  else
  begin
    gotoxy(25,24);
    textbackground(black);
    write('Deseja alterar registro (s/n)?');
    altera:=sn;
    gotoxy(25,24);
    clreol;
    arqpos:=filepos(fe)-1;
  end;
  if altera then
  begin  
    if not achou then   (* Registro novo? *)
      with endtelef do
      begin
        nome:='';
        fone:='';
        rua:='';
        num:='';
        bairro:='';
        cidade:='';
        estado:='';
        cep:='';
      end; (* with *) 
    textbackground(blue);
    endtelef.nome:= nom;
    editaTela(endtelef,achou);
  end;   
  if (endtelef.nome = nada) then
    if excluir then
      endtelef.nome:= vago
    else
      entra:= false;
end; (* entra *)

begin
  erro:=0;
  mais:=true;
  textbackground(black);
  clrscr;
  textcolor(yellow);
  textbackground(black);
  write('AGENDA',' ':65,'Alteraá∆o');
  repeat    
    telef:='';
    altera:=true;
    textbackground(black);
    entratel;
    textcolor(white);
    textbackground(blue);
    nom:= '';
    repeat
     gotoxy(23,13);
     cod:= editStr(nom,30);
    until (cod in [mylib.enter,mylib.esc]) or ((cod = tab) and (nom <> ''));
    nom:= copy((nom + nada),1,30);  
    maiusc(nom);
    if nom <> nada then
    begin
      if entra then
      begin                          {$I-}
        seek(fe,arqpos);
        erro:=ioresult;
        if erro = 0 then
          write(fe,endtelef);
        erro:= ioresult              {$I+}
      end (* if entra *)
    end
    else
    begin
      textbackground(black);
      gotoxy(30,24);
      delline;
      write('Retorna ao menu (s/n)?');
      mais:=not sn;
      gotoxy(30,24);
      clreol;
    end;
  until (not mais) or (erro <> 0);
  clrscr;
end; (* altera *)

procedure consulta;

var tec : byte;
    x   : integer;

begin
  tec:= 0;                  {$I-}
  seek(fe,0);               {$I+}
  erro:= ioresult;
  if erro <> 0 then
    exit;
  if eof(fe) then
  begin
    textcolor(white);
    textbackground(black);
    gotoxy(23,23);
    write('Nenhum nome no arquivo.');
    textcolor(blink+white);
    write(' Pressione ESC');
    nocursor;
    waitesc;
    textcolor(white);
  end;
  while (not eof(fe)) and (tec <> ESC) do
  begin
    textcolor(yellow);
    textbackground(black);
    clrscr;
    gotoxy(1,1);
    write('AGENDA',' ':66,'Consulta');
    gotoxy(1,4);
    textcolor(white);
    x:= 4;
    while (x <= 22) and not eof(fe) do
      if not eof(fe) then
      begin                 {$I-}
        read(fe,endtelef);  {$I+}
        erro:=ioresult;
        if erro <> 0 then
          exit;
        if copy(endtelef.nome,1,1) <> '*'then
        begin
          textcolor(lightred);
          write(' ':10,'Nome: ');
          textcolor(white);
          write(endtelef.nome);
          textcolor(lightred);
          write(' ':10,'Fone: ');
          textcolor(white);
          writeln(endtelef.fone);
          inc(x);
        end;
      end;
    gotoxy(25,24);
    writeln('Pressione : ENTER p/ continuar');
    write(' ':36,'ESC p/ retornar');
    nocursor;
    repeat
      tec:=ord(readkey)
    until tec in [ENTER,ESC];
  end; (* while *)
  clrscr;
end; (* consulta *)

procedure mostraopcao1(opcao : integer);
begin
  endtele;
  gotoxy(28,11+opcao);
  textbackground(blue);
  textcolor(white);
  case opcao of
    1 : write('* altera um nome        ');
    2 : write('* pesquisa um nome      ');
    3 : write('* consulta geral        ');
    4 : write('* retorno ao menu geral ');
  end;
  nocursor;
end; (* mostraopcao *)

procedure seleciona(var opcao : byte);

const ultima = 4;
      esp    = 32;

var tecla    : integer;

begin
  mostraopcao1(opcao);
  repeat
    tecla:=key;
    case tecla of
      setacima      : begin
                        dec(opcao);
                        if opcao < 1 then
                          opcao:=ultima;
                      end;
      setabaixo,esp : begin
                        inc(opcao);
                        if opcao > ultima then
                          opcao:=1;
                       end;
      f1            : opcao:=1;
      f2            : opcao:=2;
      f3            : opcao:=3;
      esc           : opcao:=4;
    end; (* case tecla *)
    mostraopcao1(opcao)
  until tecla in [enter,f1..f3,esc];
end; (* seleciona *)

procedure submenu1;

var retorna : boolean;

begin {$I-}
  retorna:=false;
  opcao:=1;
  textbackground(black);
  clrscr;
  repeat
    seleciona(opcao);
    reset(fe);
    erro:= ioresult;
    if erro = 0 then
      case opcao of
        1 : altera;
        2 : pesquisa;
        3 : consulta;
        4 : retorna:=true;
      end; (* case *)
    if erro = 0 then
    begin
      close(fe);
      erro:= ioresult;
    end;
  until retorna or verificaerro(erro);
end; (* submenu1 *) {$I-}

function abriu : byte;
begin {$I-}
  assign(fe,'endtel.ag');
  reset(fe);
  if ioresult = 2 then
    rewrite(fe);
  abriu:= ioresult;
end; (* abriu *) {$I+}

begin
  if not verificaerro(abriu) then
    submenu1;
end; (* endtel *)

end. (* agendtel *)
