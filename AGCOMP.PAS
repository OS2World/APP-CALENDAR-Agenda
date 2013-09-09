unit agcomp;  (* compromissos do dia *)

(*                    A G E N D A                 *)
(*                vers∆o 2.3.3  2001              *)
(*                       OS/2                     *)
(*            por Geraldo M. Fontes Jr.           *)
(*             gfontes@tropical.com.br            *)
(* Este programa pode ser livremente distribuido  *)
(* e modificado segundo os termos da licenáa GPL. *)     
{                              
Por fazer:
  - Comandos para avanáar ou retroceder um dia, ao toque de uma tecla (PGUP, PGDN)
}

interface
{$V-}
uses crt,
     dos,
     mylib,
     agtelas,
     agoutros;

procedure compromissos;
function algo_para_hoje : boolean;

implementation

const blank        = '__________________________________________________';
      codIncluir   = 1;
      codConsultar = 2;
      largura      = 50;

type linha  = record
                lin1,
                lin2,
                lin3,
                lin4,
                lin5       : string[largura];
                consultado,                   (* Reservados para *)
                futuro     : boolean;         (* expans∆o futura *)
              end;
     arqdat = file of linha;
     tabela = array[0..366] of word;       (* ÷ndice do arquivo de compromissos *)

var fd            : arqdat;

procedure readDia(var compDia : linha);

var lin,
    pos  : integer;
    px,
    py   : integer;

procedure readlin(var st : string; tam : byte);

var c     : char;
    x,
    y,
    fimst : integer;

procedure mostrastring;
var cont : byte;
begin
  gotoxy(x,y);
  write(st);
  for cont:=length(st) to fimst do
      write(chr(esp));
  gotoxy(x+pos-1,y);
end; (* mostrastring *)

procedure apagapalavra;
var espaco : boolean;
begin
  repeat
    espaco:=st[pos] = ' ';
    if pos = length(st)
       then delete(st,pos,1);
    if pos < length(st)
       then delete(st,pos,1);
  until ((st[pos] <> ' ') and espaco) or (pos = succ(length(st)));
end; (* apagapalavra *)

procedure controle(var tecla : char);
begin
     if tecla = null
        then tecla:= readkey;
     case tecla of
          home        : pos:=1;
          fim         : pos:=length(st)+1;
          esquerda    : if pos > 1
                          then dec(pos);
          direita     : if pos <= length(st)
                          then inc(pos);
          bs          : if pos > 1 then
                        begin
                          delete(st,pos-1,1);
                          dec(pos)
                        end;
          del         : if pos <= length(st)
                          then delete(st,pos,1);
          acima,s_tab : if lin > 1 then
                        begin
                          dec(lin);
                          dec(py);
                        end; (* if *)
          abaixo,tab  : if lin < 5 then
                        begin
                          inc(lin);
                          inc(py);
                        end; (* abaixo *)
          ^T          : apagapalavra;
          mylib.esc   : st:='';
     end; (* case *)
end; (* controle *)

begin
     fimst:=tam-1;
     if pos >length(st) +1 then
       pos:= length(st) +1;
     x:=wherex;
     y:=wherey;
     repeat
       mostrastring;
       c:=readkey;
       if c in [null,bs,tab,s_tab,mylib.esc,^T,mylib.enter] then
         controle(c)
       else
       begin
         if length(st) < tam then
         begin
           insert(c,st,pos);
           inc(pos);
         end
         else beep 
       end; (* if c *)
     until c in [mylib.esc,mylib.enter, abaixo, acima, tab, s_tab];
     if c in [tab,s_tab,mylib.esc] then
       pos:= 1;                   
     if c = mylib.enter then
       lin:= 6; (* encerrar a ediá∆o *)
end; (* readlin *)

begin
  lin:= 1;
  pos:= 1;
  px:= wherex;
  py:= wherey;
  repeat
    gotoxy(px,py);
    case lin of
      1 : readlin(compDia.lin1,largura);
      2 : readlin(compDia.lin2,largura);
      3 : readlin(compDia.lin3,largura);
      4 : readlin(compDia.lin4,largura);
      5 : readlin(compDia.lin5,largura);
    end; (* case *)
  until lin > 5;
end; (* readDia *)

function diajul(d,m,a : word) : word;

var t,
    q  : integer;

begin
  case m of
    1,2   : t:=0;
    3,4   : t:=-3;
    5,6   : t:=-4;
    7,8,9 : t:=-5;
    10,11 : t:=-6;
    12    : t:=-7;
  end; (* case *)
  q:=(m-1) * 31 + d + t;
  if ((a mod 4) = 0) and (m>=3) then
    q:=q+1;
  diajul:=q;
end; (* diajul *)

procedure letabela(var arq : arqdat;var tab : tabela; var ret : integer);

(* As 3 primeiras posiá‰es do arquivo de compromissos s∆o utilizados *)
(* como °ndice para todo o arquivo, de forma semelhante Ö FAT do DOS *)
(* Aqui se faz a leitura do arquivo de forma a preencher a tabela em *)
(* mem¢ria, que faz as vezes de °ndice do arquivo.                   *)

var  dat         : linha;
     tab_byteptr : array[1..734] of byte absolute tab;
     posic_tab,
     contador    : integer;
{$I-}
function leitura : integer;
begin
  read(arq,dat);
  leitura:= ioresult;
  move(dat,tab_byteptr[posic_tab],sizeof(dat));
  posic_tab:= posic_tab + sizeof(dat);
end; (* leitura *)

begin
  seek(arq,0);
  ret:= ioresult;
  if ret <> 0 then
    exit;
  posic_tab:= 1; (* posiá∆o inicial de tab *)
  for contador:= 1 to 3 do
  begin
    ret:= leitura;
    if ret <> 0 then
      exit;
  end;
end; (* letabela *) {$I+}

procedure compromissos;

var opcao         : integer;
    pontarq       : word;
    erro          : integer;
    dat           : linha;
    tab           : tabela;
    ano,
    anocorrente,
    mes,
    dia,
    dia_da_semana : word;
    proximo       : word absolute tab; (* pr¢ximo = tab[0] *)
    nomearq       : string[12];
    arquivoAberto : boolean;

procedure gravatabela(var ret : integer);

(* Grava a tabela-indice no inicio do arquivo de compromissos *)

var tab_byteptr : array[1..734] of byte absolute tab;
    posic_tab,
    cont        : integer;

begin {$I-}
  posic_tab:= 1;
  seek(fd,0);
  for cont:= 1 to 3 do
  begin
    fillchar(dat,sizeof(dat),0);
    move(tab_byteptr[posic_tab],dat,sizeof(dat));
    posic_tab:= posic_tab + sizeof(dat);
    write(fd,dat);
    ret:= ioresult;
    if ret <> 0 then exit;
  end; (* for *)
end; (* gravatabela *) {$I+}
  
function abrearq(ano : word; codOpcao : integer) : integer;

var erro : integer;

begin {$I-}
  str(ano,nomearq);
  nomearq:=concat(nomearq,'.dat');
  assign(fd,nomearq);
  reset(fd);
  erro:= ioresult;
  if codOpcao = codIncluir then (* Incluir dados *)
  begin
    if (erro = 2) then
    begin              (* arquivo n∆o existe ainda *)
      rewrite(fd);
      erro:=ioresult;
      if erro = 0 then
      begin
        fillchar(tab,sizeof(tab),0);
        gravatabela(erro);
        proximo:= 3;
      end;
    end
    else
      letabela(fd,tab,erro); (* arquivo j† existente *)
  end
  else  (* Consulta ao banco de dados *)
    if erro = 0 then
      letabela(fd,tab,erro); (* arquivo existe *)
  arquivoAberto:= true;
  abrearq:= erro; (* Zero indica OK *)
end; (* abrearq *) {$I+}

function fecharq : integer;

var erro : integer;

begin
  gravatabela(erro);
  if erro <> 0 then
    exit;             {$I-}
  close(fd);          {$I+}
  erro:= ioresult;
  arquivoAberto:= false;
  fecharq:= erro;
end; (* fecharq *)

procedure learq(var retorno : integer);

begin                           {$I-}
  read(fd,dat);                 {$I+}
  retorno:=ioresult;
  if retorno = 0 then
    with dat do
    begin
      textbackground(red);
      gotoxy(19,13);write(lin1);
      gotoxy(19,14);write(lin2);
      gotoxy(19,15);write(lin3);
      gotoxy(19,16);write(lin4);
      gotoxy(19,17);write(lin5);
    end;
end; (* learq *)

procedure escrevarq(var retorno : integer);
begin  
  gotoxy(19,13);
  readDia(dat);  {$I-}
  write(fd,dat); {$I+}
  retorno:=ioresult;
end; (* escrevarq *)

function escolhearq(var anocorrente,ano : word; opcao : integer) : integer;

var retorno : integer;

begin
  retorno:= 0;
  if arquivoAberto then
  begin
    if ano <> anocorrente then
    begin
      anocorrente:=ano;
      if fecharq = 0 then
        retorno:= abrearq(anocorrente,opcao);
    end; (* if ano <> anocorrente *)
  end (* arquivoAberto *)
  else
    retorno:= abrearq(anocorrente,opcao);
  escolheArq:= retorno;
end; (* escolhearq *)

procedure posiciona(p : integer; var retorno : integer);
begin
  if retorno = 0 then
  begin                    {$I-}
    seek(fd,p);            {$I+}
    retorno:=ioresult;
  end;
end; (* posiciona *)

procedure limpa_dat;
begin
  fillchar(dat,sizeof(dat),0);
end; (* limpa_dat *)

function incluir : integer;
 (* Retorna o status da inclus∆o. Um valor O indica sucesso *)

var ano,
    mes,
    dia  : word;
    mais : boolean;
    erro : integer;

begin
  erro:=0;
  mais:=true;
  textcolor(yellow);
  textbackground(black);
  clrscr;
  write('AGENDA',' ':66,'Inclus∆o');
  textcolor(white);
  repeat
    entracom;
    textbackground(red);
    gotoxy(58,12);
    ledata(ano,mes,dia);
    erro:= escolhearq(anocorrente,ano,codIncluir);
    pontarq:= tab[diajul(dia,mes,ano)];
    if pontarq = 0 then  (* se n∆o existe registro para esta data *)
    begin
      pontarq:= proximo;
      tab[diajul(dia,mes,ano)]:= proximo;
      inc(proximo);
      limpa_dat;
      posiciona(pontarq,erro);
      if erro = 0 then
        escrevarq(erro);
    end
    else  (* o arquivo existe *)
    begin
      posiciona(pontarq,erro);
      if erro = 0 then
        learq(erro);
      if erro = 0 then
      begin
        posiciona(pontarq,erro);
        escrevarq(erro);
      end;
    end;
    if erro = 0 then
    begin
      textbackground(black);
      gotoxy(38,24);
      write('Mais (s/n)?  ',bs);
      mais:=sn;
      gotoxy(38,24);
      clreol;
    end;
  until not(mais) or (erro <> 0);
  textbackground(black);
  clrscr;
  incluir:= erro;
end; (* incluir *)

function consulta : integer;

var mais : boolean;

begin
  erro:=0;
  textcolor(yellow);
  textbackground(black);
  clrscr;
  write('AGENDA',' ':66,'Consulta');
  textcolor(white);
  repeat
    entracom;
    textbackground(red);
    gotoxy(58,12);
    ledata(ano,mes,dia);
    erro:= escolhearq(anocorrente,ano,codConsultar);
    pontarq:= tab[diajul(dia,mes,ano)];
    if (pontarq <> 0) and (erro = 0) then
    begin
      posiciona(pontarq,erro);
      if erro = 0 then
        learq(erro);
    end;
    if erro = 0 then
    begin
      textbackground(black);
      gotoxy(38,24);
      write('Mais (s/n)?  ',bs);
      mais:= sn;
      gotoxy(38,24);
      clreol;
    end;
  until not(mais) or (erro <> 0);
  textbackground(black);
  clrscr;
  consulta:= erro;
end; (* consulta *)

procedure mostraopcao2(opcao : integer);
begin
  comprom;
  gotoxy(28,12+opcao);
  textbackground(red);
  textcolor(white);
  case opcao of
    1 : write('* incluir dados             ');
    2 : write('* consulta ao banco de dados');
    3 : write('* retorno ao menu geral     ');
  end;
  nocursor;
end; (* mostraopcao2 *)

procedure seleciona(var opcao : integer);

const ultima = 3;
      esp    = 32;

var tecla    : integer;

begin
  mostraopcao2(opcao);
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
      esc           : opcao:=3;
    end; (* case tecla *)
    mostraopcao2(opcao)
  until (tecla=enter) or ((tecla>=f1) and (tecla<=f2)) or (tecla=esc);
end; (* seleciona *)

procedure submenu2;

var retorna : boolean;

begin
  arquivoAberto:= false; (* Nenhum arquivo de compromissos aberto *)
  retorna:=false;
  opcao:=1;
  repeat
    getdate(anocorrente,mes,dia,dia_da_semana);
    seleciona(opcao);
    case opcao of
      1 : if incluir = 0 then
            verificaErro(fecharq);
      2 : if consulta = 0 then
            verificaErro(fecharq);
      3 : retorna:=true;
    end; (* case *)
  until retorna;
end; (* submenu2 *)

begin
  submenu2;
end; (* compromissos *)

function algo_para_hoje : boolean;

var a,
    m,
    d,
    ds      : word;
    nomearq : string[12];
    dat     : linha;
    pont,
    erro    : integer;
    tab     : tabela;

procedure mostrahoje;

var tec : char;

begin
  clrscr;
  entracom;
  textcolor(yellow);
  textbackground(black);
  gotoxy(1,1);
  write('AGENDA',' ':70,'Hoje');
  textcolor(white);
  textbackground(red);
  gotoxy(58,12);
  write(d:2,'/',m:2,'/',a:4);
  with dat do
  begin
    gotoxy(19,13);write(lin1);
    gotoxy(19,14);write(lin2);
    gotoxy(19,15);write(lin3);
    gotoxy(19,16);write(lin4);
    gotoxy(19,17);write(lin5);
  end;
  gotoxy(30,24);
  textbackground(black);
  textcolor(blink+white);
  write('Pressione qualquer tecla');
  nocursor;
  tec:=readkey;
  textcolor(white);
  textbackground(black);
  clrscr;
end; (* mostrahoje *)

begin
     getdate(a,m,d,ds);
     str(a,nomearq);
     nomearq:=concat(nomearq,'.dat');
     assign(fd,nomearq);                        {$I-}
     reset(fd);                                 {$I+}
     erro:= ioresult;
     if erro <> 2 then
     begin
       letabela(fd,tab,erro);
       pont:=tab[diajul(d,m,a)];
       if (erro <> 0) or (pont = 0) then
       begin
         algo_para_hoje:= false;
         exit;
       end;                                   {$I-}
       seek(fd,pont);
       erro:=ioresult;
       if erro <> 0 then
       begin
         algo_para_hoje:= false;
         exit;
       end;
       read(fd,dat);                          {$I+}
       erro:=ioresult;
       close(fd);
       if verificaerro(erro) then
         halt;
       with dat do
       if not(((lin1=blank) or (lin1='')) and ((lin2=blank) or (lin2=''))
          and ((lin3=blank) or (lin3='')) and ((lin4=blank) or (lin4=''))
          and ((lin5=blank) or (lin5=''))) then
          begin
           { senha; }
            apresentacao;
            mostrahoje;
            algo_para_hoje:=true;
          end
       else
         algo_para_hoje:=false;
     end
     else
       algo_para_hoje:=false;
end; (* algo_para_hoje *)


end. (* agcomp *)
