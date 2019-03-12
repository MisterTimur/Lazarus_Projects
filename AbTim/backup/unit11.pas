unit Unit11;{$mode objfpc}{$H+}interface//https://gist.github.com/MisterTimur
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs;
type  TForm11 = class(TForm)
  private

  public

  end;

var Form11: TForm11;

implementation{$R *.lfm}



Uses SysUtils;
Const            // Константы
  LN=Chr(13)+Chr(10);

  TI_SLO=10;// Слово
  TI_CIF=20;// Цифра
  TI_ZNA=30;// Знаки
  TI_KAV=40;// Квычки


Type  TEl=Class  // ТИпы
  TXT:Ansistring;// Текс слова
  Zna:Ansistring;// Значение
  TIP:LongWord;  // ТИп элемента
  FUN:Boolean;   // Если этот элемент являетсья описанием Функции;
  Rod:Tel;// Родительский элемент
  BLO:Tel;// Первый элемент вложеного списка элементов
  NEX:Tel;// Следующий элемент
  PRE:Tel;// Предыдущий элемент
  Function  Lst:Tel;// Возвращает последний элемент из списка
  Function  Add(El:Tel):Tel;// Добавляет элемент в конец списка
  Function  Add(S:AnsiString;T:LongWord):Tel;// Создает и Добавляет элемент в конец списка
  Function  Del:Tel;// Создает и Добавляет элемент в конец списка

  procedure VlogitSc(S1,S2:Ansistring); // Вложение скобок
  Procedure VlogitPA;// Вложение параметров
  Procedure VlogitBl;// Вложкение Исполнительных блоков
  Procedure VlogitMa(S:Ansistring);// Вложение математических операций   '+-'

  Function  FinFun(N:Ansistring):Tel;// ПОиск функции или переменной

  Procedure Cle;// Очистка элемента
  Function  Cop(iRod,iPre:Tel):Tel;// Создает копию элемента
  Procedure TRuns;// Выполняет структуру
  Procedure TRun;// Выполняет 1 елемент
  Procedure RunFun;// Найти и выполнить пользовательскую функцию

  Procedure Op_Mat;
  Procedure Op_Let;
  Procedure Op_Sco;
  Procedure Op_WHI;
  Procedure Op_Con;

end;
Var             // Переменные
Pro:Ansistring; // Текст программы
PRG:Tel;        // Программа
// Функции для работы с элементом ----------------------------------------------
Function  Tel.Del:Tel;// Изятие элемента из списка
var
Pr,Ne:TEl;
Begin
Pr:=Pre;
Ne:=Nex;
If pr<>Nil Then Pr.Nex:=Ne;
If Ne<>Nil Then Ne.Pre:=Pr;
If (Rod<>Nil) and (Rod.Blo=Self) Then Rod.Blo:=Ne;
Nex:=Nil;
Pre:=Nil;
Rod:=Nil;
Del:=Self;
end;
Function  Tel.Lst:Tel;// Возвращает последний элемент из списка
Var
rez:Tel;
Begin
Rez:=Blo;
If REz<>Nil Then
While REz.Nex<>Nil do REz:=Rez.Nex;
Lst:=Rez;
end;
Function  Tel.Add(El:Tel):Tel;// Добавить существующий элемент в список
Begin
El.Del;// Изымаем элемент
El.Rod:=Self;// Указываем родителя
El.Pre:=Lst;// Указываем элементе предыдущий
if Lst<>Nil
Then Lst.NEX:=El // Присоеденяемс к посоледнему элементу вновь созданый
Else Blo:=El;    // Указываем себя как первый элемент в списке
Add:=El;
end;
Function  Tel.Add(S:AnsiString;T:LongWord):Tel;// Создает и Добавляет элемент в конец списка
Var
Rez:Tel;
begin
Rez:=nil;
If S<>'' then
begin
 Rez:=Tel.Create;
 Rez.TXT:=S;
 Rez.ZNA:=S;
 REz.Tip:=T;// Указываем тип прочитаного элемента
 add(Rez);  // Добавляем внось созданый элемент
end;
Add:=Rez;
end;
//------------------------------------------------------------------------------
Procedure Tel.VlogitSc(S1,S2:Ansistring);// Вложение скобок
var
Kon,   // Контенер Куда складываем элементы
Uka,   // Указатель на элемент
Ne:Tel;// Следующий элемент
begin
Kon:=Self;
Uka:=Blo;
While Uka<>Nil do
 begin
  NE:=UKA.Nex;// Запоминаем следующий элемент
  If  (Kon<>Self) and (Uka.Txt<>S2) then Kon.add(Uka);
  if   Uka.Txt=S1 Then Kon:=Uka;
  if   Uka.Txt=s2 Then begin Kon:=Kon.Rod;Uka.Del;end;
  Uka:=Ne;
 end;
end;
Procedure TEl.VlogitPA;// Вложкение параметров
var
UKA:Tel;
Begin
UKA:=Blo;
While UKA<>NIL do
begin
If (UKA.TIP=TI_SLO) THEN
If (UKA.NEX<>NIL) AND (UKA.NEX.TXT='(')
Then UKA.Add(UKA.NEX)
Else UKA.Add('(',TI_ZNA);
Uka.VlogitPA;
UKA:=UKA.NEX;
end;
end;
Procedure TEl.VlogitBl;// Вложкение Исполнительных блоков
var
UKA:Tel;
Begin
UKA:=Blo;
While UKA<>NIL do
begin
If (UKA.TIP=TI_SLO) THEN
If (UKA.NEX<>NIL) AND (UKA.NEX.TXT='{')
Then begin UKA.Add(UKA.NEX);if UKA.TXT<>'WHILE' Then UKA.FUN:=True; end
Else UKA.Add('(',TI_ZNA);
Uka.VlogitBl;
UKA:=UKA.NEX;
end;
end;
Procedure TEl.VlogitMa(S:Ansistring);// Вложение математических операций   '+-'
Var
Uka:Tel;
Begin
Uka:=Blo;
While UKA<>Nil do
Begin
if (Uka.pre<>nil) and (Uka.nex<>nil) and (POs(Uka.TXT,S)<>0) Then
   begin
   Uka.Add(UKA.Pre);
   Uka.Add(UKA.Nex);
   end;
UKA.VlogitMa(s);
Uka:=Uka.Nex;
end;

end;
//------------------------------------------------------------------------------
Procedure Tel.Cle;// Очистка элемента
var
L1,L2:Tel;
Begin
L2:=Blo;
While L2<>Nil do
   begin
   L1:=L2;
   L1.Cle;
   L2:=L1.Nex;
   L1.Free;
   end;
end;
Function  Tel.Cop(iRod,iPre:Tel):Tel;// Создает копию элемента
Var
Rez,Ne,Pr:Tel;
Begin
REz:=Tel.Create;
REz.TXT:=Txt;
REz.Zna:=Zna;
REz.Tip:=Tip;
Rez.Fun:=Fun;

REz.Rod:=IRod;
REz.Pre:=IPre;
Rez.NEX:=Nil;
Rez.Blo:=Nil;

If Blo<>Nil  Then
begin
   Rez.Blo:=Blo.Cop(REz,Nil);
   Ne:=Blo.Nex;
   pr:=Rez.BLO;
   While NE<>Nil do
   begin
   Pr.Nex:=Ne.Cop(Rez,Pr);
   Ne:=Ne.Nex;
   Pr:=Pr.Nex;
   end;
end;
Cop:=Rez;
end;
Procedure TEl.TRuns;// Выполняет структуру
Var
Uka:Tel;
Begin
Uka:=Blo;
While UKA<>Nil do
Begin
 If (Not UKA.FUN)    or
    (Uka.Txt='WHILE')or
    (UKA.Txt='IF')   Then Uka.TRun;
Uka:=Uka.Nex;
end;
end;
Procedure Tel.TRun;// Выполняет 1 елемент
Begin
if Pos(Txt,'*/+-<>')<>0 Then Op_Mat else
if Txt='='              Then Op_Let else
if Txt='('              Then Op_Sco else
if Txt='{'              Then TRuns  else
if Txt='WHILE'          Then Op_WHI else
if Txt='PRINT'          Then Op_Con else
if Tip=Ti_Slo           Then RunFun;
end;
Function  Tel.FinFun(N:Ansistring):Tel;// ПОиск функции или переменной
var
l,REz:Tel;
Begin
REz:=Nil;
// Не нашли ли ?вдруг это и етсь искомый элемент
If Fun and (TXT=N) Then REz:=Self;
L:=Pre;// поиск переменой или функции в предыдыдущих элементах
While (REz=nil) and (L<>Nil) Do
begin
if (l.Tip=Ti_Slo) and
   (L.Fun)        and
   (L.Txt=N)      Then Rez:=L;

L:=L.Pre;
end;
// ПОиск переменной внутри параметров функции
If  (REz=Nil)         and
    (Rod<>Nil)        and
    (Rod.Fun)         And
    (Rod.Blo.Txt='(') And
    (Rod.Blo.Blo<>Nil)Then
    begin
    L:=Rod.Blo.Blo;
    While (L<>Nil) and (rez=nil)Do
    begin
     if L.TXT=N Then  REz:=L;
     L:=L.Nex;
    end;
    end;


// Посик Функции или переменой в родительском элементе
if (REz=Nil) and (Rod<>Nil) Then REz:=Rod.FinFun(n);
FinFun:=REz;
end;
Procedure Tel.RunFun;// Найти и выполнить пользовательскую функцию
var
F,Ru,l1,l2:Tel;
begin
F:=FinFun(Txt);
if F<>Nil Then
          begin
          Ru:=F.Cop(Rod,Pre);
          Blo.TRun;
          L1:=Ru.Blo.Blo;
          L2:=Blo.Blo;
          While (l1<>Nil) and (L2<>Nil) do
                Begin
                L1.Zna:=L2.Zna;
                L1:=L1.Nex;
                L2:=L2.Nex;
                end;
          Ru.Blo.Nex.TRun;
          Zna:=Ru.Zna;
          Ru.Cle;
          Ru.Free;
          end;
end;
//------------------------------------------------------------------------------
Function  EtoCif(s:Ansistring):boolean;
var
f:Longint;
rez:Boolean;
begin
rez:=true;

for f:=1 to Length(s) do
if (s[f]<'0') or (s[f]>'9')then begin rez:=false;break end;

If Length(s)=0 Then Rez:=False;
EtoCif:=REz;
end;
Procedure Tel.Op_Mat;
Begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;

 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna)
 Then
 if TXT='+' then zna:=FloatToStr(StrToFloat(Blo.zna)+StrToFloat(Blo.nex.zna)) else
 if TXT='-' then zna:=FloatToStr(StrToFloat(Blo.zna)-StrToFloat(Blo.nex.zna)) else
 if TXT='*' then zna:=FloatToStr(StrToFloat(Blo.zna)*StrToFloat(Blo.nex.zna)) else
 if TXT='/' then zna:=FloatToStr(StrToFloat(Blo.zna)/StrToFloat(Blo.nex.zna)) else
 if TXT='>' then begin if (StrToFloat(Blo.zna)>StrToFloat(Blo.nex.zna))            Then zna:='1'else zna:='0';end else
 if TXT='<' then begin if (StrToFloat(Blo.zna)<StrToFloat(Blo.nex.zna))            Then zna:='1'else zna:='0';end
 else
 if TXT='+' then zna:=Blo.zna+Blo.nex.zna else
 if TXT='=' then begin if Blo.zna=Blo.nex.zna  then zna:='1' else zna:='0' end else
 if TXT='>' then begin if Blo.zna>Blo.nex.zna then zna:='1' else zna:='0' end else
 if TXT='<' then begin if Blo.zna<Blo.nex.zna then zna:='1' else zna:='0' end;
end;
End;
Procedure Tel.Op_Let; // = Операция присваивания значения
Var
F:Tel;
begin
if (blo<>nil) and  (blo.nex<>nil) then
begin
Blo.nex.TRun;
F:=FinFun(Blo.TXT);
if F<>Nil Then F.Zna:=Blo.nex.Zna;
end;
end;
Procedure Tel.Op_Sco; // Выполняет скобку
var
l:TEl;
rez:Ansistring;
begin
rez:='';l:=Blo;
while l<>nil do
begin
l.TRun;
rez:=rez+l.zna;
l:=l.nex;
end;
zna:=rez;
end;
Procedure Tel.Op_WHI; // Оператор WHITE
var
F:Tel;
begin
if (blo<>nil) and  (blo.nex<>nil) then
begin
Blo.TRun;
While Blo.zna='1' do
begin
Blo.nex.TRun;
Blo.TRun;
end;
end;
end;
Procedure Tel.Op_Con; // Вывод в консоль
var
l:Tel;
Co:Ansistring;
begin
if Blo<>nil then
begin
l:=Blo.Blo;
while l<>nil do
begin
l.TRun;
Co:=Co+l.zna;
L:=l.nex;
end;
end;
Writeln(co);
end;
//------------------------------------------------------------------------------
Function  ReadProg(Name:Ansistring):AnsiString; // Функция чтения текстового файла в строку
var
  REz,Str:Ansistring;
  Tfi:TextFile;
begin
Rez:='';
if Fileexists(Name) then
begin
    assignFile(Tfi,Name);
    Reset(Tfi);
    While Not Eof(Tfi) do
    begin
    Readln(Tfi,Str);
    Rez:=Rez+Str+LN;
    end;
    CloseFile(Tfi);
end else
If Name=''
Then Writeln('Не указано имя файла')
else Writeln('Такого файла не существует '+Name);
REadProg:=Rez;
end;
Function  ReadPars(S:Ansistring):Tel; //  Разбивает строку на слова
var
  REZ:Tel;     // Списко слов на которые разита программа
  UKA:LongWord;// указатель на читаемый символ
  LEN:LongWord;// Длина Строки

Function REadSlo:Ansistring;// ДЛя чтения Операторов
Var
  REz:Ansistring;
begin
REz:='';
While (UKA<=LEN) and ((S[UKA]>='A') and (S[UKA]<='Z')) do
      begin
      REZ:=REZ+S[UKA];
      UKA:=UKA+1;
      end;
REadSlo:=Rez;
end;
Function REadCif:Ansistring;// ДЛя чтения цифер
Var
  REz:Ansistring;
begin
REz:='';
While (UKA<=LEN) and ((S[UKA]>='0') and (S[UKA]<='9')) do
      begin
      REZ:=REZ+S[UKA];
      UKA:=UKA+1;
      end;
REadCif:=Rez;
end;
Function REadZna:Ansistring;// ДЛя чтения Знаков
Var
  REz:Ansistring;
begin
REz:='';
If (UKA<=LEN) Then
If
  (S[UKA]='+') or
  (S[UKA]='-') or
  (S[UKA]='*') or
  (S[UKA]='/') or
  (S[UKA]='(') or
  (S[UKA]=')') or
  (S[UKA]='{') or
  (S[UKA]='}') or
  (S[UKA]='>') or
  (S[UKA]='<') or
  (S[UKA]='=')
      Then
      begin
      REZ:=REZ+S[UKA];
      UKA:=UKA+1;
      end;
REadZna:=Rez;
end;
Function REadKav:Ansistring;// ДЛя чтения Кавычки
Var
  REz:Ansistring;
begin
REz:='';
If (s[UKA]='"') Then
      begin
      UKA:=UKA+1;
      While (UkA<=LEN) and (S[UKA]<>'"') do
            Begin
            REZ:=REZ+S[UKA];
            UKA:=UKA+1;
            end;
      end;
REadKav:=Rez;
end;

begin
REZ:=TEl.Create;
REZ.TXT:='Program';
UKA:=1;
LEN:=Length(S);
While UKA<=LEN Do
      If REZ.ADD(REadSlo,TI_SLO)=nil Then
      If REZ.ADD(REadCif,TI_Cif)=nil Then
      If REZ.ADD(REadZna,TI_ZNA)=nil Then
      If REZ.ADD(REadKav,TI_KAv)=nil Then UKA:=UKA+1;
ReadPars:=Rez;
end;
Procedure ViewElem(E:Tel;O:Ansistring); // Выводит на печать содержимое элемента
Var
L:TEl;
begin
L:=E.BLO;
While L<>Nil Do
 begin
 Writeln(O+L.TXT);
 if l.Blo<>Nil Then ViewElem(l,O+' ');
 L:=L.Nex;
 end;
end;
Procedure ProgStru;// Формирует структуру программы
begin
PRG.VlogitSc('(',')');
PRG.VlogitSc('{','}');
PRG.VlogitPA;
PRG.VlogitBl;
PRG.VlogitMA('+-');
PRG.VlogitMA('*/');
PRG.VlogitMA('<>');
PRG.VlogitMA('=');
end;

{
begin
Pro:=ReadProg(ParamStr(1));
PRG:=ReAdPArs(AnsiUpperCase(Pro));
ProgStru;// Формирование структуры программы
PRG.TRUNS;
//ViewElem(PRG,'');
Readln;
end.
}

end.

