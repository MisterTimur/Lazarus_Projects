unit Unit3; {$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls,windows,CheckLst,Types,Gl,Glu,GLext;
type { TForm3 }  TForm3 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure OpenGLControl1Click(Sender: TObject);
    procedure OpenGLControl1DblClick(Sender: TObject);
    procedure OpenGLControl1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OpenGLControl1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLControl1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure OpenGLControl1Resize(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private

  public

  end;
var Form3: TForm3;
var   {Интерфейс редактора    ===========================}{%Region /FOLD }
                                                           Reg00:Longint;
CR:AnsiString=chr(13)+chr(10);
GStep:REal=1            ;// Шаг для Колеса мышки
MinRAsInMir:REal=1      ;// Минимальнео растояние в игровом мире и для рамки
MAxRAsInMir:Real=1024   ;// Максимальное растояние в игровом мире от камеры
G_FileName:Ansistring='';// Имя файла с котрым работаем
G_Change:Boolean=False  ;// В проекте есть не сохраненные изменения



procedure I_DelVer(iVer:Pointer);// Удаление Вершины
procedure I_DelLin(iLin:Pointer);// Удаление Линии
procedure I_DelPLo(iPlo:Pointer);// Удаление Плоскости
procedure I_DelEle(iEle:Pointer);// Удаление Элемента
procedure I_DelObj(iObj:pointer);// Удаление обьекта


function I_AddVerCOP(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVerSYX(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVerSYY(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVerSYZ(iEle:Pointer):Pointer;// Создает симетричную вершину


function I_AddVer(iEle:Pointer):Pointer;// Создает Вершины
function I_AddLin(iObj:Pointer):Pointer;// Создает Линии
function I_AddPlo(iObj:Pointer):Pointer;// Создает Плоскости
function I_AddEle(iEle:Pointer):Pointer;// Создает новый Элемент
function I_AddObj:POinter;// Создает новый обьект

procedure I_RefSpiVers(iEle:POinter;iLis:TCheckListBox);
procedure I_RefSpiLins(iObj:POinter;iLis:TCheckListBox);
procedure I_RefSpiPlos(iObj:POinter;iLis:TCheckListBox);
procedure I_RefSpiEles(iEle:POinter;iLis:TCheckListBox);
procedure I_RefSpiObjs(             iLis:TCheckListBox);

procedure I_GetN(iVer:Pointer;iEdit:TEdit);
procedure I_GetX(iVer:Pointer;iEdit:TEdit);
procedure I_GetY(iVer:Pointer;iEdit:TEdit);
procedure I_GetZ(iVer:Pointer;iEdit:TEdit);
procedure I_GetC(iVer:Pointer;iEdit:TEdit);
procedure I_GetA(iVer:Pointer;iEdit:TEdit);
procedure I_GeUX(iEle:Pointer;iEdit:TEdit);
procedure I_GeUY(iEle:Pointer;iEdit:TEdit);
procedure I_GeUZ(iEle:Pointer;iEdit:TEdit);

procedure I_SetN(iVer:Pointer;iEdit:TEdit);
procedure I_SetX(iVer:Pointer;iEdit:TEdit);
procedure I_SetY(iVer:Pointer;iEdit:TEdit);
procedure I_SetZ(iVer:Pointer;iEdit:TEdit);
procedure I_SetC(iVer:Pointer;iEdit:TEdit);
procedure I_SetA(iVer:Pointer;iEdit:TEdit);
procedure I_SeUX(iEle:Pointer;iEdit:TEdit);
procedure I_SeUY(iEle:Pointer;iEdit:TEdit);
procedure I_SeUZ(iEle:Pointer;iEdit:TEdit);

function  I_RodEle(iEle,iObj:Pointer):Boolean;
procedure I_SetSel(iPri:pointer;iSel:boolean);

function  isFloat(s:AnsiString):Boolean;
function  inFloat(s:AnsiString):real;
function  InString(i:REal):ansiString;
procedure I_Set_MBUT(iBol:Boolean);
procedure I_ClearScena;// Очищает Сцену
procedure I_SaveScena(iNamFile:Ansistring);// Сохраняет сцену
procedure I_LoadScena(iNamFile:Ansistring);// Сохраняет сцену
procedure I_DoubleObject(iTObj:Pointer);// Создает копию обьекта
procedure I_ADD_ANIMATION(iAni:TCheckListBox);// Созадет кадр анимации
procedure I_SET_ANIMATION(iAni:TCheckListBox);// Приеняет кадр анимации
procedure I_DEL_ANIMATION(iAni:TCheckListBox);
{%EndRegion}
implementation {$R *.lfm} uses unit4,unit5,unit6,unit7,unit8,unit9,unit10;
var   {Базa                   ===========================}{%Region /FOLD }
                                                           BAS01:Longint;

const {Базовые Константы      ===========================}{%Region /FOLD }

  GMAxRAsInMir=1024*8;// Растояние на котором вершину не видно


  MaxKolVerInEle=128;// Максимальное количество Вершин в Элементе
  MaxKolLinInObj=128;// Максимальное количество Линий в Элементе
  MaxKolPloInObj=512;// Максимальное количество Плоскостей в Элементе
  MaxKolObjInObj=128;// Максимальное количество Плоскостей в Элементе
  MaxKolEleInEle=128;// Максимальное количество Обьектов в Элементе

  MaxKOlVerInMir=1024*64;//Максимальное количество Вершин в игровом мире
  MaxKOlLinInMir=1024*64;//Максимальное количество Линий в игровом мире
  MaxKOlPloInMir=1024*64;//Максимальное количество Плоскостей в игровом мире
  MaxKOlEleInMir=1024*64;//Максимальное количество Элементов в игровом мире
  MaxKOlObjInMir=1024*64;//Максимальное количество Обьектов в игровом мире

  MinKolDelVers=1024*4;// Минимальный размер очереди на удаление Вершин
  MinKolDelLins=1024*4;// Минимальный размер очереди на удаление Линий
  MinKolDelPlos=1024*4;// Минимальный размер очереди на удаление Плоскотей
  MinKolDelEles=1024*4;// Минимальный размер очереди на удаление Элементов
  MinKolDelObjs=1024*4;// Минимальный размер очереди на удаление Обьектов

  MaxKolDelVers=1024*64;// Максимальный размер очереди на удаление Вершин
  MaxKolDelLins=1024*64;// Максимальный размер очереди на удаление Линий
  MaxKolDelPlos=1024*64;// Максимальный размер очереди на удаление Плоскотей
  MaxKolDelEles=1024*64;// Максимальный размер очереди на удаление Элементов
  MaxKolDelObjs=1024*64;// Максимальный размер очереди на удаление Обьектов

  MaxKolSelPris=1024*64;// Максимальнео количество выделеных примитивов

  T_VER=1;// Вршина
  T_PLO=2;// Плоскость
  T_LIN=3;// Линия
  T_ELE=4;// Элементы
  T_OBJ=5;// Обьекеты

{%EndRegion}
var   {Базовые типы данных    ===========================}{%Region /FOLD }
                                                           Reg02:Longint;
Type RSIN=Single  ;// Тип описывающий значение  спалваюзей точкой
Type RLON=LongWord;// ТИп описывающий целочисленые значения без знака
Type RINT=Longint ;// ТИп описывающий целочисленые значения
Type RBYT=Byte    ;// Тип описывающий байтовое значение
Type RBOL=Boolean ;// Тип Описывающий логическое значение
Type RSTR=STRING  ;// Тип описывающий текстовое значеие

Type RCS3=RECORD   // ТИп описывающий 3D Коордиату с плавающей точкой
  X,Y,Z:RSIN;
END;
Type RCI3=RECORD   // ТИп описывающий 3D Коордиату Целочисленную
  X,Y,Z:RINT;
END;
Type RCS2=RECORD   // ТИп описывающий 2D Коордиату с плавающей точкой
  X,Z:RSIN;
END;
Type RCI2=RECORD   // ТИп описывающий 2D Коордиату Целочисленную
  X,Z:RINT;
END;
Type RCOL=RECORD   // ТИп описывающий Цвет RGBA
  R,G,B,A:RBYT;
END;
Type RLin=RECORD   // ТИп описывающий Линию
  VERS:Array[1..2] of RLON; // Номера вершин
END;
Type RPLO=RECORD   // ТИп описывающий Плоскость
  VERS:Array[1..6] of RLON; // Номера вершин
END;
type TStr=class
TXT:Ansistring;
end;

function  Min(a,b:RSIN):RSIN;
begin
if A>B then result:=b else result:=a;
end;
function  Max(a,b:RSIN):RSIN;
begin
if A<B then result:=b else result:=a;
end;

procedure UGOL(var x,y,u:RSIN);// Поворот коориднаты на заданый угол
var x1,y1:Rsin;
begin

x1:=x*cos(u)-y*sin(u);
y1:=x*sin(u)+y*cos(u);

x:=x1;
y:=y1;

end;
Function  Vhodit3D(iCoo,Gmin,GMax:RCS3):Boolean;// входит ли ТОчка в обьект 3D
var Rez:Boolean;
begin
Rez:=False;
if (iCoo.x>=GMin.x) and (iCoo.x<=GMax.x) Then
if (iCoo.y>=GMin.y) and (iCoo.y<=GMax.y) Then
if (iCoo.z>=GMin.z) and (iCoo.z<=GMax.z) Then Rez:=true;
Vhodit3D:=Rez;
end;
Function  Vhodit2D(iCoo,Gmin,GMax:RCS3):Boolean;// входит ли ТОчка в обьект 2D
var Rez:Boolean;
begin
Rez:=False;
if (iCoo.x>=GMin.x) and (iCoo.x<=GMax.x) Then
if (iCoo.z>=GMin.z) and (iCoo.z<=GMax.z) Then Rez:=true;
Vhodit2D:=Rez;
end;

function  CreRCS3(iX,iY,iZ:RSIN):RCS3;// Создание 3D координаты
var Rez:RCS3;
begin
Rez.x:=iX;
Rez.y:=iY;
Rez.z:=iZ;
CreRcS3:=Rez;
end;
function  CreRCS2(iX,iZ:RSIN):RCS2;// Создание 2D координаты
var Rez:RCS2;
begin
Rez.x:=iX;
Rez.z:=iZ;
CreRcs2:=Rez;
end;
function  CreRCI3(iX,iY,iZ:RINT):RCI3;// Создание 3D координаты Целочисленой
var Rez:RCI3;
begin
Rez.x:=iX;
Rez.y:=iY;
Rez.z:=iZ;
CreRcI3:=Rez;
end;
function  CreRCI2(iX,iZ:RINT):RCI2;// Создание 2D координаты Целочисленой
var Rez:RCI2;
begin
Rez.x:=iX;
Rez.z:=iZ;
CreRcI2:=Rez;
end;
function  CreRCol(iR,iG,iB,iA:RBYT):RCOL;
var Rez:RCol;
begin
Rez.R:=iR;
Rez.G:=iG;
Rez.B:=iB;
Rez.A:=iA;
CreRcol:=Rez;
end;
function  SerRCol(A,B:RCOL):RCOL;// Находит середину между 2 Цветами
Var Rez:RCol;
begin
Rez.R:=A.R+round((B.R-A.R)/2);
Rez.G:=A.G+round((B.G-A.G)/2);
Rez.B:=A.B+round((B.B-A.B)/2);
Rez.A:=A.A+round((B.A-A.A)/2);
SerRCol:=Rez;
end;
function  SerRCS3(A,B:RCS3):RCS3;// Находит середину между 2 координатами
Var Rez:RcS3;
begin
Rez.X:=A.X+((B.X-A.X)/2);
Rez.Y:=A.Y+((B.Y-A.Y)/2);
Rez.Z:=A.Z+((B.Z-A.Z)/2);
SerRCS3:=Rez;
end;
function  SerRCS8(A,B:RCS3):RCS3;// Находит середину между 2 координатами
Var Rez:RcS3;
begin
Rez.X:=A.X+((B.X-A.X)/8);
Rez.Y:=A.Y+((B.Y-A.Y)/8);
Rez.Z:=A.Z+((B.Z-A.Z)/8);
SerRCS8:=Rez;
end;
function  RasRCS3(A,B:RCS3):RSIN;// Расчитывает рсатояние между 2 вершинами
Var
Rez:RSin;
RX:RSin;
RY:RSin;
RZ:RSin;
begin
RX:=(B.X-A.X);
RY:=(B.Y-A.Y);
RZ:=(B.Z-A.Z);
Rez:=Sqrt((RX*RX)+(RY*RY)+(RZ*RZ));
RasRCS3:=Rez;
end;
function  RasRCS2(A,B:RCS3):RSIN;// Расчитывает рсатояние между 2 вершинами
Var
Rez:RSin;
RX:RSin;
RY:RSin;
RZ:RSin;
begin
RX:=(B.X-A.X);
//RY:=(B.Y-A.Y);
RZ:=(B.Z-A.Z);
Rez:=Sqrt((RX*RX)+(RZ*RZ));
RasRCS2:=Rez;
end;
function  NilRCS3:RCS3;// Создание 3D координаты 0 0 0
begin
  NilRCS3:=CreRCS3(0,0,0);
end;
function  RanRcol:RCOL;// Создаёт случаный цвет непрозрачный
begin
RanRcol:=CreRcol(Random(256),Random(256),Random(256),255);
end;
function  CelRCol(a,b:Rcol;R,D:RSin):RCol;
var REz:Rcol;R7:RSIN;
begin
Rez:=B;
if R>D Then begin
R7:=Min((R-D),1);
Rez.R:=trunc((A.R-B.R)*R7)+B.R;
Rez.G:=trunc((A.G-B.G)*R7)+B.G;
Rez.B:=trunc((A.B-B.B)*R7)+B.B;
Rez.A:=trunc((0  -B.A)*R7)+B.A;
end;
CelRCol:=Rez;
end;
function  IntToCol(iCol:LongWord):RCOL;// Переводит Число в цвет
var
Rez:RCol;
Col:LongWord;
B:Array[0..3] of Byte absolute Col;
begin
Col:=iCol;
Rez.R:=b[0];
Rez.G:=b[1];
Rez.B:=b[2];
Rez.A:=b[3];
IntToCol:=Rez;
end;

function  TcolorToInt(iCol:Tcolor):LongWord;// Переводит Число в цвет
var
B:Array[0..3] of Byte;
Rez:LongWord absolute B;
begin
b[0]:=Red(iCol);
b[1]:=Green(iCol);
b[2]:=Blue(iCol);
b[3]:=0;
TcolorToInt:=Rez;
end;
function  IntToTcolor(iCol:LongWord):TColor;// Переводит Число в цвет
var
B:Array[0..3] of Byte;
C:LongWord absolute B;
Rez:Tcolor;
begin
C:=iCol;
REz:=RGBToColor(B[0],B[1],B[2]);
IntToTcolor:=Rez;
end;
function  RColRGBtoInt(iCol:RCol):LongWord;
var
REz:LongWord;
B:Array[0..3] of Byte absolute REz;
begin
B[0]:=iCOl.R;
B[1]:=iCOl.G;
B[2]:=iCOl.B;
B[3]:=0;
RColRGBtoInt:=REz;
end;

{%EndRegion}
var   {Базовые переменные     ===========================}{%Region /FOLD }

  GIDD:RLON;// Для генерации уникальных IDD
  GERR:RBOL;// Флаг ошибки Если в программе сбой

  KolKAdVsek:Longint;// Количество кадров в секунду

  HMath:HAndle;HMathTrId:DWORD;// Перевычисление обьектов
  HSWAP:HAndle;HSWAPTrId:DWORD;// Вывод в буфер вывода
  Clos:Boolean;// Флаг Завершения программы

  LBut:RBOL;// Состояние Левой кнопки мышки
  RBut:RBOL;// Состояние Правой кнопки мышки
  DBut:RBOL;// Двойное нажатие кнопки мышки
  MBUT:RBOL;// Перемещаться ли при нажатии по IDD

  RasN:RSIN;// Настоящие удаление от обьекта наблюдения
  Ras3:RSIN;// Целевое удаление от оббьекта наблюдения

  CaU3:RCS2;// Углы наклона камеры Целевые
  CaU2:RCS2;// Углы наклона камеры Настоящие
  CaU1:RCS2;// Углы наклона камеры Предыдущие

  CaP3:RCS3;// Координата камеры Целевые
  CaP2:RCS3;// Координата камеры Настоящие

  MouN:RCI2;// Настощие координаты мышки
  MouD:RCI2;// Где была нажата мышка

  GFon:Rcol;// Цвет фона

{%EndRegion}
var   {Базовые функции        ===========================}{%Region /FOLD }
                                                           Reg04:Longint;

      procedure ERR(S:string);// Сообщение о ошибке
      begin
      GERR:=true;
      ShowMessage(S);
      end;



      function  isFloat(s:AnsiString):Boolean;// ПРоверяет число ли это
      var f,c:Longint;r:real;Rez:Boolean;
      begin
        Rez:=False;
        val(s,r,c);
        if C=0 then Rez:=True;
        isFloat:=Rez;
      end;
      function  inFloat(s:AnsiString):real;// переводит в число строку
      var f,c:Longint;r:real;
      begin
        r:=0;
        val(s,r,c);
        inFloat:=r;
      end;
      function  InString(i:REal):ansiString;// переводит строку в число
      var
      lStr,REz:Ansistring;
      T:Boolean;f,Kz:Longint;
      begin
      Kz:=0;
      T:=False;
      lStr:=FloatToStr(i);
      for f:=1 to Length(lStr) do
      begin
      if (lStr[f]=',') or (lStr[f]='.') then begin
      T:=true;lStr[f]:='.';
      end;
      if KZ<3 then REz:=Rez+lStr[f];
      if T Then KZ:=KZ+1;
      end;
      if T then
      While (Length(Rez)>1      ) and (
            (Rez[Length(Rez)]='0') or
            (Rez[Length(Rez)]='.'))do
      delete(rez,Length(Rez),1);
      InString:=REz;
      end;


      Procedure I_Del_Spac(var iPos:Longint;var iStr:Ansistring);
      begin // ПРопускает пробелы
      while (iStr[iPos]<=' ') and (length(iStr)>=iPos) do inc(iPos);
      end;
      function  I_GetSC   (var iPos:Longint;var iStr:Ansistring):Ansistring;
      var Rez:Ansistring; // Читает занчение в скобке
      begin
      Rez:='';
      I_Del_Spac(iPos,iStr);
      if iStr[iPos]='(' then begin
        inc(iPos);
        while (iStr[iPos]<>')') and (length(iStr)>=iPos) do
        begin REz:=REz+iStr[iPos];inc(iPos);end;
        if (iStr[iPos]<>')') or (length(iStr)<iPos) Then
        ERR(' I_GetSC  iStr[iPos]<>'')'' or length(iStr)<iPos ');
        inc(iPos)
      end else ERR('I_GetSC iStr[iPos]=''('' ');
      I_Del_Spac(iPos,iStr);
      I_GetSC:=Rez;
      end;
      function  NewIdd:RLon;// Генерирует уникальный IDD
      begin
      GIDD:=GIDD+1;
      NewIdd:=GIDD;
      end;
      procedure StrToFile(var iNam,iStr:Ansistring);
      var tf:TextFile;
      begin
      AssignFile(tf,iNam);
      rewrite(tf);
      writeln(tf,iStr);
      closefile(tf);
      end;
      procedure FileToStr(var iNam,iStr:Ansistring);
      var
      tf:TextFile;
      lStr,S:AnsiString;
      begin
      AssignFile(tf,iNam);
      Reset(tf);
      while Not Eof(tf) do begin
      Readln(tf,S);
      lStr:=lStr+s
      end;
      iStr:=lStr;
      closefile(tf);
      end;

{%EndRegion}

{%EndRegion}
var   {Базовые структуры      ===========================}{%Region /FOLD }
                                                           BAS02:Longint;


var   {Описание Вершины       ===========================}{%Region /FOLD }
                                                           Reg05:Longint;
TYPE TVER=CLASS  // Опсиание вершиины

  NAM:RSTR;// Наименование элемента
  CAP:RSTR;// Видимое имя примитива
  SEL:RBOL;// ОБьект выделен для редактора нужно
  IDD:RLON;// Уникальный идентификатор
  NOM:RLON;// Номер в списке отрисовки
  TIP:RLON;// Тип примитива

  LOC:RCS3;// ЛОкальная коордианата
  MAT:RCS3;// Используеться для вычисления реальных координат
  REA:RCS3;// Реальная координата
  ECR:RCS3;// Экрнная координата

  COL:RCOL;// Цвет вершины
  ECO:RCOL;// Цвет вершины Экранный

  OBJ:TVER;// Обьект в котором находиться вершина
  ELE:TVER;// Элемент в котором находиться вершина
  GOb:TVer;// Обьект в котором находитьсЯ
  Gpl:TVer;// Плоскость над котрой находиться

  COM:RBOL;// Object Create Commplected Обьект готов к отрисовке
  MAR:RBOL;// Маршрутный примитив
  DEL:RBOL;// Вершина в очереди на удаление
  CRE:RBOL;// Вершина создана

  OB3:RSIN;// ОБьем элемента
  RAS:RSIN;// Растояние от камеры до вершины

  GMax:RCS3;// Габариты максимальные +x +y +z
  GMin:RCS3;// Габариты минимальные -x -y -z

  Constructor Create;

end;
TYPE TVERS=CLASS // Описание вершин
  KOLV :Longint;// Количество вершин в игровом мире
  KOLD :Longint;// Количество вершин котрые нада удалить
  DELV :Array[1..MaxKolDelVers ] of TVER;// Список вершин на удаление очередь
  VERS :Array[1..MaxKOlVerInMir] of TVER;// Все вершины игрового мира
  ECOO1:Array[0..MaxKolVerInMir] of RCS3;// Координаты всех вершин
  ECOO2:Array[0..MaxKolVerInMir] of RCS3;// Координаты вершин для отрисовке
  ECOL1:Array[0..MaxKolVerInMir] of RCOL;// Цвета всех вершин
  ECOL2:Array[0..MaxKolVerInMir] of RCOL;// Цвета всех вершин для отрисовки
  Procedure   AddV(iVer:Tver);// Ренестриует новую вершину
  Procedure   AddD(iVer:Tver);// ОТпарвляет вершину на удаление
  Constructor Create;
end;
var MirVers:Tvers;// Все вершины игрового мира здесь зарегестрированы

Constructor TVER.Create;// Создает вершину
begin

  NAM:=''           ;// Уникальное Имя вершины
  CAP:=''           ;// ПРоизвдьное имя примитива
  SEL:=false        ;// Не выделен примитив
  IDD:=NewIdD       ;// оплучаем уникальный идентификатор
  NOM:=0            ;// Номер в списке всех вершин
  TIP:=T_VER        ;// Тип Вершины

  LOC:=NilRCS3      ;// ЛОкальная коордианата
  MAT:=NilRCS3      ;// Используеться для вычисления реальных координат
  REA:=NilRCS3      ;// Реальная координата
  ECR:=NilRCS3      ;// Экрнная координата

  COL:=RanRCol      ;// Цвет вершины
  ECO:=RanRCol      ;// Экранный цвет

  OBJ:=Nil          ;// Обьект в котором находиться вершина
  ELE:=Nil          ;// Элемент в котором находиться вершина
  GOB:=Nil          ;// Обьект над которй находиться вершина
  GPL:=Nil          ;// Плоскость над которй находиться вершина

  MAR:=False        ;// Маршрутный примиив
  DEL:=False        ;// Флаг удаления вершины ыкпшина не удалена
  CRE:=False        ;// Вершина создана

  OB3:=0            ;// ОБьем элемента
  RAS:=GMAxRAsInMir ;// Растояние от камеры до вершины



end;
procedure   DelLinWithVer(iVer:Tver);forward;// Удаление вершин из линий
procedure   DelPloWithVer(iVer:Tver);forward;// Удаление вершин из Плоск
Procedure   TVERS.AddV(iVer:Tver);// Регестриует новую вершину
var F:Longint;Ex:Boolean;
begin

  Ex:=False;
  //------------------------------------------------------------------------------

  // Если в очереди даленных вершин больше MinKolDelVers
  // То можно не создавать нвоую вершину а использовать удленную
  if KolD>MinKolDelVers then begin Ex:=True;
  iVer.Nom:=DELV[1].NOM;
  VERS[iVer.Nom]:=iVer;
  DELV[1].Free;
  for f:=1 to KolD-1 Do DELV[F]:=DELV[F+1];
  KOlD:=KolD-1;
  end;

  //------------------------------------------------------------------------------

  // Если не достточно удаленнх вершин то просто создаем новую
  if Not Ex then Begin
  if KolV+1>MaxKOlVerInMir then
  ERR(' TVERS.AddV(iVer:Tver) KolV+1>MaxKOlVerInMir ');
  VERS[KolV+1]:=iVer;
  VERS[KolV+1].NOM:=KolV+1;
  KolV:=KolV+1;
  end;

  //------------------------------------------------------------------------------

end;
Procedure   TVERS.AddD(iVer:Tver);// ОТпарвляет вершину на удаление
begin
  if not IVer.Del then begin
  I_SetSel(iVer,false);// Снимаю выделение елси оно есть
  //----------------------------------------------------------------------------
  DelPloWithVer(iVer);
  DelLinWithVer(iVer);
  //----------------------------------------------------------------------------
  IVer.Del:=True;
  if KolD+1>MaxKolDelVers then
  ERR('Массив с удаленными вершинами переполнен');
  DELV[KolD+1]:=iVer;
  KolD:=KolD+1;
  end else ERR('Попытка удалить уже удаленную вершину');
end;
Constructor TVERS.Create;
begin
KolV:=0;
KolD:=0;
end;

{%EndRegion}
var   {Описание Линии         ===========================}{%Region /FOLD }
                                                           Reg0L:Longint;

TYPE TLIN=CLASS(TVER)
  VERS:Array[1..2] of TVER;// Вершины из котрых состоит Линия
  Procedure   L_Gaba;// Вычислене габаритов
  Constructor Create(iVer1,iVer2:TVer);// Конструктор
  Destructor  destroy;override;
end;
TYPE TLINS=CLASS
DrKl:RLON;// Реально количество рисуемых Линий
KOLL:RLON;// Количество Лиинй в игровом мире всего
KOlD:RLON;// Количество удаленных Линий в игровом мире
DELL :Array[1..MaxKOlLinInMir] of TLIN;// Удаленные Линии
LINS :Array[1..MaxKOlLinInMir] of TLIN;// Все Линии зарег в игровм мире
ELin1:Array[1..MaxKolLinInMir] of RLIN;// Индексы вершин Линий формируються
ELin2:Array[1..MaxKolLinInMir] of RLIN;// Индексы вершин Линий для Экрана
Procedure   AddL(iLin:TLIN);// Регестриует новую Линию
Procedure   AddD(iLIN:TLIN);// Добавляет Линию в очередь на удаление
Constructor Create;
end;
var MirLins:TLINS;// Все зарагестрированые Линии и удаленые тут
Procedure   TLIN.L_Gaba;// Вычислене габаритов Линии
var F:Longint;
begin

GMax.X:=-GMAxRAsInMir;
GMax.Y:=-GMAxRAsInMir;
GMax.Z:=-GMAxRAsInMir;
GMin.X:= GMAxRAsInMir;
GMin.Y:= GMAxRAsInMir;
GMin.Z:= GMAxRAsInMir;

for f:=1 to 2 do begin
if (GMax.X<VERS[f].REA.x) then GMax.X:=VERS[f].REA.x;
if (GMax.Y<VERS[f].REA.y) then GMax.Y:=VERS[f].REA.y;
if (GMax.Z<VERS[f].REA.z) then GMax.Z:=VERS[f].REA.z;
if (GMin.X>VERS[f].REA.x) then GMin.X:=VERS[f].REA.x;
if (GMin.Y>VERS[f].REA.y) then GMin.Y:=VERS[f].REA.y;
if (GMin.Z>VERS[f].REA.z) then GMin.Z:=VERS[f].REA.z;
end;

if (GMax.X<REA.x+MinRAsInMir) then GMax.X:=REA.x+MinRAsInMir;
if (GMax.Y<REA.y+MinRAsInMir) then GMax.Y:=REA.y+MinRAsInMir;
if (GMax.Z<REA.z+MinRAsInMir) then GMax.Z:=REA.z+MinRAsInMir;

if (GMin.X>REA.x-MinRAsInMir) then GMin.X:=REA.x-MinRAsInMir;
if (GMin.Y>REA.y-MinRAsInMir) then GMin.Y:=REA.y-MinRAsInMir;
if (GMin.Z>REA.z-MinRAsInMir) then GMin.Z:=REA.z-MinRAsInMir;

GMax.X:=GMax.X+MinRAsInMir;
GMax.Y:=GMax.Y+MinRAsInMir;
GMax.Z:=GMax.Z+MinRAsInMir;

GMin.X:=GMin.X-MinRAsInMir;
GMin.Y:=GMin.Y-MinRAsInMir;
GMin.Z:=GMin.Z-MinRAsInMir;

// Вычисление обьема
OB3:=(GMax.X-GMin.X)*(GMax.Y-GMin.Y)*(GMax.Z-GMin.Z);
end;
Constructor TLIN.Create(iVer1,iVer2:Tver);
begin
inherited  Create;// Вызываю родительский конструктор

VERS[1]:=iVer1;
VERS[2]:=iVer2;

TIP:=T_LIN;

end;
Destructor  TLIN.Destroy;
begin
inherited Destroy;
end;
procedure   DelLinWithVer(iVer:Tver);// Удаление вершин из линий
var f:Longint;
Begin
for f:=1 to MirLins.KOlL do
if  not MirLins.LINS[f].DEL then
if (MirLins.LINS[f].VERS[1]=iVer) or
   (MirLins.LINS[f].VERS[2]=iVer) Then MirLins.AddD(MirLins.LINS[f]) ;
end;
Procedure   TLINS.AddL(iLin:TLin);
var F:Longint;Ex:Boolean;
begin
  Ex:=False;

  //------------------------------------------------------------------------------
  // Если есть удаляемые плоскости то заменяем на новую плоскость

  if KolD>MinKolDelLins then begin Ex:=True;
  iLin.Nom:=DELL[1].NOM;// Новая плосоктсь получает индекс удаляемой
  LINS[iLin.Nom]:=iLin ;//
  DELL[1].Free;
  // Свдигаем список удленных плоскостей
  for f:=1 to KolD-1 Do DELL[F]:=DELL[F+1];
  KOlD:=KolD-1;
  end;

  //------------------------------------------------------------------------------

  // Если нет удаляемых Линий просто добавлем линию
  if Not Ex then Begin
  if KolL+1>MaxKOlLinInMir then
  ERR(' TLINS.AddP  KolL+1>MaxKOlLinInMir ');
  LiNS[KolL+1]:=iLiN;
  LiNS[KolL+1].NOM:=KolL+1;
  KOlL:=KOlL+1;
  end;

  //------------------------------------------------------------------------------

end;
Procedure   TLINS.AddD(iLin:TLin);
begin
  if not ILin.Del then begin
  I_SetSel(iLin,false);// Снимаю выделение елси оно есть
  ILin.Del:=True;
  if KolD+1>MaxKolDelLins then
  ERR('Массив с удаленными линиями переполнен');
  DELL[KolD+1]:=iLin;
  KolD:=KolD+1;
  end else Err('Попутка удалить уже удаленную линию ');
end;
Constructor TLINS.Create;
begin
  KolL:=0;
  KOlD:=0;
end;

{%EndRegion}
var   {Описание Плоскоси      ===========================}{%Region /FOLD }
                                                           Reg06:Longint;

TYPE TPLO=CLASS(TVER)
  VERS:Array[1..4] of TVER;// Вершины из котрых состоит плоскость
  Function    P_Viso(iCoo:RCS3):RSIN;// Определить высоту на плоскости
  Procedure   P_Gaba;// Вычислене габаритов
  Constructor Create(iVer1,iVer2,iVer3,iVer4:Tver);// Конструктор
  Destructor  destroy;override;
end;
TYPE TPLOS=CLASS
DrKp:RLON;// Реальное Количество рисуемых плоскостей
KOLP:RLON;// Количество плоскостей в игровом мире всего
KOlD:RLON;// Количество удаленных плоскостей в игровом мире
DELP :Array[1..MaxKOlPloInMir] of TPLO;// Удаленные плоскости
PLOS :Array[1..MaxKOlPloInMir] of TPLO;// Все плоскости зарег в игровм мире
EPlo1:Array[1..MaxKolPloInMir] of RPLO;// Индексы вершин Плоскостей формируються
EPlo2:Array[1..MaxKolPloInMir] of RPLO;// Индексы вершин Плоскостей для Экрана
Procedure   AddP(iPlo:TPLO);// Регестриует новую плоскость
Procedure   AddD(iPlo:TPLO);// Добавляет плоскость в очередь на удаление
Constructor Create;
end;
var MirPlos:TPLOS;// Все зарагестрированые плоскрсти и удаленые тут
Function    TPLO.P_Viso(iCoo:RCS3):RSIN;
Function    MinVis(t1,t2,t3,t4:RCS3;G:Longint):RSin;
var
Rez:Rsin;
ser:RCS3;
T12,t23,T34,t14:RCS3;
begin
T12:=SerRCS3(t1,t2);
T23:=SerRCS3(t2,t3);
T34:=SerRCS3(t3,t4);
T14:=SerRCS3(t1,t4);
SER:=SerRCS3(t1,t3);
rez:=ser.y;
G:=G-1;
if G>0 Then
if (iCoo.x<Ser.x) and (iCoo.z<Ser.z) then rez:=MinVis(t1,t12,ser,t14,g) else
if (iCoo.x<Ser.x) and (iCoo.z>Ser.z) then rez:=MinVis(t12,t2,t23,ser,g) else
if (iCoo.x>Ser.x) and (iCoo.z>Ser.z) then rez:=MinVis(ser,t23,t3,t34,g) else
if (iCoo.x>Ser.x) and (iCoo.z<Ser.z) then rez:=MinVis(t14,ser,t34,t4,g) else rez:=Ser.Y;
MinVis:=rez;
end;
begin
P_Viso:=MinVis(VERS[1].REA,VERS[2].REA,VERS[3].REA,VERS[4].REA,8);
end;
Procedure   TPLO.P_Gaba;// Вычислене габаритов плоскости
var F:Longint;
begin

GMax.X:=-GMAxRAsInMir;
GMax.Y:=-GMAxRAsInMir;
GMax.Z:=-GMAxRAsInMir;
GMin.X:= GMAxRAsInMir;
GMin.Y:= GMAxRAsInMir;
GMin.Z:= GMAxRAsInMir;

for f:=1 to 4 do begin
if (GMax.X<VERS[f].REA.x) then GMax.X:=VERS[f].REA.x;
if (GMax.Y<VERS[f].REA.y) then GMax.Y:=VERS[f].REA.y;
if (GMax.Z<VERS[f].REA.z) then GMax.Z:=VERS[f].REA.z;
if (GMin.X>VERS[f].REA.x) then GMin.X:=VERS[f].REA.x;
if (GMin.Y>VERS[f].REA.y) then GMin.Y:=VERS[f].REA.y;
if (GMin.Z>VERS[f].REA.z) then GMin.Z:=VERS[f].REA.z;
end;

if (GMax.X<REA.x+MinRAsInMir) then GMax.X:=REA.x+MinRAsInMir;
if (GMax.Y<REA.y+MinRAsInMir) then GMax.Y:=REA.y+MinRAsInMir;
if (GMax.Z<REA.z+MinRAsInMir) then GMax.Z:=REA.z+MinRAsInMir;

if (GMin.X>REA.x-MinRAsInMir) then GMin.X:=REA.x-MinRAsInMir;
if (GMin.Y>REA.y-MinRAsInMir) then GMin.Y:=REA.y-MinRAsInMir;
if (GMin.Z>REA.z-MinRAsInMir) then GMin.Z:=REA.z-MinRAsInMir;


GMax.X:=GMax.X+MinRAsInMir;
GMax.Y:=GMax.Y+MinRAsInMir;
GMax.Z:=GMax.Z+MinRAsInMir;

GMin.X:=GMin.X-MinRAsInMir;
GMin.Y:=GMin.Y-MinRAsInMir;
GMin.Z:=GMin.Z-MinRAsInMir;

// Вычисление обьема
OB3:=(GMax.X-GMin.X)*(GMax.Y-GMin.Y)*(GMax.Z-GMin.Z);
end;
Constructor TPLO.Create(iVer1,iVer2,iVer3,iVer4:Tver);
begin
inherited  Create;// Вызываю родительский конструктор

VERS[1]:=iVer1;
VERS[2]:=iVer2;
VERS[3]:=iVer3;
VERS[4]:=iVer4;

TIP:=T_PLO;

end;
Destructor  TPLO.Destroy;
begin
inherited Destroy;
end;
procedure   DelPloWithVer(iVer:Tver);// Удаление вершин из Плоско
var f:Longint;
Begin
for f:=1 to MirPlos.KOlP do
if  not MirPlos.PLOS[f].DEL then
if (MirPlos.PLOS[f].VERS[1]=iVer) or
   (MirPlos.PLOS[f].VERS[2]=iVer) or
   (MirPlos.PLOS[f].VERS[3]=iVer) or
   (MirPlos.PLOS[f].VERS[4]=iVer) Then MirPlos.AddD(MirPLos.PLOS[f]) ;
end;
Procedure   TPLOS.AddP(iPlo:TPlo);
var F:Longint;Ex:Boolean;
begin
  Ex:=False;

  //------------------------------------------------------------------------------
  // Если есть удаляемые плоскости то заменяем на новую плоскость

  if KolD>MinKolDelPlos then begin Ex:=True;
  iPlo.Nom:=DELP[1].NOM;// Новая плосоктсь получает индекс удаляемой
  PLOS[iPlo.Nom]:=iPlo ;//
  DELP[1].Free;
  // Свдигаем список удленных плоскостей
  for f:=1 to KolD-1 Do DELP[F]:=DELP[F+1];
  KOlD:=KolD-1;
  end;

  //------------------------------------------------------------------------------

  // Если нет удаляемых плосокстей просто добавлем плосоксть
  if Not Ex then Begin
  if KolP+1>MaxKOlPloInMir then
  ERR(' TPLOS.AddP  KolP+1>MaxKOlPloInMir ');
  PloS[KolP+1]:=iPlo;
  PloS[KolP+1].NOM:=KolP+1;
  KolP:=KolP+1;
  end;

  //------------------------------------------------------------------------------

end;
Procedure   TPLOS.AddD(iPlo:TPlo);
begin
  if Not IPlo.Del then begin
  I_SetSel(iPlo,false);// Снимаю выделение елси оно есть
  IPlo.Del:=True;
  if KolD+1>MaxKolDelPlos then
  ERR('Масив с удаленными плоскостями переполнен');
  DELP[KolD+1]:=iPlo;
  KolD:=KolD+1;
  end else ERR('ПОпытка удалить уже удаленную плоскость');
end;
Constructor TPLOS.Create;
begin
  KolP:=0;
  KOlD:=0;
end;

{%EndRegion}
var   {Описание Элемента      ===========================}{%Region /FOLD }
                                                           Reg07:Longint;
TYPE TELE=CLASS(TVER)
  KolV:RLON;// Количество вершин
  KolE:RLON;// Количество вложеных Элементов
  EUGL:RCS3;// Углы наклона элемнта относительно родительского элемента
  VERS:Array[1..MaxKolVerInEle] of TVER;// Вершины
  ELES:Array[1..MaxKolEleInEle] of TELE;// Элементы
  function    E(iX,iY,iZ:RSIN):TELE;// Создает Элемент
  function    V(iX,iY,iZ:RSIN):TVER;// Создает вершину
  procedure   E_SREA;// Вычисление Рефльных координат
  procedure   E_SECR;// Вычисление Экранных координат
  procedure   E_INIC;// Копирем реальные кооррдинаты в экранные
  procedure   E_RAST;// Вычислет растояние от наблюдателя
  procedure   E_MATH;// Вычисление реальных координат
  procedure   E_SWAP;// Вычисление Экранны координат
  Procedure   E_Gaba;// Вычислене габаритов
  procedure   E_POVO(iCoo,iUgo:RCS3);// Поворот
  Procedure   E_MASH(iMah:RSin);// Маштабирование
  Constructor Create;// Констурктор
  Destructor  Destroy;override;
end;
TYPE TELES=CLASS // Описание элементов
  KOLE :Longint;// Количество Элементов в игровом мире
  KOLD :Longint;// Количество Элементов котрые нада удалить
  DELE :Array[1..MaxKolDelEles ] of TELE;// Список элемента  на удаление очередь
  ELES :Array[1..MaxKOlEleInMir] of TELE;// Все элемента  игрового мира
  ECOO1:Array[0..MaxKolEleInMir] of RCS3;// Координаты всех элемента
  ECOO2:Array[0..MaxKolEleInMir] of RCS3;// Координаты элемента  для отрисовке
  ECOL1:Array[0..MaxKolEleInMir] of RCOL;// Цвета всех элемента
  ECOL2:Array[0..MaxKolEleInMir] of RCOL;// Цвета всех элементов  для отрисовки
  Procedure   AddE(iEle:TEle);// Регестриует новую элемента
  Procedure   AddD(iEle:TEle);// ОТпарвляет элемент  на удаление
  Constructor Create;
end;
var  MirELEs:TEles;// Все вершины игрового мира здесь зарегестрированы

function    TELE.E(iX,iY,iZ:RSIN):TELE;// Добавляет Элемент
Var Rez:TELE;
begin
//-----------------------------------------------------
Rez:=TELE.CREATE;// Создаю экземпляр вершины
Rez.OBJ:=OBJ;
Rez.ELE:=Self;
//-----------------------------------------------------

//-----------------------------------------------------
ELES[KolE+1]:=Rez;// Добавляю Вершину в список элементов
KolE:=KolE+1;// Увеличиваю количество  элементов
MirEles.AddE(Rez);
//-----------------------------------------------------
E:=Rez;
end;
function    TELE.V(iX,iY,iZ:RSIN):TVER;// Добавляет вершину
Var Rez:TVER;
begin
//-----------------------------------------------------
Rez:=TVER.CREATE;// Создаю экземпляр вершины
Rez.Obj:=Obj;
Rez.Ele:=Self;
//-----------------------------------------------------
Rez.LOC.x:=ix;
Rez.LOC.y:=iy;
Rez.LOC.z:=iz;
//-----------------------------------------------------
VERS[KolV+1]:=Rez;// Добавляю Верину в список верши элемента
KolV:=KolV+1;// Увеличиваю количество вершин в элементе
MirVers.AddV(Rez);
//-----------------------------------------------------
V:=Rez;
end;
procedure   TELE.E_MATH;// Вычисление МАТ координат
var fv,fe:Longint;
begin
MAT:=LOC;
for fv:=1 to KolV do begin

VERS[fv].MAT.x:=VERS[fv].LOC.x;
VERS[fv].MAT.y:=VERS[fv].LOC.y;
VERS[fv].MAT.z:=VERS[fv].LOC.z;

UGOL(VERS[fv].MAT.z,VERS[fv].MAT.y,EUGL.X);
UGOL(VERS[fv].MAT.x,VERS[fv].MAT.z,EUGL.Y);
UGOL(VERS[fv].MAT.x,VERS[fv].MAT.y,EUGL.Z);

VERS[fv].MAT.x:=VERS[fv].MAT.x+MAT.x;
VERS[fv].MAT.y:=VERS[fv].MAT.y+MAT.y;
VERS[fv].MAT.z:=VERS[fv].MAT.z+MAT.z;

end;
for fe:=1 to KolE do begin
ELES[fe].E_Math;
ELES[fe].E_Povo(MAT,EUGL);
end;
end;
procedure   TELE.E_POVO(iCoo,iUgo:RCS3);// Поворот
var fv,fe:Longint;
begin

UGOL(MAT.z,MAT.y,iUgo.X);
UGOL(MAT.x,MAT.z,iUgo.Y);
UGOL(MAT.x,MAT.y,iUgo.Z);
MAT.x:=MAT.x+iCoo.X;
MAT.y:=MAT.y+iCoo.Y;
MAT.z:=MAT.z+iCoo.Z;

for fv:=1 to KolV do begin
// Вычисление реальных координат вершин
UGOL(VERS[fv].MAT.z,VERS[fv].MAT.y,iUgo.X);
UGOL(VERS[fv].MAT.x,VERS[fv].MAT.z,iUgo.Y);
UGOL(VERS[fv].MAT.x,VERS[fv].MAT.y,iUgo.Z);
VERS[fv].MAT.x:=VERS[fv].MAT.x+iCoo.X;
VERS[fv].MAT.y:=VERS[fv].MAT.y+iCoo.Y;
VERS[fv].MAT.z:=VERS[fv].MAT.z+iCoo.Z;
end;

for fe:=1 to KolE do
ELES[fe].E_Povo(iCoo,iUgo);

end;
procedure   TELE.E_SREA;// Вычисление Реальных координат
var f:Longint;
begin
REA:=MAT;
for f:=1 to KolE do ELES[f].E_SREA;
for f:=1 to KolV do with VERS[f] do  REA:=MAT;
end;
procedure   TELE.E_SECR;// Вычисление Экранны координат
var f:Longint;
begin
ECR:=SerRCS8(ECR,REA);
for f:=1 to KolE do with ELES[f] do E_SECR;
for f:=1 to KolV do with VERS[f] do ECR:=SerRCS8(ECR,REA);
end;
procedure   TELE.E_SWAP;// Вычисление Экранны координат
var f:Longint;
begin
for f:=1 to KolE do with ELES[f] do E_SWAP;
for f:=1 to KolV do begin
//MirVers.ECOO1[VERS[f].NOM].X:=VERS[f].ECR.X-Cap2.x;
//MirVers.ECOO1[VERS[f].NOM].Y:=VERS[f].ECR.Y-Cap2.y;
//MirVers.ECOO1[VERS[f].NOM].Z:=VERS[f].ECR.Z-Cap2.z;
MirVers.ECOO2[VERS[f].NOM]:=VERS[f].ECR;
end;
end;
procedure   TELE.E_INIC;// Вычисление Экранны координат
var f:Longint;
begin
ECR:=REA;
for f:=1 to KolE do with ELES[f] do E_INIC;
for f:=1 to KolV do with VERS[f] do ECR:=REA;
end;
procedure   TELE.E_RAST;// Вычисление Растояий от камеры
var f:Longint;
begin
RAS:=RasRCS3(REA,CaP2);
for f:=1 to KolE do ELES[f].E_RAST;
for f:=1 to KolV do VERS[f].RAS:=RasRCS3(VERS[f].REA,CaP2);
end;
Procedure   TELE.E_Gaba;// Вычислене габаритов
var F:Longint;
begin
for f:=1 to KOLE do ELES[f].E_GABA;

GMax.X:=-GMAxRAsInMir;
GMax.Y:=-GMAxRAsInMir;
GMax.Z:=-GMAxRAsInMir;
GMin.X:= GMAxRAsInMir;
GMin.Y:= GMAxRAsInMir;
GMin.Z:= GMAxRAsInMir;

for f:=1 to KolV do begin
if (GMax.X<VERS[f].REA.x) then GMax.X:=VERS[f].REA.x;
if (GMax.Y<VERS[f].REA.y) then GMax.Y:=VERS[f].REA.y;
if (GMax.Z<VERS[f].REA.z) then GMax.Z:=VERS[f].REA.z;
if (GMin.X>VERS[f].REA.x) then GMin.X:=VERS[f].REA.x;
if (GMin.Y>VERS[f].REA.y) then GMin.Y:=VERS[f].REA.y;
if (GMin.Z>VERS[f].REA.z) then GMin.Z:=VERS[f].REA.z;
end;

for f:=1 to KolE do begin
if (GMax.X<ELES[f].GMax.x) then GMax.X:=ELES[f].GMax.x;
if (GMax.Y<ELES[f].GMax.y) then GMax.Y:=ELES[f].GMax.y;
if (GMax.Z<ELES[f].GMax.z) then GMax.Z:=ELES[f].GMax.z;
if (GMin.X>ELES[f].GMin.x) then GMin.X:=ELES[f].GMin.x;
if (GMin.Y>ELES[f].GMin.y) then GMin.Y:=ELES[f].GMin.y;
if (GMin.Z>ELES[f].GMin.z) then GMin.Z:=ELES[f].GMin.z;
end;

if (GMax.X<REA.x+MinRAsInMir) then GMax.X:=REA.x+MinRAsInMir;
if (GMax.Y<REA.y+MinRAsInMir) then GMax.Y:=REA.y+MinRAsInMir;
if (GMax.Z<REA.z+MinRAsInMir) then GMax.Z:=REA.z+MinRAsInMir;

if (GMin.X>REA.x-MinRAsInMir) then GMin.X:=REA.x-MinRAsInMir;
if (GMin.Y>REA.y-MinRAsInMir) then GMin.Y:=REA.y-MinRAsInMir;
if (GMin.Z>REA.z-MinRAsInMir) then GMin.Z:=REA.z-MinRAsInMir;

GMax.X:=GMax.X+MinRAsInMir;
GMax.Y:=GMax.Y+MinRAsInMir;
GMax.Z:=GMax.Z+MinRAsInMir;

GMin.X:=GMin.X-MinRAsInMir;
GMin.Y:=GMin.Y-MinRAsInMir;
GMin.Z:=GMin.Z-MinRAsInMir;

// Вычисление обьема
OB3:=(GMax.X-GMin.X)*(GMax.Y-GMin.Y)*(GMax.Z-GMin.Z);
end;

procedure   TELE.E_MASH(iMah:RSin);// Маштабирование Элемента
var f:Longint;
begin
LOC.X:=LOC.X*iMah;
LOC.Y:=LOC.Y*iMah;
LOC.Z:=LOC.Z*iMah;
for f:=1 to KolV do begin
VERS[f].LOC.X:=VERS[f].LOC.X*iMah;
VERS[f].LOC.Y:=VERS[f].LOC.Y*iMah;
VERS[f].LOC.Z:=VERS[f].LOC.Z*iMah;
end;
for f:=1 to KolE do ELES[f].E_MASH(iMah);
end;
Constructor TELE.Create;
begin
inherited Create;
KolV:=0;
KolE:=0;
TIP:=T_ELE;
end;
Destructor  TELE.Destroy;
var F:Longint;
begin
for f:=1 to KolE do ELES[f].free;
inherited Destroy;
end;

Procedure   TELES.AddE(iELE:TELE);// Регестриует новую вершину
var F:Longint;Ex:Boolean;
begin

  Ex:=False;
  //------------------------------------------------------------------------------

  // Если в очереди даленных элементов  больше MinKolDelEles
  // То можно не создавать нвоую элемент а использовать удленную
  if KolD>MinKolDelEles then begin Ex:=True;
  iEle.Nom:=DELE[1].NOM;
  ELES[iEle.Nom]:=iEle;
  DELE[1].Free;
  for f:=1 to KolD-1 Do DELE[F]:=DELE[F+1];
  KOlD:=KolD-1;
  end;

  //------------------------------------------------------------------------------

  // Если не достточно удаленнх Элементов то просто создаем новую
  if Not Ex then Begin
  if KolE+1>MaxKOlEleInMir then
  ERR(' TELES.AddE(iELE:TELE) KolV+1>MaxKOlEleInMir ');
  ELES[KolE+1]:=iEle;
  ElES[KolE+1].NOM:=KolE+1;
  KolE:=KolE+1;
  end;

  //------------------------------------------------------------------------------

end;
Procedure   TELES.AddD(iELE:TELE);// ОТпарвляет Элемент на удаление
var F:Longint;
begin
  if not IEle.Del then begin
  I_SetSel(iEle,false);// Снимаю выделение елси оно есть
  IEle.Del:=True;
  for f:=1 to iEle.KOlV do if not iEle.VERS[f].del then
  MirVers.addD(iEle.VERS[f]);// Вершины на удаление
  for f:=1 to iEle.KolE do if not iEle.ELES[f].del then
  MirEles.AddD(iEle.Eles[f]);// Удаление элементов
  if KolD+1>MaxKolDelEles then
  ERR('МАсив с удаленными элементами переполнен');
  DELE[KolD+1]:=iEle;
  KolD:=KolD+1;
  end else ERR('ПОпытка удалить уже удаленный элемент ');
end;
Constructor TELES.Create;
begin
KolE:=0;
KolD:=0;
end;

{%EndRegion}
var   {Описание Обьекта       ===========================}{%Region /FOLD }
                                                           Reg08:Longint;
TYPE TOBJ=CLASS(TELE)

  KAdr:RSIN;// Номер кадра для анимации
  OCEL:RCS3;// Цель куда нужно перпемесчаться
  OPER:RBOL;// Если это управляемый персонаж А не бот
  OGRA:RBOL;// Являеться ли обьект гравитационным
  KolP:RLON;// Количество плоскостей
  KolL:RLON;// Количество Линий
  KolD:RLON;// Количество Зависимых обьектов
  PLOS:Array[1..MaxKolPloInObj] of TPLO;// Плоскости
  LINS:Array[1..MaxKolLinInObj] of TLin;// Линии
  DELS:Array[1..MaxKolObjInObj] of TObj;// Зависимые обьекты
  procedure   O_MATH;// Перевычисление обьекта
  procedure   O_SREA;// Вычисление Реальных координат
  procedure   O_SECR;// Высиление экранных координат
  procedure   O_INIC;// копирование реальных координат в экранные
  procedure   O_RAST;// Вычисление Растояний от камеры
  Procedure   O_Gaba;// Вычислене габаритов
  Procedure   O_MASH(iMah:RSin);// Маштабирование
  procedure   O_Rabo;Virtual;// Работа
  procedure   O_SWAP;// прямое изменение координат обьекта на экране
  Procedure   AddDels(iObj:Tobj);// Добавлет зависимый обьект
  Procedure   DelDels(iObj:Tobj);// Удаляет зависимый обьект
  constructor Create;// Констурктор
  Destructor  destroy;override;
  function    P(iVer1,iVer2,iVer3,iVer4:TVER):TPLO;// Добавляет плоскость
  function    L(iVer1,iVer2:TVER):TLIN;// Добавляет Линию
End;
TYPE TOBJS=CLASS
KOLO:Longint;
KOLD:Longint;
OBJS:Array[1..MaxKOlObjInMir] of TOBJ;
DELO:Array[1..MaxKolDelObjs ] of TOBJ;
Procedure   Ras;
Function    AddO(iObj:TOBJ):Tobj;
procedure   AddD(iObj:TOBJ);
Constructor Create;
end;
var  MirObjs:TOBJS;

function    TOBJ.P(iVer1,iVer2,iVer3,iVer4:TVER):TPLO;// Добавляет плоскость
Var Rez:TPLO;
begin
//-----------------------------------------------------
Rez:=TPLO.CREATE(iVer1,iVer2,iVer3,iVer4);
Rez.Obj:=Obj;
Rez.Ele:=Self;
//-----------------------------------------------------


//-----------------------------------------------------
PLOS[KolP+1]:=Rez;
KolP:=KolP+1;
MirPlos.AddP(Rez);
//-----------------------------------------------------
P:=Rez;
end;
function    TOBJ.L(iVer1,iVer2:TVER):TLIN;// Добавляет Линию
Var Rez:TLin;
begin
//-----------------------------------------------------
Rez:=TLIN.CREATE(iVer1,iVer2);
Rez.Obj:=Obj;
Rez.Ele:=Self;
//-----------------------------------------------------

//-----------------------------------------------------
LINS[KolL+1]:=Rez;
KolL:=KolL+1;
MirLins.AddL(Rez);
//-----------------------------------------------------
L:=Rez;
end;
Procedure   TOBJ.AddDels(iObj:Tobj);// Добавлет зависимый обьект
begin
if (KolD+1>MaxKolObjInObj) then
ERR(' TOBJ.AddDels(iObj:Tobj) (KolD+1>MaxKolObjInObj)');
Dels[KolD+1]:=iObj;
KolD:=Kold+1;
end;
Procedure   TOBJ.DelDels(iObj:Tobj);// Удаляет зависимый обьект
var f,f2:Longint;
begin
for f:=1 to KolD do
if DELS[f]=iObj Then begin
for f2:=f to KolD-1 do DELS[f2]:=DELS[f2+1];
KolD:=Kold-1;
end
end;
procedure   TOBJ.O_MASH(iMah:RSin);// Маштабирование обьекта
var f:Longint;
begin
for f:=1 to KolV do begin
VERS[f].LOC.X:=VERS[f].LOC.X*iMah;
VERS[f].LOC.Y:=VERS[f].LOC.Y*iMah;
VERS[f].LOC.Z:=VERS[f].LOC.Z*iMah;
end;
for f:=1 to KolE do ELES[f].E_MASH(iMah);
end;
procedure   TOBJ.O_MATH;// Перевычисление обьекта
var f:Longint;
begin
// Вычилсяю минимальные и максимальные значения вложеных элемнтов
E_Math;// Получаю Мат      Координаты
O_SREA;// Получаю Реальные Координаты
O_SECR;// Получаю Экранные координаты
O_GABA;// Вычисление габаритов
for f:=1 to KOlP do PLOS[f].P_GABA;// ВЫчисление габаритов плоскостей
for f:=1 to KOlL do LINS[f].L_GABA;// ВЫчисление габаритов Линий
O_RAST;// ВЫчисление растояний
end;
procedure   TOBJ.O_SREA;// Вычисление Реальных координат
var f:Longint;
begin
inherited E_SREA;// Вычисление Реальных координат вершин и вложеных элементов
For F:=1 to KOlP do With PLOS[f] do REA:=SerRCs3(VERS[1].REA,VERS[3].REA);
For F:=1 to KOlL do With LINS[f] do REA:=SerRCs3(VERS[1].REA,VERS[2].REA);
end;
procedure   TOBJ.O_SECR;// Вычисление Экранных координат
var f:Longint;
begin
inherited E_SECR;
for f:=1 to KolP do with PLOS[F] do ECR:=SerRCS3(ECR,REA);
for f:=1 to KolL do with LINS[F] do ECR:=SerRCS3(ECR,REA);
end;
procedure   TOBJ.O_SWAP;// Вычисление Экранных координат
begin
inherited E_SWAP;
end;

procedure   TOBJ.O_INIC;// Вычисление Экранных координат
var f:Longint;
begin
inherited E_INIC;
for f:=1 to KolP do with PLOS[F] do ECR:=REA;
for f:=1 to KolL do with LINS[F] do ECR:=REA;
end;
procedure   TOBJ.O_RAST;// Вычисление Растояний от камеры
var f:Longint;
begin
inherited E_RAST;// Вычисление растоний от элементов и вершин
RAS:=RasRCS3(REA,CaP2);// Вычисление растояний от камеры до обьекта
// Вычисление растояния от камеры до плоскостей
for f:=1 to KolP do With PLoS[f] do begin
REA:=SerRCS3(Vers[1].REA,Vers[3].REA);
RAS:=RasRCS3(REA,CaP2);
end;
// Вычисление растояния от камеры до Линий
for f:=1 to KolL do With LinS[f] do begin
REA:=SerRCS3(Vers[1].REA,Vers[2].REA);
RAS:=RasRCS3(REA,CaP2);
end;


end;

procedure   TOBJ.O_Rabo;// Работа Обьекта
begin

end;
Procedure   TOBJ.O_Gaba;// Вычислене габаритов
begin
E_GABA;
end;

Constructor TOBJ.Create;// Конструктор
begin
inherited Create;
TIP:=T_OBJ;
Kadr:=1;
OBJ:=Self;
KolL:=0;
KolP:=0;
KolD:=0;
OBJ:=Self;
ELE:=Self;
OGRA:=false;
COM:=False;// Обьект собран и готов к отрисовке и работе
end;
Destructor  Tobj.Destroy;
begin
inherited Destroy;
end;

Procedure   TOBJS.Ras;
var f:Longint;
begin
for f:=1 to KolO do
OBJS[f].O_Rast;
end;
procedure   TOBJS.AddD(iObj:TOBJ);
Var F:Longint;
begin
   if not iOBJ.Del then begin
   I_SetSel(iObj,false);// Снимаю выделение если оно есть
   iOBJ.Del:=true;
   for f:=1 to iOBJ.KolL do if not iOBJ.Lins[f].del Then
   MirLins.AddD(iOBJ.Lins[f]);// Удалене Линий
   for f:=1 to iOBJ.KolP do if not iOBJ.Plos[f].del Then
   MirPLos.AddD(iOBJ.Plos[f]);// Удалене плоскостией
   for f:=1 to iOBJ.KolD do if not iOBJ.Dels[f].del Then
   MirObjs.AddD(iOBJ.Dels[f]);// Удаление зависимых обьек
   for f:=1 to iOBJ.KOlV do if not iOBJ.Vers[f].del Then
   MirVers.addD(iOBJ.VERS[f]);// Вершины на удаление
   for f:=1 to iOBJ.KolE do if not iOBJ.Eles[f].del Then
   MirEles.AddD(iOBJ.Eles[f]);// Удаление элементов
   if KolD+1>MaxKolDelObjs then
   ERR('МАсив с удаленными ОБьектами переполнен');
   DELO[KolD+1]:=iOBJ;
   KolD:=KolD+1;
   end else ERR('Попытка удалить уже удаленный обьект');
end;
function    TOBJS.AddO(iOBJ:TOBJ):Tobj;
var F:Longint;Ex:Boolean;
begin
Ex:=False;
//------------------------------------------------------------------------------
if KolD>MinKolDelObjs then begin Ex:=True;
iObj.Nom:=DelO[1].NOM;
OBJS[iObj.Nom]:=iObj;
DelO[1].Free;
for f:=1 to KolD-1 Do DelO[F]:=DelO[F+1];
KOlD:=KolD-1;
end;
//------------------------------------------------------------------------------
if Not Ex then Begin
if KolO+1>MaxkolObjinMir Then
ERR(' TOBJS.AddO(iOBJ:TOBJ) KolO+1>MaxkolObjinMir');
iOBJ.Nom:=KolO+1;
KolO:=KolO+1;
OBJS[iOBJ.Nom]:=iOBJ;
end;
AddO:=Iobj;
end;
Constructor TOBJS.Create;
begin
KolO:=0;
KolD:=0;
end;

{%EndRegion}
var   {Буфер обмена           ===========================}{%Region /FOLD }
                                                           Reg10:Longint;

TYpe TSels=class // Список выделеных примитивов

KOl:Longint;// Количество выделеных примитивов
SELS:array [1..MaxKolSelPris]  of Tver;// Списко выделеных примитивов

procedure ADD(iSel:Tver);// Добавляет примитив в списко выделеных
procedure DEL(iSel:Tver);// Снимает  выделение с примитива
function  EST(iSel:Tver):Longint;// Возвращет номер в списке выделеных примитиво

function  SELVERS:TSels;// Возвращает Список выделеных Вершин
function  SELLINS:TSels;// Возвращает Список выделеных Линий
function  SELPLOS:TSels;// Возвращает Список выделеных Плоскостей
function  SELELES:TSels;// Возвращает Список выделеных Элементов
function  SELOBJS:TSels;// Возвращает Список выделеных Обьект
constructor Create;

end;
var MirSels:TSels;// Буфер обмена
constructor TSels.Create;
begin
Kol:=0;
end;
function  TSels.EST(iSel:Tver):Longint;// Возвращет номер в выделеных
var f,Rez:Longint;
begin
 Rez:=0;F:=1;
 while (f<=Kol) and (Rez=0) do
 if iSel=Sels[f] then Rez:=f else f:=f+1;
 EST:=Rez;
end;
procedure TSels.ADD(iSel:Tver);// Добавляет примитив в списко выделеных
var
F:Longint;
begin

if KOl+1>MaxKolSelPris then // Проверка на переполнение
ERR(' TSels.ADD(iSel:Tver) KOl+1>MaxKolSel ');
Del(iSel);
for f:=Kol downto 1 do SELS[f+1]:=SELS[f];
iSel.Sel:=true;// Ставлю фоаг что обьект выделен
SELS[1]:=iSel;// Добавляю обьект в списко
KOl:=KOl+1;// Увеличиваю количество выделеных обьектов

end;
procedure TSels.DEL(iSel:Tver);// Снимает  выделение с примитива
var Nom,f:Longint;
begin

  Nom:=EST(iSel);// Нахожу элемент в списке выделеных
  if Nom<>0 then begin // если он такм есть
  ISel.Sel:=False;// Снимаю ылаг выделения
  for f:=Nom to KOl-1 do Sels[f]:=Sels[f+1];
  Kol:=KOl-1;// Уменьшая количество выделенх примитивов
  end;

end;

function  TSels.SELVERS:TSels;// Возвращает Список выделеных Вершин
var Rez:TSels;f:Longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=T_VER) then REz.Add(SELS[f]);
 SELVERS:=Rez;
end;
function  TSels.SELLINS:TSels;// Возвращает Список выделеных Линий
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=T_LIN) then REz.Add(SELS[f]);
 SELLINS:=Rez;
end;
function  TSels.SELPLOS:TSels;// Возвращает Список выделеных Плоскостей
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=T_PLO) then REz.Add(SELS[f]);
 SELPLOS:=Rez;
end;
function  TSels.SELELES:TSels;// Возвращает Список выделеных Элементов
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=T_ELE) then REz.Add(SELS[f]);
 SELELES:=Rez;
end;
function  TSels.SELOBJS:TSels;// Возвращает Список выделеных ОБьектов
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=T_OBJ) then REz.Add(SELS[f]);
 SELOBJS:=Rez;
end;

{%EndRegion}
var   {ГРавитация             ===========================}{%Region /FOLD }
                                                           Reg1G:Longint;

function  VhoditObjObj(iPer,iObj:TObj):Boolean;
var Rez:Boolean;
begin
Rez:=False;
if Vhodit3D(iPer.REA,iObj.GMin,iObj.GMin) then
if (iPer.GOB=Nil)or(iPer.GOB.OB3>iObj.OB3)then rez:=true;
VhoditObjObj:=REz;
end;
function  VhoditObjPlo(iPer:TObj;iPLo:TPlo):Boolean;
var Rez:Boolean;
begin
Rez:=False;
if Vhodit3D(iPer.REA,iPlo.GMin,iPLo.GMin) then
if (iPer.GPL=Nil)or(iPer.GPL.OB3>iPLo.OB3)then rez:=true;
VhoditObjPlo:=REz;
end;
procedure Grav;
var fo,fg:Longint;
begin
//------------------------------------------------------------------------------
for fo:=1 to MirObjs.KOlO do
if not MirObjs.Objs[fo].OGRA then for fg:=1 to MirObjs.KOlO do
if     MirObjs.Objs[fg].OGRA then
if VhoditObjObj(MirObjs.Objs[fo],MirObjs.Objs[Fg]) then
begin
if MirObjs.Objs[fo].GOb<>Nil Then
TObj(MirObjs.Objs[fo].GOb).DelDels(MirObjs.Objs[fo]);
MirObjs.Objs[Fg].AddDels(MirObjs.Objs[fo]);
MirObjs.Objs[fo].Gob:=MirObjs.Objs[Fg];
end;
//------------------------------------------------------------------------------
for fo:=1 to MirObjs.KOlO do
if MirObjs.Objs[fo].GOb<>Nil Then
for fg:=1 to TObj(MirObjs.Objs[fo].GOb).KOlP do
if  VhoditObjPlo(MirObjs.Objs[fo],TObj(MirObjs.Objs[fo].GOb).PLOS[fg]) then
MirObjs.Objs[fo].Gpl:=TObj(MirObjs.Objs[fo].GOb).PLOS[fg];
MirObjs.Objs[fo].LOC.Y:=
TObj(MirObjs.Objs[fo].GOb).PLOS[fg].P_Viso(MirObjs.Objs[fo].LOC);
//------------------------------------------------------------------------------
end;

{%EndRegion}
var   {Маршрутизация          ===========================}{%Region /FOLD }
                                                           Reg1M:Longint;
procedure GoGo;
begin

end;


{%EndRegion}
var   {ПРограмирваоние        ===========================}{%Region /FOLD }
                                                           Reg1P:Longint;
procedure Prog;
begin

end;


{%EndRegion}

{%EndRegion}
var   {Интерфейс редактора    ===========================}{%Region /FOLD }
                                                           Reg11:Longint;

var   {----------------------- Возавращает списки     ===}{%Region /FOLD }
                                                          A_Reg11:Longint;
function  I_FinNam(iEle:TEle;iNam:Ansistring):TVer;
var REz:TVer;f:longint;
begin
rez:=Nil;
if iEle.Nam=iNam Then REz:=iEle;        // Смотрю свое имя
//-------------------------------------------------
if (Rez=Nil) and (iEle.TIP=T_OBJ)  Then // Ищу среди Плоскостей
for f:=1 to TObj(iEle).KolP do
if TObj(iEle).PLOS[f].NAM=iNAm then REz:=TObj(iEle).PLOS[f];
//-------------------------------------------------
if (Rez=Nil) and (iEle.TIP=T_OBJ)  Then // Ищу среди Линий
for f:=1 to TObj(iEle).KolL do
if TObj(iEle).ELES[f].NAM=iNAm then REz:=TObj(iEle).ELES[f];
//-------------------------------------------------
if Rez=Nil Then for f:=1 to iEle.KolV do // Ищу среди вершин
if iEle.VERS[f].NAM=iNam then REz:=iEle.VERS[f];
//-------------------------------------------------
f:=1;
while (f<=iEle.KolE) and (REz=Nil) do begin // Ищу среди Элементов
 REz:=I_FinNam(iEle.ELES[f],inam);f:=f+1;
end;
//-------------------------------------------------
I_FinNam:=Rez;
end;
function  I_FinNam(iNam:Ansistring):TVer;
var
REz:TVer;
f:longint;
begin
REz:=Nil;f:=1;
while (f<=MirObjs.KolO) and (REz=Nil) do begin
Rez:=I_FinNam(MirObjs.OBJS[f],iNAm);f:=f+1;
end;
I_FinNam:=Rez;
end;
function  I_NewNamIdd(iStr:Ansistring):Ansistring;
begin
while (I_FinNam(iStr+IntToStr(GIDD))<>nil) do
GIDD:=GIDD+1000;
I_NewNamIdd:=iStr+IntToStr(GIDD);
end;

procedure I_RefSpiVers(iEle:POinter;iLis:TCheckListBox);//Список вершин
var
f:longint;// Для циклов
rEle:TEle;
NomItems:Longint;
begin
rEle:=TEle(iEle);
NomItems:=0;// Для перебора Вершин в списке
for f:=1 to rEle.KolV do
if Not rEle.VERS[f].DEL then begin // Если Вершина не удалён
NomItems:=NomItems+1;
     if NomItems<iLis.Items.count then begin

     iLis.selected[NomItems]:=rEle.VERS[f].Sel;
     iLis.Items[NomItems]:=rEle.VERS[f].NAM;
     iLis.Items.Objects[NomItems]:=rEle.VERS[f];

     end
     else begin
     iLis.Items.AddObject(rEle.VERS[f].Nam,rEle.VERS[f]);
     iLis.selected[iLis.Count-1]:=rEle.VERS[f].Sel;
     end
end;

// Удаляем лишнии записи в конце списка
while iLis.count-1>NomItems do
iLis.items.delete(iLis.count-1);
end;
procedure I_RefSpiLins(iObj:POinter;iLis:TCheckListBox);//Список  Линий
var
f:longint;// Для циклов
rObj:TObj;
NomItems:Longint;
begin
rObj:=TObj(iObj);
NomItems:=0;// Для перебора Линий в списке
for f:=1 to rObj.KolL do
if Not rObj.LinS[f].DEL then begin // Если Линия не удалён
NomItems:=NomItems+1;
     if NomItems<iLis.Items.count then begin

     iLis.selected[NomItems]:=rObj.LINS[f].Sel;
     iLis.Items[NomItems]:=rObj.LINS[f].NAM;
     iLis.Items.Objects[NomItems]:=rObj.LINS[f];

     end
     else begin
     iLis.Items.AddObject(rObj.LINS[f].Nam,rObj.LINS[f]);
     iLis.selected[iLis.Count-1]:=rObj.LINS[f].Sel;
     end
end;

// Удаляем лишнии записи в конце списка
while iLis.count-1>NomItems do
iLis.items.delete(iLis.count-1);
end;
procedure I_RefSpiPlos(iObj:POinter;iLis:TCheckListBox);//Список Плоско
var
f:longint;// Для циклов
rObj:TObj;
NomItems:Longint;
begin
rObj:=TObj(iObj);
NomItems:=0;// Для перебора Плоскостей в списке
for f:=1 to rObj.KolP do
if Not rObj.PLOS[f].DEL then begin // Если рлоскостей не удалён
NomItems:=NomItems+1;
     if NomItems<iLis.Items.count then begin

     iLis.selected[NomItems]:=rObj.PLOS[f].Sel;
     iLis.Items[NomItems]:=rObj.PLOS[f].NAM;
     iLis.Items.Objects[NomItems]:=rObj.PLOS[f];

     end
     else begin
     iLis.Items.AddObject(rObj.PLOS[f].Nam,rObj.PLOS[f]);
     iLis.selected[iLis.Count-1]:=rObj.PLOS[f].Sel;
     end
end;

// Удаляем лишнии записи в конце списка
while iLis.count-1>NomItems do
iLis.items.delete(iLis.count-1);
end;
procedure I_RefSpiEles(iEle:POinter;iLis:TCheckListBox);//Список Элемен
var
f:longint;// Для циклов
rEle:TEle;
NomItems:Longint;
begin
rEle:=TEle(iEle);
NomItems:=0;// Для перебора обье4ктов в списке
for f:=1 to rEle.KolE do
if Not rEle.ELES[f].DEL then begin // Если обьект не удалён  begin
NomItems:=NomItems+1;
     if NomItems<iLis.Items.count then begin

     iLis.selected[NomItems]:=rEle.ELES[f].Sel;
     iLis.Items[NomItems]:=rEle.ELES[f].NAM;
     iLis.Items.Objects[NomItems]:=rEle.ELES[f];

     end
     else begin
     iLis.Items.AddObject(rEle.ELES[f].Nam,rEle.ELES[f]);
     iLis.selected[iLis.Count-1]:=rEle.ELES[f].Sel;
     end
end;

// Удаляем лишнии записи в конце списка
while iLis.count-1>NomItems do
iLis.items.delete(iLis.count-1);
end;
procedure I_RefSpiObjs(             iLis:TCheckListBox);//Список обьект
var
f:longint;// лдя циклов
NomItems:Longint;// Перебирать записи в листбоксе
begin
NomItems:=0;// Для перебора обье4ктов в списке
for f:=1 to MirObjs.KolO do
if Not MirObjs.OBJS[f].DEL then begin // Если обьект не удалён
NomItems:=NomItems+1;
if NomItems<iLis.Items.count then begin
// Изменяем записи в списке только если обьект в списке изменился
   iLis.selected[NomItems]:=MirObjs.OBJS[f].Sel;
   //form4.CheckListBox6.Checked[NomItems]:=MirObjs.OBJS[f].Sel;
   iLis.Items[NomItems]:=MirObjs.OBJS[f].NAM;
if iLis.Items.Objects[NomItems]<>MirObjs.OBJS[f] then
   iLis.Items.Objects[NomItems]:=MirObjs.OBJS[f];
end
else
begin
iLis.Items.AddObject(MirObjs.OBJS[f].Nam,MirObjs.OBJS[f]);
iLis.selected[iLis.Count-1]:=MirObjs.OBJS[f].Sel;
end

end;

// Удаляем лишнии записи в конце списка
while iLis.count-1>NomItems do
iLis.items.delete(iLis.count-1);


end;
procedure I_RefAllForm;
var f:Longint;
begin

     for f:=0 to application.ComponentCount-1 do
     if  (application.Components[f] is tform5 ) then begin
     I_RefSpiObjs((application.Components[f] as tform5) .CheckListBox1);
     end
else if  (application.Components[f] is tform6 ) then begin
     (application.Components[f] as tform6 ).U_RefreshObj;
     end
else if  (application.Components[f] is tform7 ) then begin
     (application.Components[f] as tform7 ).U_RefreshEle;
     end
else if  (application.Components[f] is tform8 ) then begin
     (application.Components[f] as tform8 ).U_RefreshVer;
     end
else if  (application.Components[f] is tform9 ) then begin
     (application.Components[f] as tform9 ).U_RefreshLin;
     end
else if  (application.Components[f] is tform10) then begin
     (application.Components[f] as tform10).U_RefreshPlo;
     end

end;

{%EndRegion}
var   {----------------------- Set и GET              ===}{%Region /FOLD }
                                                          B_Reg11:Longint;

procedure I_RefreshActivePrimitiv;
begin
with form4 do
if (ACT=NIL) or (TVER(ACT).del)
Then begin // Если нету активного элмеента либо он удалён
edit1.Enabled:=false;
edit2.Enabled:=false;
edit3.Enabled:=false;
edit4.Enabled:=false;
edit5.Enabled:=false;
edit6.Enabled:=false;
edit7.Enabled:=false;
edit8.Enabled:=false;
end
else begin // Если Есть выбраный активный элемент

// Читаюю координатиы
if(TVer(Act).TIP=T_VER)or(TVer(Act).TIP=T_ELE)or(TVer(Act).TIP=T_OBJ)
then begin
edit1.Enabled:=true;I_GETX(Act,Edit1);
edit2.Enabled:=true;I_GETY(Act,Edit2);
edit3.Enabled:=true;I_GETZ(Act,Edit3);
edit7.Enabled:=true;I_GETC(Act,Edit7);
edit8.Enabled:=true;I_GETA(Act,Edit8);
end;
// Читаюю углы наклона
if (TVer(Act).TIP=T_ELE)or(TVer(Act).TIP=T_OBJ)
then begin // Включаю углы наклона
I_GEUX(Act,Edit4);edit4.Enabled:=true;
I_GEUY(Act,Edit5);edit5.Enabled:=true;
I_GEUZ(Act,Edit6);edit6.Enabled:=true;
end
else begin // Отключаю углы наклона
edit4.Enabled:=false;
edit5.Enabled:=false;
edit6.Enabled:=false;
end;

end;
end;
procedure I_RefreshEditorPrimitiv(iVer:Pointer);
var
 form5:TForm5;
 form6:TForm6;
 form7:TForm7;
 form8:TForm8;
begin
 form5 :=I_FindFormObjs      ;if Form5 <>nil Then begin // Обьекты
 Form5.U_RefreshObjs;
 end;
 form6 :=I_FindFormObj (iver);if Form6 <>nil Then begin //  Обьект
 Form6.U_RefreshObj;
 end;
 form7 :=I_FindFormEle (iver);if Form7 <>nil Then begin // Эдемент
 Form7.U_RefreshEle;
 I_RefreshEditorPrimitiv(TEle(iver).Ele);
 end;
 form8 :=I_FindFormVer (iver);if Form8 <>nil Then begin // Вершина
 Form8.U_RefreshVer;
 I_RefreshEditorPrimitiv(TVer(iver).Ele);
 end;
 form9 :=I_FindFormLin (iver);if Form9 <>nil Then begin //   Линия
 Form9.U_RefreshLin;
 I_RefreshEditorPrimitiv(TLin(iver).Ele);
 end;
 form10:=I_FindFormPlo (iver);if Form10<>nil Then begin // Плоскос
 Form10.U_RefreshPlo;
 I_RefreshEditorPrimitiv(TPlo(iver).Ele);
 end;
end;

procedure I_GetN(iVer:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>TVEr(iVer).NAM then
   iEdit.Text:=TVEr(iVer).NAM;

end;
procedure I_GetX(iVer:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TVEr(iVer).LOC.X) then begin
iEdit.Text:=InString(TVEr(iVer).LOC.X);
end;
end;
procedure I_GetY(iVer:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TVEr(iVer).LOC.Y) then begin
iEdit.Text:=InString(TVEr(iVer).LOC.Y);
end;
end;
procedure I_GetZ(iVer:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TVEr(iVer).LOC.Z) Then begin
iEdit.Text:=InString(TVEr(iVer).LOC.Z);
end;
end;
procedure I_GetC(iVer:Pointer;iEdit:TEdit);
var
lCol:Rcol;
begin
lCol:=TVEr(iVer).Col;
if iEdit.Text<>InString(RColRGBtoInt(TVEr(iVer).COL)) then begin
iEdit.Color:=RGBToColor(lCOL.R,lCOL.G,lCOL.B);
iEdit.Text:=InString(RColRGBtoInt(TVEr(iVer).COL));
end;
end;
procedure I_GetA(iVer:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TVEr(iVer).Col.A) Then begin
iEdit.Text:=InString(TVEr(iVer).Col.A);
end;
end;
procedure I_GeUX(iEle:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TEle(iEle).EUGL.X) then begin
iEdit.Text:=InString(TEle(iEle).EUGL.X);
end;
end;
procedure I_GeUY(iEle:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TEle(iEle).EUGL.Y) then begin
iEdit.Text:=InString(TEle(iEle).EUGL.Y);
end;
end;
procedure I_GeUZ(iEle:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TEle(iEle).EUGL.Z) then begin
iEdit.Text:=InString(TEle(iEle).EUGL.Z);
end;
end;

procedure I_SetN(iVer:Pointer;iEdit:TEdit);
begin
if (TVEr(iVer).NAM<>iEdit.Text) Then begin

if I_FinNam(iEdit.Text)=nil
   then begin
   G_Change:=true;
   TVEr(iVer).NAM:=iEdit.Text;
   iEdit.Color:=clDefault;
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iVer);
   end
   else begin
   iEdit.Color:=RGBToColor(255,0,0)
   end;

end;
end;
procedure I_SetX(iVer:Pointer;iEdit:TEdit);
begin
if isFloat(iEdit.Text) then
if iEdit.Text<>InString(TVEr(iVer).Loc.X) then begin
   G_Change:=true;
   TVEr(iVer).Loc.X:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iVer);
end;
end;
procedure I_SetY(iVer:Pointer;iEdit:TEdit);
begin
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TVEr(iVer).Loc.Y) then begin
   G_Change:=true;
   TVEr(iVer).Loc.Y:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iVer);
end;
end;
procedure I_SetZ(iVer:Pointer;iEdit:TEdit);
begin
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TVEr(iVer).Loc.Z) then begin
   G_Change:=true;
   TVEr(iVer).Loc.Z:=inFloat(iEdit.Text);
   I_RefreshEditorPrimitiv(iVer);
end;
end;
procedure I_SetC(iVer:Pointer;iEdit:TEdit);
begin
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(RColRgbToInt(TVEr(iVer).COL))  then begin

   G_Change:=true;
   TVEr(iVer).COL.R:=Red  (trunc(inFloat(iEdit.Text)));
   TVEr(iVer).COL.G:=Green(trunc(inFloat(iEdit.Text)));
   TVEr(iVer).COL.B:=Blue (trunc(inFloat(iEdit.Text)));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iVer);

end;

end;
procedure I_SetA(iVer:Pointer;iEdit:TEdit);
begin
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TVEr(iVer).COL.A) then begin

   G_Change:=true;
   TVEr(iVer).COL.A:=trunc(inFloat(iEdit.Text));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iVer);

end;
end;
procedure I_SeUX(iEle:Pointer;iEdit:TEdit);
begin
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TEle(iEle).EUGL.X) then begin

   G_Change:=true;
   TEle(iEle).EUGL.X:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iEle);

end;
end;
procedure I_SeUY(iEle:Pointer;iEdit:TEdit);
begin
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TEle(iEle).EUGL.Y) then begin

   G_Change:=true;
   TEle(iEle).EUGL.Y:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iEle);

end;
end;
procedure I_SeUZ(iEle:Pointer;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TEle(iEle).EUGL.Z)  then begin

   G_Change:=true;
   TEle(iEle).EUGL.Z:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iEle);

end;
end;


{%EndRegion}
var   {----------------------- Отрисовкка примитивов  ===}{%Region /FOLD }
                                                          C_Reg11:Longint;
procedure I_DrCub(GMin,GMAX:RCS3);
begin
glVertex3f(GMin.X,GMin.Y,GMin.Z);
glVertex3f(GMin.X,GMAx.Y,GMin.Z);

glVertex3f(GMAX.X,GMin.Y,GMin.Z);
glVertex3f(GMAX.X,GMAx.Y,GMin.Z);

glVertex3f(GMAX.X,GMin.Y,GMAX.Z);
glVertex3f(GMAX.X,GMAx.Y,GMAX.Z);

glVertex3f(GMin.X,GMin.Y,GMAX.Z);
glVertex3f(GMin.X,GMAx.Y,GMAX.Z);


glVertex3f(GMin.X,GMin.Y,GMin.Z);
glVertex3f(GMax.X,GMin.Y,GMin.Z);

glVertex3f(GMin.X,GMax.Y,GMin.Z);
glVertex3f(GMax.X,GMax.Y,GMin.Z);

glVertex3f(GMin.X,GMax.Y,GMax.Z);
glVertex3f(GMax.X,GMax.Y,GMAx.Z);

glVertex3f(GMin.X,GMin.Y,GMax.Z);
glVertex3f(GMax.X,GMin.Y,GMAx.Z);


glVertex3f(GMin.X,GMin.Y,GMin.Z);
glVertex3f(GMin.X,GMin.Y,GMax.Z);

glVertex3f(GMax.X,GMin.Y,GMin.Z);
glVertex3f(GMAx.X,GMin.Y,GMax.Z);

glVertex3f(GMax.X,GMax.Y,GMin.Z);
glVertex3f(GMAx.X,GMax.Y,GMax.Z);

glVertex3f(GMin.X,GMax.Y,GMin.Z);
glVertex3f(GMin.X,GMax.Y,GMax.Z);
end;

procedure I_DrVer(iVer:TVer;iCol:RCol);// Вывод вершины
begin
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_POINTS);
glVertex3f(iVer.ECR.X,iVer.ECR.Y,iVer.ECR.Z);
glEnd();
end;
procedure I_DrLin(iLin:TLin;iCol:RCol);// Вывод Линии
var C:RCol;
begin
C:=iLin.Col;
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_LINES);
I_DrCub(iLin.GMin,iLin.GMax);
glEnd();
end;
procedure I_DrPlo(iPlo:TPlo;iCol:RCol);// Вывод Плоскости
var C:RCol;
begin
C:=iPlo.Col;
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_LINES);
I_DrCub(iPLo.GMin,iPLo.GMax);
glEnd();
end;
procedure I_DrEle(iEle:TEle;iCol:RCol);// Вывод Элемента
var C:RCol;
begin
C:=iEle.Col;
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_LINES);
I_DrCub(iEle.GMin,iEle.GMax);
glEnd();
end;
procedure I_DrObj(iObj:TObj;iCol:RCol);// Вывод ОБьекта
begin
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_LINES);
I_DrCub(iObj.GMin,iObj.GMax);
glEnd();
end;

{%EndRegion}

var   {----------------------- Добавлоение примитива  ===}{%Region /FOLD }
                                                          E_Reg11:Longint;

function I_GetEl(iVer:Pointer):Tele;// Извлекает Элемен в котором находимся
var REz:Tele;lVer:TVer;
begin
      lVer:=TVer(iVer);
      if lVer=nil then ERR(' I_GetEl iVer=nil  ') else
      if lVer.TIP=T_VER Then Rez:=TEle(lVer.Ele) else
      if lVer.TIP=T_LIN Then Rez:=TEle(lVer.Ele) else
      if lVer.TIP=T_PLO Then Rez:=TEle(lVer.Ele) else
      if lVer.TIP=T_ELE Then Rez:=TEle(lVer) else
      if lVer.TIP=T_OBJ Then Rez:=TEle(lVer) else
      ERR(' I_GetEl last else ');
      I_GetEl:=Rez;

end;
function I_GetOb(iVer:Pointer):TObj;// Извлекает Обьект в котором находимся
var REz:TObj;lVer:TVer;
begin

      lVer:=TVer(iVer);
      if lVer=nil then ERR(' I_GetOb iVer=nil  ') else
      if lVer.OBJ.TIP=T_OBJ Then Rez:=TObj(lVer.OBJ) else
      ERR(' I_GetOb iVer.OBJ.TIP<>T_OBJ ');
      I_GetOb:=Rez;

end;
function I_AddVerCOP(iEle:Pointer):Pointer;// Создает копию вершины рядом
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x+(MinRAsInMir/10),
             TVER(iEle).LOC.y+(MinRAsInMir/10),
             TVER(iEle).LOC.z+(MinRAsInMir/10));
nVer.Nam:=I_NewNamIdd('V ');
I_RefAllForm;
I_AddVerCOP:=nVer;
end;
function I_AddVerSYX(iEle:Pointer):Pointer;// Создает симетричную вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x*-1,TVER(iEle).LOC.y,TVER(iEle).LOC.z);
nVer.Nam:=I_NewNamIdd('V ');
I_RefAllForm;
I_AddVerSYX:=nVer;
end;
function I_AddVerSYY(iEle:Pointer):Pointer;// Создает симетричную вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x,TVER(iEle).LOC.y*-1,TVER(iEle).LOC.z);
nVer.Nam:=I_NewNamIdd('V ');
I_RefAllForm;
I_AddVerSYY:=nVer;
end;
function I_AddVerSYZ(iEle:Pointer):Pointer;// Создает симетричную вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x,TVER(iEle).LOC.y,TVER(iEle).LOC.z*-1);
nVer.Nam:=I_NewNamIdd('V ');
I_RefAllForm;
I_AddVerSYZ:=nVer;
end;
function I_AddVer(iEle:Pointer):Pointer;// Добавляет Вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(0,0,0);
nVer.Nam:=I_NewNamIdd('V ');
I_RefAllForm;
I_AddVer:=nVer;
end;
function I_AddLin(iObj:Pointer):Pointer;// Доабвляет   Линию
Var
rObj:TObj;
nLin:TLin;
lSel:TSels;
begin
G_Change:=true;
lSel:=MirSels.SELVERS;
if lSel.KOl>=2 Then begin
rObj:=I_GetOb(iObj);
nLin:=rObj.L(lSel.SELS[2],
             lSel.SELS[1]);
nLin.Nam:=I_NewNamIdd('L ');
end;
lSel.free;
I_RefAllForm;
I_AddLin:=nLin;
end;
function I_AddPlo(iObj:Pointer):Pointer;// Доабвляет Плоскос
Var
rObj:TObj;
nPLo:TPlo;
lSel:TSels;
begin
G_Change:=true;
lSel:=MirSels.SELVERS;
if lSel.KOl>=4 Then begin
rObj:=I_GetOb(iObj);
nPlo:=rObj.P(lSel.SELS[4],
             lSel.SELS[3],
             lSel.SELS[2],
             lSel.SELS[1]);
nPlo.Nam:=I_NewNamIdd('P ');
end;
lSel.free;
I_AddPlo:=nPlo;
end;
function I_AddPPl(iObj:Pointer):Pointer;// Доаб пуст Плоскос
Var
rObj:TObj;
nPLo:TPlo;
begin
G_Change:=true;
rObj:=I_GetOb(iObj);
nPlo:=rObj.P(rObj,rObj,rObj,rObj);
nPlo.Nam:=I_NewNamIdd('P ');
I_AddPPl:=nPlo;
end;
function I_AddEle(iEle:Pointer):Pointer;// Доабвляет Элемент
Var
rEle:TEle;
nEle:TEle;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nEle:=rEle.E(0,0,0);
nEle.Nam:=I_NewNamIDd('E ');
I_AddEle:=nEle;
end;
function I_AddObj:Pointer;// Добавляет новый обьект
Var nObj:TObj;
begin
G_Change:=true;
nObj:=TObj.Create;
nObj.Nam:=I_NewNamiDd('O ');
MirObjs.AddO(nObj);
I_RefAllForm;
I_AddObj:=nObj;
end;

{%EndRegion}
var   {----------------------- Удалание  примитивов   ===}{%Region /FOLD }
                                                          F_Reg11:Longint;

procedure I_DelFormsLin(iLin:TLin);forward;
procedure I_DelFormsPlo(iPlo:TPlo);forward;
procedure I_DelFormsAct(iVer:Tver);//          ЗАкрываем активный элемент
begin
if Tver(form4.Act)=iVer then begin
form4.Act:=Nil;
I_RefreshActivePrimitiv;
end;
end;
procedure I_DelFormsVer(iVer:TVer);// Удаляет форму связаную с   Вершиной
var
f:Longint;
lForm8:TForm8;
begin

        //--------------------------------------------------------------------------
    for f:=0 to application.ComponentCount-1 do
    if  (application.Components[f] is tform9) then
    if  (application.Components[f] as tform9).visible then
    if  (TLIN((application.Components[f] as tform9).LIN).VERS[1]=iVer) or
        (TLIN((application.Components[f] as tform9).LIN).VERS[2]=iVer) then
         I_DelFormsLin(TLIN((application.Components[f] as tform9).LIN));

    for f:=0 to application.ComponentCount-1 do
    if  (application.Components[f] is tform10) then
    if  (application.Components[f] as tform10).visible then
    if  (TPLO((application.Components[f] as tform10).PLO).VERS[1]=iVer) or
        (TPLO((application.Components[f] as tform10).PLO).VERS[2]=iVer) or
        (TPLO((application.Components[f] as tform10).PLO).VERS[3]=iVer) or
        (TPLO((application.Components[f] as tform10).PLO).VERS[4]=iVer) then
         I_DelFormsPLO(TPLO((application.Components[f] as tform10).PLO));
    //--------------------------------------------------------------------------

    lForm8:=I_FindFormVer(iVer);
    while lForm8<>Nil do begin
    lForm8.close;
    lForm8:=I_FindFormVer(iVer);
    end;
end;
procedure I_DelFormsLin(iLin:TLin);// Удаляет форму связаную с     Линией
var
lForm9:TForm9;
begin
    lForm9:=I_FindFormLin(iLin);
    while lForm9<>Nil do begin
    lForm9.close;
    lForm9:=I_FindFormLin(iLin);
    end;
end;
procedure I_DelFormsPlo(iPlo:TPlo);// Удаляет форму связаную с Плоскостью
var
lForm10:TForm10;
begin
    lForm10:=I_FindFormPlo(iPlo);
    while lForm10<>Nil do begin
    lForm10.close;
    lForm10:=I_FindFormPlo(iPlo);
    end;
end;
procedure I_DelFormsEle(iEle:TEle);// Удаляет форму связаную с  Элементом
var
f:Longint;
lForm7:TForm7;
begin
    for f:=1 to iEle.KolV do I_DelFormsVer(iEle.VERS[F]);
    for f:=1 to iEle.KolE do I_DelFormsEle(iEle.ELES[F]);
    lForm7:=I_FindFormEle(iEle);
    while lForm7<>Nil do begin
    lForm7.close;
    lForm7:=I_FindFormEle(iEle);
    end;
end;
procedure I_DelFormsObj(iObj:TObj);// Удаляет форму связаную с   Обьектом
var
f:Longint;
lForm6:TForm6;
begin
    for f:=1 to iObj.KolV do I_DelFormsVer(iObj.VERS[F]);
    for f:=1 to iObj.KolL do I_DelFormsLin(iObj.LINS[F]);
    for f:=1 to iObj.KolP do I_DelFormsPlo(iObj.PLOS[F]);
    for f:=1 to iObj.KolE do I_DelFormsEle(iObj.ELES[F]);
    lForm6:=I_FindFormObj(iObj);
    while lForm6<>Nil do begin
    lForm6.close;
    lForm6:=I_FindFormObj(iObj);
    end;
end;

procedure I_DelVer(iVer:POinter);// Удаление Вершины
begin
G_Change:=true;
I_DelFormsVer(Tver(iVer));
MirVers.AddD(Tver(iVer));
I_RefAllForm;
end;
procedure I_DelLin(iLin:POinter);// Удаление   Линии
begin
G_Change:=true;
I_DelFormsLin(TLin(iLin));
MirLins.AddD(TLin(iLin));
I_RefAllForm;
end;
procedure I_DelPLo(iPlo:POinter);// Удаление Плоскос
begin
G_Change:=true;
I_DelFormsPlo(TPlo(iPlo));
MirPlos.AddD(TPlo(iPlo));
I_RefAllForm;
end;
procedure I_DelEle(iEle:POinter);// Удаление Элемент
begin
G_Change:=true;
I_DelFormsEle(Tele(iEle));
MirEles.AddD(Tele(iEle));
I_RefAllForm;
end;
procedure I_DelObj(iObj:POinter);// Удаление Обьекта
begin
G_Change:=true;
I_DelFormsObj(TObj(iObj));
MirObjs.AddD(TObj(iObj));
I_RefAllForm;
end;

{%EndRegion}
var   {----------------------- ПОиск примитива        ===}{%Region /FOLD }
                                                           G_Reg11:Longint;

function  I_FIN_OBJ(          iNam:Ansistring):TObj;// Ищит Обьект
var
Rez:Tobj;
F:Longint;
begin
          rez:=Nil;
          f:=1;while(f<=MirObjs.KOlO)and(REz=NIl)do
          if (not MirObjs.OBJS[f].DEL) and (MirObjs.OBJS[f].NAM=iNam)
          then Rez:=MirObjs.OBJS[f]
          else f:=f+1;
          I_FIN_OBJ:=Rez;
end;
function  I_FIN_VER(iObj:TVer;iNam:Ansistring):TVer;// Ищит вершин
//--------------------------------------------------
function  l_fin_ver(iEle:TEle;iNam:Ansistring):Tver;
var Rez:TVer;f:Longint;
begin
     REz:=Nil;
     //--------------------------------------------------------
     f:=1;while (f<=iEle.KolV) and (REz=Nil) do
     if (NOT iEle.VERS[f].DEL) and (iEle.VERS[f].NAM=iNAm)
     Then Rez:=iEle.VERS[f] else f:=f+1;
     //--------------------------------------------------------
     f:=1;while (f<=iEle.KolE) and (Rez=nil) do begin
     if (not iEle.ELES[f].DEL) Then Rez:=L_FIN_VER(iEle.ELES[f],iNam);
     f:=f+1;
     end;
     //--------------------------------------------------------
     L_FIN_VER:=REz;
     end;
begin     I_FIN_VER:=l_fin_ver(TEle(iObj.Obj),iNam);
end;
function  I_FIN_LIN(iObj:Tver;iNam:Ansistring):TLin;// Ищит  Линию
var
f:Longint;
lObj:TObj;
Rez:TLin;
begin
          Rez:=Nil;
          lObj:=TObj(iObj.OBJ);
          f:=1;while(f<=lObj.KolL)and(REz=nil)do
          if lObj.LINS[f].NAM=iNAM
          Then Rez:=lObj.LINS[f] else f:=f+1;
          I_FIN_LIN:=Rez;
end;
function  I_FIN_PLO(iObj:Tver;iNam:Ansistring):TPlo;// Ищит Плоско
var
f:Longint;
lObj:TObj;
Rez:TPLo;
begin
          Rez:=Nil;
          lObj:=TObj(iObj.OBJ);
          f:=1;while(f<=lObj.KolP)and(REz=nil)do
          if lObj.PLOS[f].NAM=iNAM
          Then Rez:=lObj.PLOS[f] else f:=f+1;
          I_FIN_PLO:=Rez;
end;
function  I_FIN_ELE(iObj:Tver;iNam:Ansistring):TEle;// Ищит Элемен
//--------------------------------------------------
function  l_fin_ele(iEle:Tele;iNam:Ansistring):Tele;
var REz:TEle;f:Longint;
begin
 REz:=Nil;
 //--------------------------------------------------------
 f:=1;while(f<=iEle.KOlE)and(REz=Nil)do
 if (NOT iEle.eles[f].DEL) and (iEle.eles[f].NAM=iNAm)
 Then Rez:=iEle.eles[f] else f:=f+1;
 //--------------------------------------------------------
 f:=1;while(f<=iEle.KOlE)and(REz=Nil)do begin
 if (NOT iEle.eles[f].DEL) Then Rez:=l_fin_ele(iEle.eles[f],iNam);
 f:=f+1;end;
 //--------------------------------------------------------
 L_FIN_ELE:=REz;
end;
begin
I_FIN_ELE:=l_fin_ele(TELE(iObj.Obj),iNam);
end;

{%EndRegion}
var   {----------------------- Сохранение примитива   ===}{%Region /FOLD }
                                                           H_Reg11:Longint;


// Сохраниение структуры
Procedure I_TVER_PUT_01(iVer:TVer;var iStr:Ansistring);
begin
iStr:=iStr+'V('+iVer.NAM+')';// Сохраняю имя

iStr:=iStr+'X('+InString(iVer.LOC.X)+')';// Координаты вершины X
iStr:=iStr+'Y('+InString(iVer.LOC.Y)+')';// Координаты вершины Y
iStr:=iStr+'Z('+InString(iVer.LOC.Z)+')';// Координаты вершины Z

iStr:=iStr+'R('+IntToStr(iVer.COL.R)+')';// Цвет Красный
iStr:=iStr+'G('+IntToStr(iVer.COL.G)+')';// Цвет Зеленый
iStr:=iStr+'B('+IntToStr(iVer.COL.B)+')';// Цвет Голубой
iStr:=iStr+'A('+IntToStr(iVer.COL.A)+')';// Прозрачность

iStr:=iStr+CR;

end;
Procedure I_TLIN_PUT_01(iLin:TLin;var iStr:Ansistring);
begin
iStr:=iStr+'L('+iLin.NAM+')';// Сохраняю имя

iStr:=iStr+'R('+IntToStr(iLin.COL.R)+')';// Цвет Красный
iStr:=iStr+'G('+IntToStr(iLin.COL.G)+')';// Цвет Зеленый
iStr:=iStr+'B('+IntToStr(iLin.COL.B)+')';// Цвет Голубой
iStr:=iStr+'A('+IntToStr(iLin.COL.A)+')';// Прозрачность

iStr:=iStr+'e('+iLin.VERS[1].NAm+')';// Вершина 1
iStr:=iStr+'f('+iLin.VERS[2].NAm+')';// Вершина 2

iStr:=iStr+CR;

end;
Procedure I_TPLO_PUT_01(iPlo:TPLo;var iStr:Ansistring);
begin
iStr:=iStr+'P('+iPlo.NAM+')';// Сохраняю имя

iStr:=iStr+'R('+IntToStr(iPlo.COL.R)+')';// Цвет Красный
iStr:=iStr+'G('+IntToStr(iPlo.COL.G)+')';// Цвет Зеленый
iStr:=iStr+'B('+IntToStr(iPlo.COL.B)+')';// Цвет Голубой
iStr:=iStr+'A('+IntToStr(iPlo.COL.A)+')';// Прозрачность

iStr:=iStr+'a('+iPlo.VERS[1].NAm+')';// Вершина 1
iStr:=iStr+'b('+iPlo.VERS[2].NAm+')';// Вершина 2
iStr:=iStr+'c('+iPlo.VERS[3].NAm+')';// Вершина 3
iStr:=iStr+'d('+iPlo.VERS[4].NAm+')';// Вершина 4

iStr:=iStr+CR;

end;
Procedure I_TELE_PUT_01(iEle:TEle;var iStr:Ansistring);
var f:Longint;
begin
iStr:=iStr+'E('+iEle.NAM+')';// Сохраняю имя

iStr:=iStr+'X('+InString(iEle.LOC.X)+')';// Координаты вершины X
iStr:=iStr+'Y('+InString(iEle.LOC.Y)+')';// Координаты вершины Y
iStr:=iStr+'Z('+InString(iEle.LOC.Z)+')';// Координаты вершины Z

iStr:=iStr+'x('+InString(iEle.EUGL.X)+')';// Углы наклона X
iStr:=iStr+'y('+InString(iEle.EUGL.Y)+')';// Углы наклона Y
iStr:=iStr+'z('+InString(iEle.EUGL.Z)+')';// Углы наклона Z

iStr:=iStr+'R('+IntToStr(iEle.COL.R)+')';// Цвет Красный
iStr:=iStr+'G('+IntToStr(iEle.COL.G)+')';// Цвет Зеленый
iStr:=iStr+'B('+IntToStr(iEle.COL.B)+')';// Цвет Голубой
iStr:=iStr+'A('+IntToStr(iEle.COL.A)+')';// Прозрачность

iStr:=iStr+CR;

for f:=1 to iEle.KOlV do
if NOT iEle.Vers[f].DEL THEN I_TVER_PUT_01(iEle.Vers[f],iStr);
for f:=1 to iEle.KOlE do
if NOT iEle.Eles[f].DEL THEN begin
iStr:=iStr+'E('+iEle.NAM+')';// Сохраняю Текущий контекст
I_TELE_PUT_01(iEle.Eles[f],iStr);
end;

end;
Procedure I_TOBJ_PUT_01(iObj:TObj;var iStr:Ansistring);
var f:Longint;
begin
iStr:=iStr+'O('+iObj.NAM+')';// Сохраняю имя

iStr:=iStr+'X('+InString(iObj.LOC.X)+')';// Координаты вершины X
iStr:=iStr+'Y('+InString(iObj.LOC.Y)+')';// Координаты вершины Y
iStr:=iStr+'Z('+InString(iObj.LOC.Z)+')';// Координаты вершины Z

iStr:=iStr+'x('+InString(iObj.EUGL.X)+')';// Углы наклона X
iStr:=iStr+'y('+InString(iObj.EUGL.Y)+')';// Углы наклона Y
iStr:=iStr+'z('+InString(iObj.EUGL.Z)+')';// Углы наклона Z

iStr:=iStr+'R('+IntToStr(iObj.COL.R)+')';// Цвет Красный
iStr:=iStr+'G('+IntToStr(iObj.COL.G)+')';// Цвет Зеленый
iStr:=iStr+'B('+IntToStr(iObj.COL.B)+')';// Цвет Голубой
iStr:=iStr+'A('+IntToStr(iObj.COL.A)+')';// Прозрачность

iStr:=iStr+CR;

for f:=1 to iObj.KOlV do
if NOT iObj.Vers[f].DEL Then I_TVER_PUT_01(iObj.Vers[f],iStr);
for f:=1 to iObj.KOlE do
if NOT iObj.Eles[f].DEL Then begin
iStr:=iStr+'O(self)';// Сохраняю Текущий контекст
I_TELE_PUT_01(iObj.Eles[f],iStr);
end;
for f:=1 to iObj.KOlL do
if NOT iObj.Lins[f].DEL Then I_TLIN_PUT_01(iObj.Lins[f],iStr);
for f:=1 to iObj.KOlP do
if NOT iObj.PLos[f].DEL Then I_TPLO_PUT_01(iObj.Plos[f],iStr);

end;
Procedure I_PRIM_PUT_01(iVer:TVer;var iStr:Ansistring);
begin
if iVer.TIP=T_VER THEN I_TVER_PUT_01(TVer(iVer),iStr) else
if iVer.TIP=T_LIN THEN I_TLIN_PUT_01(TLin(iVer),iStr) else
if iVer.TIP=T_PLO THEN I_TPLO_PUT_01(TPlo(iVer),iStr) else
if iVer.TIP=T_ELE THEN I_TELE_PUT_01(TELE(iVer),iStr) else
if iVer.TIP=T_OBJ THEN I_TOBJ_PUT_01(TObj(iVer),iStr) ;
iStr:=iStr+CR;
iStr:=iStr+CR;
end;
Procedure I_OBJS_PUT_01(var iStr:Ansistring);
var f:Longint;
begin
for f:=1 to MirObjs.KOLO do
if NOT MirObjs.OBJS[f].DEL Then I_TOBJ_PUT_01(MirObjs.OBJS[f],iStr);
iStr:=iStr+CR;
iStr:=iStr+CR;
end;

// Сравнение структур
function  I_RAV_VER(iVer1,iVer2:TVer):Boolean;
var Rez:Boolean;
begin
Rez:=true;
if iver1.LOC.x<>iver2.LOC.x then rez:=false;
if iver1.LOC.y<>iver2.LOC.y then rez:=false;
if iver1.LOC.z<>iver2.LOC.z then rez:=false;
if iver1.COL.R<>iver2.COL.R then rez:=false;
if iver1.COL.G<>iver2.COL.G then rez:=false;
if iver1.COL.B<>iver2.COL.B then rez:=false;
if iver1.COL.A<>iver2.COL.A then rez:=false;
I_RAV_VER:=Rez;
end;
function  I_RAV_ELE(iEle1,iEle2:TEle):Boolean;
var
lVer:Tver;
lEle:Tele;
Rez:Boolean;
F:Longint;
begin
Rez:=true;
//--------------------------------------------
if iEle1.LOC.x <>iEle2.LOC.x  then rez:=false;
if iEle1.LOC.y <>iEle2.LOC.y  then rez:=false;
if iEle1.LOC.z <>iEle2.LOC.z  then rez:=false;
if iEle1.EUGL.x<>iEle2.EUGL.x then rez:=false;
if iEle1.EUGL.y<>iEle2.EUGL.y then rez:=false;
if iEle1.EUGL.z<>iEle2.EUGL.z then rez:=false;
if iEle1.COL.R <>iEle2.COL.R  then rez:=false;
if iEle1.COL.G <>iEle2.COL.G  then rez:=false;
if iEle1.COL.B <>iEle2.COL.B  then rez:=false;
if iEle1.COL.A <>iEle2.COL.A  then rez:=false;
//--------------------------------------------
f:=1;while (f<=iEle2.KOlV) and (rez=true) do
     begin
     lVer:=I_FIN_Ver(iEle1.Obj,iEle2.VERS[f].NAM);
     if lVer<>Nil then rez:=I_RAV_Ver(lVer,iEle2.VErS[f]);
     f:=f+1;
     end;
//--------------------------------------------
f:=1;while (f<=iEle2.KOlE) and (rez=true) do
     begin
     lEle:=I_FIN_ELE(iEle1.Obj,iEle2.ELES[f].NAM);
     if lEle<>Nil then rez:=I_RAV_ELE(lEle,iEle2.ELES[f]);
     f:=f+1;
     end;
//--------------------------------------------
I_RAV_Ele:=Rez;
end;

// Сохраниение анимации
Procedure I_TVER_ANI_01(iObj:Tobj;iVer:TVer;var iStr:Ansistring);
var
lver:Tver;
begin


lVer:=I_FIN_VER(iObj,iVer.NAM);

if not I_RAV_VER(lver,iVer) then begin

iStr:=iStr+'V('+iVer.NAM+')';// Сохраняю имя

if iVer.LOC.X<>lVer.LOC.X then iStr:=iStr+'X('+InString(iVer.LOC.X)+')';
if iVer.LOC.Y<>lVer.LOC.Y then iStr:=iStr+'Y('+InString(iVer.LOC.Y)+')';
if iVer.LOC.Z<>lVer.LOC.Z then iStr:=iStr+'Z('+InString(iVer.LOC.Z)+')';

if iVer.COL.R<>lVer.COL.R then iStr:=iStr+'R('+IntToStr(iVer.COL.R)+')';
if iVer.COL.G<>lVer.COL.G then iStr:=iStr+'G('+IntToStr(iVer.COL.G)+')';
if iVer.COL.B<>lVer.COL.B then iStr:=iStr+'B('+IntToStr(iVer.COL.B)+')';
if iVer.COL.A<>lVer.COL.A then iStr:=iStr+'A('+IntToStr(iVer.COL.A)+')';

iStr:=iStr+CR;
end;

end;
Procedure I_TELE_ANI_01(iObj:Tobj;iEle:TEle;var iStr:Ansistring);
var f:Longint;
lver:Tver;
lEle:Tele;
begin
lEle:=I_FIN_ELE(iObj,iEle.NAM);
if not I_RAV_ELE(lEle,iEle) then begin

iStr:=iStr+'E('+iEle.NAM+')';// Сохраняю имя

if lEle.LOC.X<>iEle.LOC.X then iStr:=iStr+'X('+InString(iEle.LOC.X)+')';// Координаты вершины X
if lEle.LOC.Y<>iEle.LOC.Y then iStr:=iStr+'Y('+InString(iEle.LOC.Y)+')';// Координаты вершины Y
if lEle.LOC.Z<>iEle.LOC.Z then iStr:=iStr+'Z('+InString(iEle.LOC.Z)+')';// Координаты вершины Z

if lEle.EUGL.X<>iEle.EUGL.X then iStr:=iStr+'x('+InString(iEle.EUGL.X)+')';// Углы наклона X
if lEle.EUGL.Y<>iEle.EUGL.Y then iStr:=iStr+'y('+InString(iEle.EUGL.Y)+')';// Углы наклона Y
if lEle.EUGL.Z<>iEle.EUGL.Z then iStr:=iStr+'z('+InString(iEle.EUGL.Z)+')';// Углы наклона Z

if lEle.COL.R<>iEle.COL.R then iStr:=iStr+'R('+IntToStr(iEle.COL.R)+')';// Цвет Красный
if lEle.COL.G<>iEle.COL.G then iStr:=iStr+'G('+IntToStr(iEle.COL.G)+')';// Цвет Зеленый
if lEle.COL.B<>iEle.COL.B then iStr:=iStr+'B('+IntToStr(iEle.COL.B)+')';// Цвет Голубой
if lEle.COL.A<>iEle.COL.A then iStr:=iStr+'A('+IntToStr(iEle.COL.A)+')';// Прозрачность

iStr:=iStr+CR;

for f:=1 to iEle.KOlV do
if NOT iEle.Vers[f].DEL THEN I_TVER_ANI_01(iObj,iEle.Vers[f],iStr);

for f:=1 to iEle.KOlE do
if NOT iEle.Eles[f].DEL THEN begin
iStr:=iStr+'E('+iEle.NAM+')';// Сохраняю Текущий контекст
I_TELE_ANI_01(iObj,iEle.Eles[f],iStr);
end;

end;
end;
Procedure I_TOBJ_ANI_01(iObj1,iObj2:TObj;var iStr:Ansistring);
var f:Longint;
begin
for f:=1 to iObj2.KOlE do
if NOT iObj2.Eles[f].DEL Then begin
iStr:=iStr+'O(self)';// Сохраняю Текущий контекст
I_TELE_ANI_01(iObj1,iObj2.Eles[f],iStr);
end;
end;

{%EndRegion}
var   {----------------------- Сохранение и загрузка  ===}{%Region /FOLD }
                                                           I_Reg11:Longint;

Procedure I_SCENA_ADD_01(var iStr:Ansistring);
var
lPos:Longint;
lNam:Ansistring;
lAni:Ansistring;
lPri:TVER;
lVer:TVer;
fVer:TVer;
lLin:TLin;
fLin:TLin;
lPlo:TPlo;
fPlo:TPlo;
lEle:TEle;
fEle:TEle;
lObj:Tobj;
fObj:Tobj;
begin
lPos:=1;lObj:=Nil;lEle:=Nil;lPlo:=Nil;lLin:=Nil;lVer:=Nil;
While lPos<Length(iStr) do begin    I_Del_Spac(lPos,iStr);// ПРопускаю спец сим
// Созаю елси нету таких элементов если есть назначаю текущим ------
     if iStr[lPos]='S' Then begin INC(lPos);// Далее следует кадр анимации
     // Далее следует кадр анимации для загрузки
     I_GetSC(lPos,iStr);
     while (iStr[lpos]<>'.') and (lpos<length(iStr)) do
     if iStr[lpos]='('
     then lAni:=lAni+I_GetSC(lPos,iStr)
     else begin lAni:=iStr[lPos];lpos:=lpos+1;end;
     end
else if iStr[lPos]='O' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     if(lNam='self')
     then begin
          if (lObj=nil) then ERR('Ни один обьект еще несоздан');
          lPri:=Tver(lObj);// Указываю текущим
          end
     else begin
          fObj:=I_FIN_Obj(lNam);// Ищу обьект
          if fObj=nil then begin // Если такого обьекта не существует
                      lObj:=TObj(I_AddObj); // Создаю его
                      lObj.Nam:=lNam;// Назанчаю имя
                      end
                      else lObj:=fObj;
          lPri:=Tver(lObj);// Указываю текущим
          end
     end
else if iStr[lPos]='E' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fEle:=I_FIN_Ele(lObj,lNam);// Ищю Элемент с таким же именем
     if fEle=nil then begin
                 lEle:=TEle(i_AddEle(lPri));// Если нету создаю элемент
                 lEle.Nam:=lNam;// Указываю имя
                 end
                 else lEle:=fEle;
     lPri:=lEle;// Назначаю текущим
     end
else if iStr[lPos]='L' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fLin:=I_FIN_Lin(lObj,lNam);// Ищю Линию с таким же именем
     if fLin=nil then begin
                 lLin:=TLin(I_AddLin(lObj));// Если нету создает Линию
                 lLin.Nam:=lNam;// Указываю имя
                 end
                 else lLin:=fLin;
     lPri:=lLin;// Назначаю текущим
     end
else if iStr[lPos]='P' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fPlo:=I_FIN_Plo(lObj,lNam);// Ищю плоскость с таким же именем
     if fPlo=nil then begin
                      lPlo:=TPlo(I_AddPPl(lObj));// Если нету создает плоскость
                      lPlo.Nam:=lNam;// Указываю имя
                      end
                      else lPlo:=fPlo;
     lPri:=lPlo;// Назначаю текущим
     end
else if iStr[lPos]='V' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fVer:=I_FIN_Ver(lPri,lNam);// Ищю вершину с тким именем
     if fVer=Nil then begin
                 lVer:=TVer(I_AddVer(lPri));// Добавляю вершину
                 lVer.Nam:=lNam;// Указываю имя
                 end
                 else lVer:=fVer;
     lPri:=lVer;// Назанчаю текущитм
     end
// Имя          ----------------------------------------------------
else if iStr[lPos]='N' Then begin INC(lPos);
     lPri.NAm:=I_GetSC(lPos,iStr);
     end
// Коринаты     ----------------------------------------------------
else if iStr[lPos]='X' Then begin INC(lPos);
     lPri.LOC.X:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='Y' Then begin INC(lPos);
     lPri.LOC.Y:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='Z' Then begin INC(lPos);
     lPri.LOC.Z:=inFloat(I_GetSC(lPos,iStr))
     end
// Цвета        ----------------------------------------------------
else if iStr[lPos]='R' Then begin INC(lPos);
     lPri.COL.R:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='G' Then begin INC(lPos);
     lPri.COL.G:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='B' Then begin INC(lPos);
     lPri.COL.B:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='A' Then begin INC(lPos);
     lPri.COL.A:=StrToInt(I_GetSC(lPos,iStr))
     end
// Углы наклона ----------------------------------------------------
else if iStr[lPos]='x' Then begin INC(lPos);
     I_GetEl(lPri).EUGL.X:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='y' Then begin INC(lPos);
     I_GetEl(lPri).EUGL.Y:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='z' Then begin INC(lPos);
     I_GetEl(lPri).EUGL.Z:=inFloat(I_GetSC(lPos,iStr))
     end
// Имена вершмин для плоскости -------------------------------------
else if iStr[lPos]='a' Then begin INC(lPos);
     lPlo.VERS[1]:=I_FIN_VER(lPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='b' Then begin INC(lPos);
     lPlo.VERS[2]:=I_FIN_VER(lPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='c' Then begin INC(lPos);
     lPlo.VERS[3]:=I_FIN_VER(lPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='d' Then begin INC(lPos);
     lPlo.VERS[4]:=I_FIN_VER(lPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='e' Then begin INC(lPos);
     lLin.VERS[1]:=I_FIN_VER(lPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='f' Then begin INC(lPos);
     lLin.VERS[2]:=I_FIN_VER(lPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='(' Then I_GetSC(lPos,iStr) else inc(lPos);
end
end;
Procedure I_SCENA_DOU_01(var iStr:Ansistring);
var
lPos:Longint;
lNam:Ansistring;
lAni:Ansistring;
lPri:TVER;
lVer:TVer;
fVer:TVer;
lLin:TLin;
fLin:TLin;
lPlo:TPlo;
fPlo:TPlo;
lEle:TEle;
fEle:TEle;
lObj:Tobj;
fObj:Tobj;
begin
lPos:=1;lObj:=Nil;lEle:=Nil;lPlo:=Nil;lLin:=Nil;lVer:=Nil;
While lPos<Length(iStr) do begin    I_Del_Spac(lPos,iStr);// ПРопускаю спец сим
// Созаю елси нету таких элементов если есть назначаю текущим ------
     if iStr[lPos]='S' Then begin INC(lPos);// Далее следует кадр анимации
     // Далее следует кадр анимации для загрузки
     I_GetSC(lPos,iStr);
     while (iStr[lpos]<>'.') and (lpos<length(iStr)) do
     if iStr[lpos]='('
     then lAni:=lAni+I_GetSC(lPos,iStr)
     else begin lAni:=iStr[lPos];lpos:=lpos+1;end;
     end
else if iStr[lPos]='O' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     if(lNam='self')
     then begin
          if (lObj=nil) then ERR('Ни один обьект еще несоздан');
          lPri:=Tver(lObj);// Указываю текущим
          end
     else begin
          fObj:=I_FIN_Obj(lNam);// Ищу обьект
          if fObj=nil then begin // Если такого обьекта не существует
                      lObj:=TObj(I_AddObj); // Создаю его
                      lObj.Nam:=lNam;// Назанчаю имя
                      end
                      else begin
                      lObj:=TObj(I_AddObj); // Создаю его
                      lObj.Nam:=I_NewNamIdd(lNam);// Назанчаю имя
                      end;
          lPri:=Tver(lObj);// Указываю текущим
          end
     end
else if iStr[lPos]='E' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fEle:=I_FIN_Ele(lObj,lNam);// Ищю Элемент с таким же именем
     if fEle=nil then begin
                 lEle:=TEle(i_AddEle(lPri));// Если нету создаю элемент
                 lEle.Nam:=lNam;// Указываю имя
                 end else lEle:=fEle;
     lPri:=lEle;// Назначаю текущим
     end
else if iStr[lPos]='L' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fLin:=I_FIN_Lin(lObj,lNam);// Ищю Линию с таким же именем
     if fLin=nil then begin
                 lLin:=TLin(I_AddLin(lObj));// Если нету создает Линию
                 lLin.Nam:=lNam;// Указываю имя
                 end
                 else lLin:=fLin;
     lPri:=lLin;// Назначаю текущим
     end
else if iStr[lPos]='P' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fPlo:=I_FIN_Plo(lObj,lNam);// Ищю плоскость с таким же именем
     if fPlo=nil then begin
                      lPlo:=TPlo(I_AddPPl(lObj));// Если нету создает плоскость
                      lPlo.Nam:=lNam;// Указываю имя
                      end
                      else lPlo:=fPlo;
     lPri:=lPlo;// Назначаю текущим
     end
else if iStr[lPos]='V' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fVer:=I_FIN_Ver(lPri,lNam);// Ищю вершину с тким именем
     if fVer=Nil then
                 begin
                 lVer:=TVer(I_AddVer(lPri));// Добавляю вершину
                 lVer.Nam:=lNam;// Указываю имя
                 end
                 else lVer:=fVer;
     lPri:=lVer;// Назанчаю текущитм
     end
// Имя          ----------------------------------------------------
else if iStr[lPos]='N' Then begin INC(lPos);
     LPri.NAm:=I_GetSC(lPos,iStr);
     end
// Коринаты     ----------------------------------------------------
else if iStr[lPos]='X' Then begin INC(lPos);
     LPri.LOC.X:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='Y' Then begin INC(lPos);
     LPri.LOC.Y:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='Z' Then begin INC(lPos);
     LPri.LOC.Z:=inFloat(I_GetSC(lPos,iStr))
     end
// Цвета        ----------------------------------------------------
else if iStr[lPos]='R' Then begin INC(lPos);
     LPri.COL.R:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='G' Then begin INC(lPos);
     LPri.COL.G:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='B' Then begin INC(lPos);
     LPri.COL.B:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='A' Then begin INC(lPos);
     LPri.COL.A:=StrToInt(I_GetSC(lPos,iStr))
     end
// Углы наклона ----------------------------------------------------
else if iStr[lPos]='x' Then begin INC(lPos);
     I_GetEl(LPri).EUGL.X:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='y' Then begin INC(lPos);
     I_GetEl(LPri).EUGL.Y:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='z' Then begin INC(lPos);
     I_GetEl(LPri).EUGL.Z:=inFloat(I_GetSC(lPos,iStr))
     end
// Имена вершмин для плоскости -------------------------------------
else if iStr[lPos]='a' Then begin INC(lPos);
     lPlo.VERS[1]:=I_FIN_VER(LPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='b' Then begin INC(lPos);
     lPlo.VERS[2]:=I_FIN_VER(LPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='c' Then begin INC(lPos);
     lPlo.VERS[3]:=I_FIN_VER(LPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='d' Then begin INC(lPos);
     lPlo.VERS[4]:=I_FIN_VER(LPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='e' Then begin INC(lPos);
     lLin.VERS[1]:=I_FIN_VER(LPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='f' Then begin INC(lPos);
     lLin.VERS[2]:=I_FIN_VER(LPri,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='(' Then I_GetSC(lPos,iStr) else inc(lPos);
end
end;
Procedure I_SCENA_KAD_01(var iStr:Ansistring);
var
R_O,R_P:Boolean;
lPos:Longint;
lNam:Ansistring;
lZna:Ansistring;
lPri:TVER;
lVer:TVer;
fVer:TVer;
lLin:TLin;
fLin:TLin;
lPlo:TPlo;
fPlo:TPlo;
lEle:TEle;
fEle:TEle;
lObj:Tobj;
fObj:Tobj;
begin
lPos:=1;lObj:=Nil;lEle:=Nil;lPlo:=Nil;lLin:=Nil;lVer:=Nil;R_O:=False;R_P:=False;
While lPos<Length(iStr) do begin    I_Del_Spac(lPos,iStr);// ПРопускаю спец сим

     if iStr[lPos]='O' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     if(lNam='self')
     then begin
          if (lObj=nil) then ERR('Ни один обьект еще несоздан');
          if R_O then lPri:=Tver(lObj);// Указываю текущим
          end
     else begin
          fObj:=I_FIN_Obj(lNam);// Ищу обьект
          if fObj=nil then begin // Если такого обьекта не существует
                      R_O:=false;
                      R_P:=False;
                      end
                      else begin
                      R_O:=true;
                      R_P:=true;
                      lObj:=fObj;
                      lPri:=Tver(lObj);// Указываю текущим
                      end;
          end
     end
else if iStr[lPos]='E' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     if R_O then begin
     fEle:=I_FIN_Ele(lObj,lNam);// Ищю Элемент с таким же именем
     if fEle=nil then R_P:=false
                 else begin
                 R_P:=true;
                 lEle:=fEle;
                 lPri:=lEle;// Назначаю текущим
                 end;
     end;
     end
else if iStr[lPos]='L' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     if R_O then begin
     fLin:=I_FIN_Lin(lObj,lNam);// Ищю Линию с таким же именем
     if fLin=nil then R_P:=false
                 else begin
                 R_P:=true;
                 lLin:=fLin;
                 lPri:=lLin;// Назначаю текущим
                 end
     end
     end
else if iStr[lPos]='P' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     if R_O then begin
     fPlo:=I_FIN_Plo(lObj,lNam);// Ищю плоскость с таким же именем
     if fPlo=nil then R_P:=false
                 else begin
                      R_P:=true;
                      lPlo:=fPlo;
                      lPri:=lPlo;// Указываю имя
                      end;
     end;
     end
else if iStr[lPos]='V' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     if R_O then begin
     lVer:=I_FIN_Ver(lPri,lNam);// Ищю вершину с тким именем
     if lVer=Nil then R_P:=false
                 else begin
                      R_P:=true;
                      lVer:=fVer;
                      lPri:=lVer;// Указываю имя
                 end;
     end
     end
// Имя          ----------------------------------------------------
else if iStr[lPos]='N' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.Nam:=lZna;
     end
// Коринаты     ----------------------------------------------------
else if iStr[lPos]='X' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.LOC.X:=inFloat(lZna)
     end
else if iStr[lPos]='Y' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.LOC.Y:=inFloat(lZna)
     end
else if iStr[lPos]='Z' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.LOC.Z:=inFloat(lZna)
     end
// Цвета        ----------------------------------------------------
else if iStr[lPos]='R' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.COL.R:=StrToInt(lZna)
     end
else if iStr[lPos]='G' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.COL.G:=StrToInt(lZna)
     end
else if iStr[lPos]='B' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.COL.B:=StrToInt(lZna)
     end
else if iStr[lPos]='A' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.COL.A:=StrToInt(lZna)
     end
// Углы наклона ----------------------------------------------------
else if iStr[lPos]='x' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then I_GetEl(LPri).EUGL.X:=inFloat(lZna)
     end
else if iStr[lPos]='y' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then I_GetEl(LPri).EUGL.Y:=inFloat(lZna)
     end
else if iStr[lPos]='z' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then I_GetEl(LPri).EUGL.Z:=inFloat(lZna)
     end
// Имена вершмин для плоскости -------------------------------------
else if iStr[lPos]='a' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lPlo.VERS[1]:=I_FIN_VER(LPri,lZna);
     end
else if iStr[lPos]='b' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lPlo.VERS[2]:=I_FIN_VER(LPri,lZna);
     end
else if iStr[lPos]='c' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lPlo.VERS[3]:=I_FIN_VER(LPri,lZna);
     end
else if iStr[lPos]='d' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lPlo.VERS[4]:=I_FIN_VER(LPri,lZna);
     end
else if iStr[lPos]='e' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lLin.VERS[1]:=I_FIN_VER(LPri,lZna);
     end
else if iStr[lPos]='f' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lLin.VERS[2]:=I_FIN_VER(LPri,lZna);
     end
else if iStr[lPos]='(' Then I_GetSC(lPos,iStr) else inc(lPos);
end
end;

procedure I_DEL_ANIMATION(iAni:TCheckListBox);
var
f:Longint;
m:Tstr;
begin
f:=iAni.Items.Count-1;
while f>1 do begin
if iAni.Selected[f] then begin
   M:=TStr(iAni.Items.Objects[iAni.itemindex]);
   M.Free;
   iAni.items.delete(f);
   end;
f:=f-1;
end
end;
procedure I_ADD_ANIMATION(iAni:TCheckListBox);
var
lSelObjs:TSels;
M:TStr;
begin
lSelObjs:=MirSels.SELOBJS;
if lSelObjs.KOl=2 then begin
M:=TStr.Create;
I_TOBJ_ANI_01(TObj(lSelObjs.SELS[2]),TObj(lSelObjs.SELS[1]),M.TXT);
iAni.Items.AddObject(I_NewNamIdd('A '),M);
end;
lSelObjs.free;
end;
procedure I_SET_ANIMATION(iAni:TCheckListBox);
var
fa,fo:Longint;
lSelObjs:TSels;
lStr:Tstr;
lAni:AnsiString;
begin
lSelObjs:=MirSels.SELOBJS;
for fa:=1 to iAni.Items.count-1 do
if iAni.Selected[fa]     then
for fo:=1 to lSelObjs.KOl do begin
lStr:=TStr(iAni.Items.Objects[fa]);
lAni:='O('+lSelObjs.Sels[fo].NAM+')'+lStr.TXT;
I_SCENA_KAD_01(lAni);
end;
lSelObjs.free;
end;

procedure I_SaveScena(iNamFile:Ansistring);
var lStr:Ansistring;
begin
I_OBJS_PUT_01(lStr);
StrToFile(iNamFile,lStr);
G_Change:=false;
end;
procedure I_LoadScena(iNamFile:Ansistring);
var
lStr:AnsiString;
begin
FileToStr(iNamFile,lStr);
I_ClearScena;// Очищаем сцену
I_SCENA_DOU_01(lStr);
G_Change:=false;
end;

{%EndRegion}
var   {----------------------- Бардак                 ===}{%Region /FOLD }
                                                           J_Reg11:Longint;

procedure I_DoubleObject(iTObj:Pointer);// Создает копию обьекта
var
lStr:Ansistring;
begin
I_TOBJ_PUT_01(TObj(iTObj),lStr);// превращаем обьект в строку
I_SCENA_DOU_01(lStr);// Превращаем строку в обьект
end;
procedure I_Set_MBUT(iBol:Boolean);
begin
MBUT:=iBol;
end;
function  I_RodEle(iEle,iObj:Pointer):Boolean;// Доделать
var
lEle:TEle;
lObj:TObj;
Rez:Boolean;
begin
Rez:=False;
lEle:=TEle(iEle);// ПРоверяемый обьект
lObj:=TObj(TEle(iEle).OBJ);// РОдительский обьект
if iEle=iObj Then Rez:=True;
while (lObj<>lEle) and (Rez=false) do begin
lEle:=Tele(lEle.Ele);
if lEle=TEle(iObj) Then Rez:=True;
end;
I_RodEle:=REz;
end;
procedure I_SetSel(iPri:pointer;iSel:Boolean);
var F,I:Longint;
begin
// Выделени примитива на формах ------------------------------------------------
for f:=0 to application.ComponentCount-1 do
     if (application.Components[f] is tform7) then begin

      with (application.Components[f] as tform7).CheckListBox1 do
      for i:=1 to items.count-1 do // Вершины
      if Pointer(items.objects[i])=iPri then selected[i]:=iSel;

      with (application.Components[f] as tform7).CheckListBox2 do
      for i:=1 to items.count-1 do // Элементы
      if Pointer(items.objects[i])=iPri then selected[i]:=iSel;

     end
else if (application.Components[f] is tform6) then begin

     with (application.Components[f] as tform6).CheckListBox1 do
     for i:=1 to items.count-1 do // Вершины
     if Pointer(items.objects[i])=iPri then selected[i]:=iSel;

     with (application.Components[f] as tform6).CheckListBox2 do
     for i:=1 to items.count-1 do // Линии
     if Pointer(items.objects[i])=iPri then selected[i]:=iSel;

     with (application.Components[f] as tform6).CheckListBox3 do
     for i:=1 to items.count-1 do // Плоскости
     if Pointer(items.objects[i])=iPri then selected[i]:=iSel;

     with (application.Components[f] as tform6).CheckListBox4 do
     for i:=1 to items.count-1 do // Элементы
     if Pointer(items.objects[i])=iPri then selected[i]:=iSel;

     end
else if (application.Components[f] is tform5) then begin

     with (application.Components[f] as tform5).CheckListBox1 do
     for i:=1 to items.count-1 do // Обьекты
     if Pointer(items.objects[i])=iPri then selected[i]:=iSel;

     end;
// Выделение примитива в стуркутре ---------------------------------------------
if iSel
then MirSels.Add(TVer(iPri))
else MirSels.Del(TVer(iPri));
// Выборка активного примитива в данный момент времени -------------------------
if MirSels.Kol<>0 then form4.Act:=MirSels.Sels[1];
I_RefreshActivePrimitiv;
// -----------------------------------------------------------------------------
end;
procedure I_EDITDRAWSEL(ClientHeight:Longint);
var f,RC:LongWord;NoSel:Boolean;
begin
NoSel:=true;// Ничего не выбрано
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
//------------------------------------------------------------------------------
if form4.MenuItem10.Checked then begin // ОБьекты
for f:=1 to MirObjs.KolO do if not MirObjs.OBJS[f].DEL then
I_DrObj(MirObjs.OBJS[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirObjs.KolO) then begin
NoSel:=False;// Указваю что есть выбраный обьект
MirObjs.Objs[RC].Sel:=not MirObjs.Objs[RC].Sel;
I_SetSel(MirObjs.Objs[RC],MirObjs.Objs[RC].Sel);
if MBUT THEN begin CaP3:=MirObjs.Objs[RC].ECR;end;
if DBUT THEN begin U_OpenObject(MirObjs.Objs[RC]);DBUT:=False;end;
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;
//------------------------------------------------------------------------------
if form4.MenuItem12.Checked then begin // Элемент
for f:=1 to MirEles.KolE do if not MirEles.ELES[f].DEL then
I_DrEle(MirEles.ELES[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirEles.KolE) then begin
NoSel:=False;// Указваю что есть выбраный обьект
MirEles.Eles[RC].Sel:=not MirEles.Eles[RC].Sel;
I_SetSel(MirEles.Eles[RC],MirEles.Eles[RC].Sel);
if MBUT THEN begin CaP3:=MirEles.Eles[RC].ECR;end;
if DBUT THEN begin U_OpenElement(MirEles.Eles[RC]);DBUT:=False;end;
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;
//------------------------------------------------------------------------------
if form4.MenuItem13.Checked then begin // Плоскос
for f:=1 to MirPlos.KolP do if not MirPlos.PLOS[f].DEL then
I_DrPlo(MirPLos.PLOS[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirPLos.KolP) then begin
NoSel:=False;// Указваю что есть выбраный обьект
MirPlos.Plos[RC].Sel:=not MirPlos.Plos[RC].Sel;
I_SetSel(MirPLos.PLos[RC],MirPlos.Plos[RC].Sel);
if MBUT THEN begin CaP3:=MirPlos.Plos[RC].ECR;end;
if DBUT then begin
        U_OpenPlos(MirPLOs.PLos[RC],TELE(MirPlos.Plos[RC]).ELE);
        DBUT:=False;
        end;
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
End;
//------------------------------------------------------------------------------
if form4.MenuItem22.Checked then begin // Линия
for f:=1 to MirLins.KolL do if not MirLins.LINS[f].DEL then
I_DrLin(MirLins.LINS[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirLins.KolL) then begin
NoSel:=False;// Указваю что есть выбраный обьект
MirLins.Lins[RC].Sel:=not MirLins.Lins[RC].Sel;
I_SetSel(MirLins.Lins[RC],MirLins.Lins[RC].Sel);
if MBUT THEN begin CaP3:=MirLins.Lins[RC].ECR;end;
if DBUT then begin
             U_OpenLine(MirLins.Lins[RC],TELE(MirLins.Lins[RC]).ELE);
             DBUT:=False;
             end;
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
End;
//------------------------------------------------------------------------------
if form4.MenuItem14.Checked then begin // Вершины
for f:=1 to MirVers.KolV do if not MirVers.VERS[f].DEL then
I_DrVer(MirVers.VERS[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirVers.KolV) then begin
NoSel:=False;// Указваю что есть выбраный обьект
MirVers.Vers[RC].Sel:=not MirVers.Vers[RC].Sel;
I_SetSel(MirVers.Vers[RC],MirVers.Vers[RC].Sel);
if MBUT THEN begin CaP3:=MirVers.Vers[RC].ECR;end;
if DBUT then begin
             U_OpenPoint(MirVers.Vers[RC],TELE(MirVers.Vers[RC]).ELE);
             DBUT:=False;
             end;
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;
//------------------------------------------------------------------------------
if NoSel                    then begin // Если ничего не выбрано
             while MirSels.Kol<>0 do I_SetSel(MirSels.sels[MirSels.Kol],false);
             DBUT:=False;
                            end;
//------------------------------------------------------------------------------
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
end;
procedure I_EDITDRAW;
var f:Longint;
Begin // Отрисовка редактора

// Отрисовываю все ОБьекты в игровом мире
if form4.MenuItem10.Checked then // ОБьекты
for f:=1 to MirObjs.KolO do if not MirObjs.OBJS[f].DEL then
if Not MirObjs.OBJS[f].SEL
then  I_DrObj(MirObjs.OBJS[f],CreRCol(0,0,0,150))
else  I_DrObj(MirObjs.OBJS[f],RanRCol);

// Отрисовываю все элементы  в игровом мире
if form4.MenuItem12.Checked then // Элемент
for f:=1 to MirEles.KolE do if not MirEles.ELES[f].DEL then
if Not MirEles.ELES[f].SEL
Then I_DrEle(MirEles.ELES[f],CreRCol(0,0,0,150))
else I_DrEle(MirEles.ELES[f],RanRcol);

// Отрисовываю все Плоскости в игровом мире
if form4.MenuItem13.Checked then // Плоскос
for f:=1 to MirPlos.KolP do if not MirPlos.PLOS[f].DEL then
if Not MirPlos.PLOS[f].SEL
then I_DrPlo(MirPlos.PLOS[f],CreRCol(0,0,0,150))
else I_DrPlo(MirPlos.PLOS[f],RanRcol);


// Отрисовываю все Линии в игровом мире
if form4.MenuItem22.Checked then // Линии
for f:=1 to MirLins.KolL do if not MirLins.LINS[f].DEL then
if Not MirLins.LinS[f].SEL
then I_DrLin(MirLins.LinS[f],CreRCol(0,0,0,150))
else I_DrLin(MirLins.LinS[f],RanRcol);

// Отрисовываю все вершины в игровом мире
if form4.MenuItem14.Checked then   // Вершины
for f:=1 to MirVers.KolV do if not MirVers.VERS[f].DEL then
if Not MirVers.VERS[f].SEL
then I_DrVer(MirVers.VERS[f],CreRCol(0,0,0,150))
else I_DrVer(MirVers.VERS[f],RanRcol);




end;
procedure I_ClearScena;// Очищает Сцену
var f:Longint;
begin
 G_Change:=true;
 for f:=1 to MirObjs.KolO do I_DelObj(MirObjs.OBJS[f]);
 G_FileName:='';
end;

{%EndRegion}

{%EndRegion}
var   {Таймеры                ===========================}{%Region /FOLD }
                                                           Reg14:Longint;

procedure Ploskost(iVer1,iVer2,iVer3,iVer4:RCS3;C:RCOL);
begin
glColor3ub(C.R,C.G,C.B);
glBegin(GL_TRIANGLES);

glVertex3f(iVer1.x,iVer1.y,iVer1.z);
glVertex3f(iVer2.x,iVer2.y,iVer2.z);
glVertex3f(iVer3.x,iVer3.y,iVer3.z);
glVertex3f(iVer3.x,iVer3.y,iVer3.z);
glVertex3f(iVer4.x,iVer4.y,iVer4.z);
glVertex3f(iVer1.x,iVer1.y,iVer1.z);

glEnd();
end;
function  OpredelitCoo(x,y:Longint;iVer1,iVer2,iVer3,iVer4:RCS3;g:Longint):RCS3;
var
Rez:RCS3;
iVer0,iVer12,iVer23,iVer34,iVer41:RCS3;
Rc:LongWord=0;
begin
iVer0:=SerRCS3(iVer1,iVer3);
if (g>0) then begin
// Разбиваю на 4 плоскости
iVer12:=SerRCS3(iVer1,iVer2);
iVer23:=SerRCS3(iVer2,iVer3);
iVer34:=SerRCS3(iVer3,iVer4);
iVer41:=SerRCS3(iVer4,iVer1);
// РИсую 4 плоскости
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
ploskost(iVer1 ,iVer12,iVer0 ,iVer41,IntToCol(1000));
ploskost(iVer12,iVer2 ,iVer23,iVer0 ,IntToCol(2000));
ploskost(iVer0 ,iVer23,iVer3 ,iVer34,IntToCol(3000));
ploskost(iVer41,iVer0 ,iVer34,iVer4 ,IntToCol(4000));
// читаю цвет плоскости
glReadPixels(X,Y, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@Rc);
// смотря в какую плоскость попали
if (Rc=1000) then Rez:=OpredelitCoo(X,Y,iVer1 ,iVer12,iVer0 ,iVer41,g-1) else
if (Rc=2000) then Rez:=OpredelitCoo(X,y,iVer12,iVer2 ,iVer23,iVer0 ,g-1) else
if (Rc=3000) then Rez:=OpredelitCoo(X,y,iVer0 ,iVer23,iVer3 ,iVer34,g-1) else
if (Rc=4000) then Rez:=OpredelitCoo(X,y,iVer41,iVer0 ,iVer34,iVer4 ,g-1) else Rez:=iVer0;
end else Rez:=iVer0;
OpredelitCoo:=Rez;
end;
procedure OpredelitCoo(iPlo:Tplo);// Определяет координату нажатой мышки
var iVer1,iVer2,iVer3,iVer4:RCS3;
begin
if Iplo<>Nil Then begin
iver1:=iPlo.VERS[1].ECR;
iver2:=iPlo.VERS[2].ECR;
iver3:=iPlo.VERS[3].ECR;
iver4:=iPlo.VERS[4].ECR;

if MBUT then
        CaP3:=OpredelitCoo(
               MouD.X,
               form3.ClientHeight-MouD.Z,
               iver1,
	       iver2,
	       iver3,
	       iver4,
	       16
	       );
end;
end;

function  Math(Par:Pointer):DWORD;stdcall;// Вычисление
var F:Longint;
begin
   SetThreadPriority(GetCurrentThread,THREAD_PRIORITY_LOWEST);
   while Clos=false do begin
     sleep(50);MirObjs.Ras;
     for f:=1 to MirObjs.KolO do MirObjs.OBJS[f].O_MATH;
   end;
result:=0;
end;
function  SWAP(Par:Pointer):DWORD;stdcall;// Вывод сцены в буфер
var
F:Longword;// ДЛя циклов
lDrKp:Longword;// Реальное количество Вершин Плоскостей
lDrKL:Longword;// Реальное количество Вершин Линий
begin
   SetThreadPriority(GetCurrentThread,THREAD_PRIORITY_LOWEST);
   while Clos=false do begin
     sleep(30);
     // ========================================================================
     with MirVers do for f:=1 to KOlV do
     if   not Vers[f].DEL then
     with Vers[f] do begin
     ECOO1[f]:=ECR;
     ECOL1[f]:=Col;
     end;
     // ========================================================================
     lDrKp:=0;sleep(30);
     with MirPlos do for f:=1 to KolP do
     if   not Plos[f].DEL then
     with Plos[f] do begin
     lDrKp:=lDrKp+1;
     EPlo1[lDrKp].VERS[1]:=Vers[1].Nom;
     EPlo1[lDrKp].VERS[2]:=Vers[2].Nom;
     EPlo1[lDrKp].VERS[3]:=Vers[3].Nom;
     EPlo1[lDrKp].VERS[4]:=Vers[3].Nom;
     EPlo1[lDrKp].VERS[5]:=Vers[4].Nom;
     EPlo1[lDrKp].VERS[6]:=Vers[1].Nom;
     end;
     MirPLos.DrKp:=lDrKp;
     lDrKl:=0;
     with MirLins do for f:=1 to KolL do
     if   not Lins[f].DEL then
     with Lins[f] do begin
     lDrKl:=lDrKl+1;
     ELin1[DrKl].VERS[1]:=Vers[1].Nom;
     ELin1[DrKl].VERS[2]:=Vers[2].Nom;
     end;
     MirLins.DrKl:=lDrKl;sleep(30);
     // ========================================================================
     with MirVers do Move(ECoo1,ECoo2,(KolV+1)*SizeOf(RCS3));
     with MirVers do Move(ECol1,ECol2,(KolV+1)*SizeOf(RCOL));
     with MirLins do Move(ELin1,ELin2,(DrKl+0)*SizeOf(RLIN));
     with MirPlos do Move(EPlo1,EPlo2,(DrKP+0)*SizeOf(RPLO));
     // ========================================================================
   end;
   result:=0;
end;

procedure TForm3.Timer1Timer(Sender: TObject);// Запускатор
var
x,z:RINT;
begin
Timer1.enabled:=false;// Отключаем запускатор

  GFon:=CreRCol(150,150,250,255);// Формируем цвет фона
  MirVers:=TVERS.Create;// Создаем списки вершин
  MirLins:=TLINS.Create;// Создаем списки Линий
  MirPlos:=TPLOS.Create;// Создаем списки плоскостей
  MirEles:=TELES.Create;// Создаем списки элементов
  MirObjs:=TOBJS.Create;// Создаем списки Обьектов
  MirSels:=TSELS.Create;// Создаем Буфер обмена
  // Отдельный поток для расчета координат всех вершин
  HMath:=CreateThread(nil,0,@Math,nil,0,HMathTrId);
  HSWAP:=CreateThread(nil,0,@SWAP,nil,0,HSwapTrId);
  // OpenGl настройки
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_Blend);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnableClientState(GL_COLOR_ARRAY);
  glEnableClientState(GL_VERTEX_ARRAY);
  GlPointSize(25);// размер точек
  GlLineWidth(10);// рзмер Линий
  OpenGLControl1Resize(nil);// Начальное вычисление пропрций
  Timer2.enabled:=true;// Врубаем отрисовку
  Timer3.enabled:=true;// Врубаем подсчет количества кадров в секунду

end;
procedure TForm3.Timer2Timer(Sender: TObject);// ОТрисовка
var Tr:QWord;f:longint;RC:LongWord;P:TPLO;
begin
  begin // Подготовка в отрисовке
  timer2.Enabled:=false;
  Tr:=GetTickCount64;
  //----------------------------------------------------------------------------
  Cap2:=SerRcs8(cap2,cap3);
  CaU2.X:=((CaU3.X-CaU2.X)/16)+CaU2.X;
  CaU2.Z:=((CaU3.Z-CaU2.Z)/16)+CaU2.Z;
  RasN:=((Ras3-RasN)/16)+RasN;
  //----------------------------------------------------------------------------
  glLoadIdentity();// Сброс матрицы
  GlpushMatrix();
  glTranslateD(0,0,RASN);// Отодвигаем камеру на нужное растояние
  glRotateD(CaU2.X,1,0,0);// Поворот по оси X
  glRotateD(CaU2.Z,0,1,0);// Поворот по оси Y
  glTranslateD(-CaP2.x,-CaP2.y,-CaP2.z);// Координаты камеры
  end;
  //----------------------------------------------------------------------------
  if LBut then Begin
  glDisableClientState(GL_COLOR_ARRAY);
  glDisableClientState(GL_VERTEX_ARRAY);
  GlDisable(GL_Blend);// Выключаю смешивание цветов
  I_EDITDRAWSEL(ClientHeight);// -------------------------------------------
  glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  for f:=1 to MirPlos.KolP do
  if   not MirPLos.Plos[f].DEL then
  with MirPLos.Plos[f] do
  ploskost(
           VERS[1].ECR,
           VERS[2].ECR,
           VERS[3].ECR,
           VERS[4].ECR,
           IntToCol(f));
  RC:=0;
  glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
  if (RC>0) and (RC<=MirPlos.KolP) then
  begin P:=MirPlos.PLos[RC];OpredelitCoo(P);end else P:=Nil;
  GlEnable(GL_Blend);// Включаю смешивание цветов
  glEnableClientState(GL_COLOR_ARRAY);
  glEnableClientState(GL_VERTEX_ARRAY);
  //Per.oCel:=Cap3;
  LBut:=false;
  end;
  //----------------------------------------------------------------------------
  Begin // Отрисовка сцены
  //----------------------------------------------------------------------------
  glClearColor(GFon.R*(1/255),GFon.G*(1/255),GFon.B*(1/255),GFon.A*(1/255)); // Задаем фон
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);// очистка экрана
  glVertexPointer(3, GL_FLOAT, 0, @MirVers.ECOO2);
  glColorPointer (4, GL_UNSIGNED_BYTE, 0,@MirVers.ECOL2);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glDrawElements(GL_TRIANGLES,MirPlos.DrKP*6,GL_UNSIGNED_INT,@MirPlos.EPlo2[1]);
  glVertexPointer(3, GL_FLOAT, 0, @MirVers.ECOO2);
  glDrawElements(GL_LINES    ,MirLins.DrKl*2,GL_UNSIGNED_INT,@MirLins.ELin2[1]);
  I_EDITDRAW;//-----------------------------------------------------------------
  end;
  //----------------------------------------------------------------------------
  begin // Завершение отрисовки
  OpenGLControl1.SwapBuffers;
  KolKAdVsek:=KolKAdVsek+1;
  TR:=GetTickCount64-tr;
  timer2.Enabled:=true;
  end;
end;
procedure TForm3.Timer3Timer(Sender: TObject);// ПОдгонка чатсоты кадров
begin
  Caption:=IntToStr(KolKAdVsek)+' '+
             //FloatToStr(CaU2.X)+' '+
             //FloatToStr(CaU2.Z)+' '+
             intToStr(Trunc(Cap2.X))+' '+
             intToStr(Trunc(Cap2.Y))+' '+
             IntToStr(Trunc(Cap2.Z))+' '+
             FloatToStr(RAsN);
if (KolKAdVsek>33) and (Timer2.interval<50) then Timer2.interval:=Timer2.interval+1;
if (KolKAdVsek<33) and (Timer2.interval>20) then Timer2.interval:=Timer2.interval-1;
KolKAdVsek:=0;
end;

{%EndRegion}
var   {События формы          ===========================}{%Region /FOLD }
                                                           Reg15:Longint;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  halt;
end;
procedure TForm3.OpenGLControl1Click(Sender: TObject);
begin

end;
procedure TForm3.OpenGLControl1DblClick(Sender: TObject);
begin
  DBUT:=true;
end;
procedure TForm3.OpenGLControl1Resize(Sender: TObject);
begin
  glViewport  (0, 0, OpenGLControl1.Width, OpenGLControl1.Height);// Указываем размер области в котрой рисуем
  glMatrixMode(GL_PROJECTION);// Указываем матрицу с котрой будем работать
  glLoadIdentity;// Сброс в еденичную матрицу
  gluPerspective(60, OpenGLControl1.Width / OpenGLControl1.Height,MinRAsInMir,MAxRAsInMir);// Устанвока перспективы (Угол обзора в градусах,Соотношение сторон ,Ближний предел ,дальний предел )
  glMatrixMode(GL_MODELVIEW);// Выбираем модельную матрицу
  glLoadIdentity();// сброс в еденичную матрицу
end;
procedure TForm3.OpenGLControl1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta<0
  Then BEGIN
  if RAS3+MAx(abs(RAS3/7),0.0001)<0 then
     RAS3:=RAS3+Max(abs(RAS3/7),0.0001)
  end
  else BEGIN
  if RAS3-Max(abs(RAS3/7),0.0001)>-MAxRAsInMir then
     RAS3:=RAS3-Max(abs(RAS3/7),0.0001)
  end;
end;
procedure TForm3.OpenGLControl1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbLeft  then LBut:=false;
  if Button=mbRight then RBut:=False;
end;
procedure TForm3.OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  MouN.X:=X;
  MouN.Z:=Y;
  if RBut Then begin
  CaU3.X:=CaU1.X+(MouN.Z-MouD.Z);
  CaU3.Z:=CaU1.Z+(MouN.X-MouD.X);
  end;
end;
procedure TForm3.OpenGLControl1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouN.X:=X;
  MouN.Z:=Y;
  MouD.X:=X;// Запоминаем предыдущие Запоминаем координаты мышки
  MouD.Z:=Y;// Запоминаем предыдущие координаты мышки
  CaU1.X:=CaU2.X;
  CaU1.Z:=CaU2.Z;
  if Button=mbLeft  then LBut:=true;
  if Button=mbRight then RBut:=true;
end;

{%EndRegion}
end.


// 1.Чай 5 мин
// 2.Сделать анимацию созание кадров обьектов ))  готово ))))
// Немного подправить осталося анимацию от относиться к пункту 3
// 3.Не забуть доделать удаление по Признаку DEL  оформить место для анимации
// 4.Пропуск () "" '' {} и неизвестных знаков
// Добавить сворачивание блоков       { }
// Создаить окно найтроек

