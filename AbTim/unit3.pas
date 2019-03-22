unit Unit3; {$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls,CheckLst,Types,Gl,Glu,GLext;
type { TForm3 }  TForm3 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    procedure OpenGLControl1Paint(Sender: TObject);
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
gStep:Longint=1;
G_FileName:Ansistring='';// Имя файла с котрым работаем
G_Change:Boolean=False  ;// В проекте есть не сохраненные изменения
GlDraw:boolean=false    ;// Разрешение отрисовки

procedure BLOK(iVer:Pointer);
procedure I_DelVer(iVer:Pointer);// Удаление Вершины
procedure I_DelLin(iLin:Pointer);// Удаление Линии
procedure I_DelPLo(iPlo:Pointer);// Удаление Плоскости
procedure I_DelEle(iEle:Pointer);// Удаление Элемента
procedure I_DelObj(iObj:pointer);// Удаление обьекта
procedure I_DelAni(iAni:POinter);// Удаление Анимации
procedure I_DelScr(iScr:POinter);// Удаление Скрипта

function I_AddVerCOP(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVerSYX(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVerSYY(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVerSYZ(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVer150(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVni150(iEle:Pointer):Pointer;// Создает симетричную вершину
function I_AddVerMar(iPlo:Pointer):Pointer;// Создает симетричную вершину


function  I_RUN(iScr:Pointer;iMemo:TMemo):POinter;// Выполнить скрипт
function  I_AddVer(iEle:Pointer):Pointer;// Создает Вершины
function  I_AddLin(iObj:Pointer):Pointer;// Создает Линии
function  I_AddPlo(iObj:Pointer):Pointer;// Создает Плоскости
function  I_AddEle(iEle:Pointer):Pointer;// Создает новый Элемент
function  I_AddObj:POinter;// Создает новый обьект
function  I_AddAni:Pointer;// Добавить Анимацию
function  I_AddScr:Pointer;// Добавить скрипт

procedure I_DelNotUseVer;// Удаляет не используемые вершины

procedure I_RefSpiVers(iEle:POinter;iLis:TCheckListBox);
procedure I_RefSpiLins(iObj:POinter;iLis:TCheckListBox);
procedure I_RefSpiPlos(iObj:POinter;iLis:TCheckListBox);
procedure I_RefSpiEles(iEle:POinter;iLis:TCheckListBox);
procedure I_RefSpiObjs(             iLis:TCheckListBox);
procedure I_RefSpiAnis(             iLis:TCheckListBox);
procedure I_RefSpiScrs(             iLis:TCheckListBox);

procedure I_GetN(iPri:Pointer;iEdit:TEdit);
procedure I_GetT(iPri:Pointer;iMemo:TMemo);
procedure I_GeMl(iPlo:Pointer;iEdit:TEdit);
procedure I_GetM(iVer:Pointer;iEdit:TEdit);
procedure I_GetV(iVer:Pointer;iEdit:TEdit);
procedure I_GetX(iVer:Pointer;iEdit:TEdit);
procedure I_GetY(iVer:Pointer;iEdit:TEdit);
procedure I_GetZ(iVer:Pointer;iEdit:TEdit);
procedure I_GetC(iVer:Pointer;iEdit:TEdit);
procedure I_GetA(iVer:Pointer;iEdit:TEdit);
procedure I_GeUX(iEle:Pointer;iEdit:TEdit);
procedure I_GeUY(iEle:Pointer;iEdit:TEdit);
procedure I_GeUZ(iEle:Pointer;iEdit:TEdit);


procedure I_GCV1(iPlo:Pointer;iEdit:TEdit);
procedure I_GCV2(iPlo:Pointer;iEdit:TEdit);
procedure I_GCV3(iPlo:Pointer;iEdit:TEdit);
procedure I_GCV4(iPlo:Pointer;iEdit:TEdit);
procedure I_GAV1(iPlo:Pointer;iEdit:TEdit);
procedure I_GAV2(iPlo:Pointer;iEdit:TEdit);
procedure I_GAV3(iPlo:Pointer;iEdit:TEdit);
procedure I_GAV4(iPlo:Pointer;iEdit:TEdit);


procedure I_SCV1(iPlo:Pointer;iEdit:TEdit);
procedure I_SCV2(iPlo:Pointer;iEdit:TEdit);
procedure I_SCV3(iPlo:Pointer;iEdit:TEdit);
procedure I_SCV4(iPlo:Pointer;iEdit:TEdit);

procedure I_SAV1(iPlo:Pointer;iEdit:TEdit);
procedure I_SAV2(iPlo:Pointer;iEdit:TEdit);
procedure I_SAV3(iPlo:Pointer;iEdit:TEdit);
procedure I_SAV4(iPlo:Pointer;iEdit:TEdit);


procedure I_SeMl(iPlo:Pointer;iEdit:TEdit);
procedure I_SetM(iVer:Pointer;iEdit:TEdit);
procedure I_SetV(iVer:Pointer;iEdit:TEdit);
procedure I_SetT(iVer:Pointer;iMemo:TMemo);
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
procedure I_ClearScena;// Очищает Сцену
procedure I_SaveScena(iNamFile:Ansistring);// Сохраняет сцену
procedure I_LoadScena(iNamFile:Ansistring);// Сохраняет сцену
procedure I_DoubleObject(iTObj:Pointer;LiS:TCheckListBox);// Создает копию обьекта
procedure I_SET_ANIMATION(iAni:TCheckListBox);// Приеняет кадр анимации
function  I_AddVerLan(iEle:Pointer):Pointer;
function  I_SCENA_DOU_01(var iStr:Ansistring):Pointer;
procedure I_DelDel(iPri:POinter);
procedure I_CLOSE;
function  OknoWidth(ix:longint):longint;
function  OknoHeight(iy:longint):longint;

{%EndRegion}
implementation {$R *.lfm}
uses unit4,unit5,unit6,unit7,unit8,unit9,unit10,unit12,unit13,unit15;
var   {Базa                   ===========================}{%Region /FOLD }
                                                           BAS01:Longint;

const {Базовые Константы      ===========================}{%Region /FOLD }


  MinRAsInMir=1;// Минимальнео растояние в игровом мире от камеры
  MAxRAsInMir=1024* 32;// Максимальное растояние в игровом мире от камеры
 GMAxRAsInMir=1024*512;// МАксимально возможное растояние в движке

  MaxKolVerInEle=512*1;// Максимальное количество Вершин в Элементе
  MaxKolLinInObj=512*1;// Максимальное количество Линий в Элементе
  MaxKolPloInObj=512*1;// Максимальное количество Плоскостей в Элементе
  MaxKolEleInEle=  8*1;// Максимальное количество Элементов в Элементе
  MaxKolObjInObj=128*4;// Максимальное количество обьектов в одном обьетке

  MaxKOlVerInMir=1024*64;//Максимальное количество Вершин в игровом мире
  MaxKOlLinInMir=1024*64;//Максимальное количество Линий в игровом мире
  MaxKOlPloInMir=1024*64;//Максимальное количество Плоскостей в игровом мире
  MaxKOlEleInMir=1024*64;//Максимальное количество Элементов в игровом мире
  MaxKOlObjInMir=1024*64;//Максимальное количество Обьектов в игровом мире
  MaxKOlAniInMir=1024* 4;// Максимальнео количество Анимаций в игровом мире
  MaxKOlScrInMir=1024* 4;// Максимальнео количество скриптов в игровом мире

  MinKolDelVers=1024*4;// Минимальный размер очереди на удаление Вершин
  MinKolDelLins=1024*4;// Минимальный размер очереди на удаление Линий
  MinKolDelPlos=1024*4;// Минимальный размер очереди на удаление Плоскотей
  MinKolDelEles=1024*4;// Минимальный размер очереди на удаление Элементов
  MinKolDelObjs=1024*4;// Минимальный размер очереди на удаление Обьектов
  MinKolDelAnis=1024*1;// Минимальный размер очереди на удаление Анимаций
  MinKolDelScrs=1024*1;// Минимальный размер очереди на удаление Скриптов

  MaxKolDelVers=1024*8;// Максимальный размер очереди на удаление Вершин
  MaxKolDelLins=1024*8;// Максимальный размер очереди на удаление Линий
  MaxKolDelPlos=1024*8;// Максимальный размер очереди на удаление Плоскотей
  MaxKolDelEles=1024*8;// Максимальный размер очереди на удаление Элементов
  MaxKolDelObjs=1024*8;// Максимальный размер очереди на удаление Обьектов
  MaxKolDelAnis=1024*8;// Минимальный размер очереди на удаление Анимаций
  MaxKolDelScrs=1024*8;// Минимальный размер очереди на удаление Скриптов

  MaxKolSelPris=1024*64;// Максимальнео количество выделеных примитивов

  T_VER=1;// Вршина
  T_PLO=2;// Плоскость
  T_LIN=3;// Линия
  T_ELE=4;// Элементы
  T_OBJ=5;// Обьекеты
  T_ANI=6;// Анимации
  T_SCR=7;// Скрипты
  //-----------------------
  LN=Chr(13)+Chr(10);

  TI_SLO=10;// Слово
  TI_CIF=20;// Цифра
  TI_ZNA=30;// Знаки
  TI_KAV=40;// Квычки

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


function  Min(a,b:RSIN):RSIN;
begin
if A>B then result:=b else result:=a;
end;
function  Max(a,b:RSIN):RSIN;
begin
if A<B then result:=b else result:=a;
end;

function  GRAD (x,y:Single):Single;// Поворот коориднаты на заданый угол
var REz:Single;
begin
REz:=arctan(y/x);
if X<0 then rez:=Rez+pi;
//if Y<0 then rez:=Rez+(2*pi);
if REz<0 then rez:=Rez+(2*pi);
GRAD:=Rez;
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
function  MovRCS3(A,B:RCS3;iSpe:RSin):RCS3;// Двигает персонажа на расояние iSpe
Var
Rez:RCS3;
Rx,Ry,Rz,Ras:RSin;
begin
Rx:=(b.x-a.x);// Растояне по X
Ry:=(b.y-a.y);// Растояне по Y
Rz:=(b.z-a.z);// Растояне по Z
Ras:=abs(Rx)+abs(Ry)+abs(Rz);// Растояние между точками
if Ras<1 then REz:=A else begin
REz.x:=1/Ras*RX*iSpe+a.x;
REz.y:=1/Ras*RY*iSpe+a.y;
REz.z:=1/Ras*RZ*iSpe+a.z;
end;
MovRCS3:=Rez;
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
function  IntToColRGB(iCol:LongWord):RCOL;// Переводит Число в цвет
var
Rez:RCol;
Col:LongWord;
B:Array[0..3] of Byte absolute Col;
begin
Col:=iCol;
Rez.R:=b[0];
Rez.G:=b[1];
Rez.B:=b[2];
Rez.A:=255;
IntToColRGB:=Rez;
end;
function  RavCol(iCol1,iCol2:RCol):Boolean;
var REz:Boolean;
begin
REz:=True;
if iCol1.R<>iCol2.R then REz:=false else
if iCol1.G<>iCol2.G then REz:=false else
if iCol1.B<>iCol2.B then REz:=false else
if iCol1.A<>iCol2.A then REz:=false ;
RavCol:=REz;
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
function  RColRGBAtoInt(iCol:RCol):LongWord;
var
REz:LongWord;
B:Array[0..3] of Byte absolute REz;
begin
B[0]:=iCOl.R;
B[1]:=iCOl.G;
B[2]:=iCOl.B;
B[3]:=iCOl.A;
RColRGBAtoInt:=REz;
end;

{%EndRegion}
var   {Базовые переменные     ===========================}{%Region /FOLD }

  GIDD:RLON;// Для генерации уникальных IDD
  GERR:RBOL;// Флаг ошибки Если в программе сбой

  KolKAdVsek:Longint;// Количество кадров в секунду

  //HMath:HAndle;HMathTrId:DWORD;// Перевычисление обьектов
  //HSWAP:HAndle;HSWAPTrId:DWORD;// Вывод в буфер вывода
  //HSSWA:HAndle;HSSWATrId:DWORD;// Вывод в буфер вывода
  Clos:Boolean;// Флаг Завершения программы

  LBut:RBOL;// Состояние Левой кнопки мышки
  RBut:RBOL;// Состояние Правой кнопки мышки
  DBut:RBOL;// Двойное нажатие кнопки мышки
  SBut:RBOL;// Сшифт нажат
  TREM:Ansistring;// Общая информация

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
 GERR:=true;// Глобальный флаг ошибки что произошол сбой
 form15.memo1.lines.add(S);// Вывод в консоль сообщения об ошибки
 end;
 procedure DelCpeSpa(var s:Ansistring);// Удаляет спец символы и пробелы
 var f:Longint;
 begin // удаляет из строки все символы меньше или рав пробела
 f:=1;
 while f<=Length(s) do if S[f]<=' ' then delete(s,f,1) else f:=f+1;
 end;
 function  isFloat(s:AnsiString):Boolean;// ПРоверяет число ли это
 var
 f,Kt:Longint;
 Rez:Boolean;
 begin
   Rez:=true;kT:=0;
   DelCpeSpa(s);// // удаляет из строки все символы меньше или рав пробела
   if Length(s)=0 then rez:=true else
   if (s[1]='-')or
      (s[1]='+')or
      (s[1]='.')or
      (s[1]=',')or
      ((s[1]>='0')and(s[1]<='9')) then begin
   //----------------------------------------------------------------------
   for f:=1 to length(s) do
   if ((s[f]='.') or(s[f] =',')) then Kt:=Kt+1;
   for f:=2 to length(s) do
   if ((s[f]<>'.') and (s[f]<>',')) then
   if ((s[f]<'0') or(s[f]>'9')) then rez:=false;
   //----------------------------------------------------------------------
   end else REz:=False;
   isFloat:=Rez;
 end;
 function  inFloat(s:AnsiString):real;// Строку в число
 var f,c:Longint;
 Rez:real;
 begin
   rez:=0;
   DelCpeSpa(s);// Удаляю все е нужные символы в строке
    for f:=1 to length(s) do if s[f]=',' then s[f]:='.';  //
    if (Length(s)>=1)and(S[1]='+')then delete(s,1,1);     // +0
    if (Length(s)>=1)and(S[1]='.')then s:='0'+s;           // .0
    if (Length(s)>=2)and(S[1]='-')and(S[2]='.')then insert('0',s,2);//-.
    if (Length(s)>=1)and(S[Length(s)]='.')then delete(s,Length(s),1);// 12.
    if (Length(s)<>0)then
    if (isFloat(s))then val(s,REz,c)
    else ERR('Строка не являеться числом');
   inFloat:=Rez;
 end;
 function  inInt(s:AnsiString):Longint;// Строку в число
 begin
   inInt:=Trunc(inFloat(s));
 end;
 function  InString(i:REal):ansiString;// Число в строку
 var
 lStr,REz:Ansistring;
 T:Boolean;f,Kz:Longint;
 begin
 Kz:=0;
 T:=False;
 lStr:=FloatToStr(i);
 for f:=1 to Length(lStr) do
 begin
 // Заменяю запятую на точку и узнаю есть ли вообще точка
 if (lStr[f]=',') or (lStr[f]='.') then begin T:=true;lStr[f]:='.'; end;
 if KZ<=3 then REz:=Rez+lStr[f];// Пишу не боле 3 знаков после запятой
 if T Then KZ:=KZ+1;// Считаю количество знаков после запятой
 end;
 // Удаляю ничего не значащие нули после точки справа
 if T then // Если присутсвует точка
 While (Length(Rez)>1      ) and (
       (Rez[Length(Rez)]='0') or
       (Rez[Length(Rez)]='.'))do delete(rez,Length(Rez),1);
 InString:=REz;
 end;
 Procedure I_Del_Spac(var iPos:Longint;var iStr:Ansistring);
 begin // ПРопускает пробелы и вские табы энетеры
 if iPos>Length(iStr) then ERR('I_Del_Spac Длина строки меньше ожидаемой ')
 else while (iStr[iPos]<=' ') and (length(iStr)>=iPos) do inc(iPos);
 end;
 function  I_GetSC   (var iPos:Longint;var iStr:Ansistring):Ansistring;
 var Rez:Ansistring; // Читает занчение в скобке
 begin
 Rez:='';
 I_Del_Spac(iPos,iStr);// пропускаю пробелы и спец символы
 if iStr[iPos]='(' then begin
   inc(iPos);
   while (iStr[iPos]<>')') and (length(iStr)>=iPos) do
   begin REz:=REz+iStr[iPos];inc(iPos);end;
   if (iStr[iPos]<>')') or (length(iStr)<iPos) Then
   ERR(' I_GetSC Отсуствует азкрывающая скобка  ');
   inc(iPos)
 end else ERR('I_GetSC Отсуствует открываюшаяся скобка  ');
 I_GetSC:=Rez;
 end;
 function  I_GetKa   (var iPos:Longint;var iStr:Ansistring):Ansistring;
 var Rez:Ansistring; // Читает занчение в кавыче из строки iStr c позици ipos
 begin
 Rez:='';
 I_Del_Spac(iPos,iStr);// Пропускаем пробелы спец символы
 if iStr[iPos]='"' then begin
   inc(iPos);
   while (iStr[iPos]<>'"') and (length(iStr)>=iPos) do
   begin REz:=REz+iStr[iPos];inc(iPos);end;
   if (iStr[iPos]<>'"') or (length(iStr)<iPos) Then
   ERR(' I_GetKa  Нету закрывающей кавычки  ');
   inc(iPos)
 end else ERR('I_GetKa Нету Открывающейся кавычки    ');
 I_GetKA:=Rez;
 end;
 function  NewIdd:RLon;// Генерирует уникальный IDD
 begin
 GIDD:=GIDD+1;
 NewIdd:=GIDD;
 end;
 procedure StrToFile(var iNam,iStr:Ansistring);// Переводит строку в файл
 var tf:TextFile;
 begin
 AssignFile(tf,iNam);
 rewrite(tf);
 writeln(tf,iStr);
 closefile(tf);
 end;
 procedure FileToStr(var iNam,iStr:Ansistring);// Файл в строку
      var
      tf:TextFile;
      lStr,S:AnsiString;
      begin
      AssignFile(tf,iNam);
      Reset(tf);
      while Not Eof(tf) do begin
      Readln(tf,S);
      lStr:=lStr+s+LN;
      end;
      iStr:=lStr;
      closefile(tf);
      end;
 function  OknoWidth(ix:longint):longint;
 var rez:Longint;
 begin
 Rez:=ix;
 if ix<50 Then REz:=50;
 if ix>screen.width Then Rez:=screen.width-50;
 OknoWidth:=REz;
 end;
 function  OknoHeight(iy:longint):longint;
 var rez:Longint;
 begin
 Rez:=iy;
 if iy<50 Then REz:=50;
 if iy>screen.height Then Rez:=screen.height-50;
 OknoHeight:=REz;
 end;
 function  MemoToStr(iMemo:Tmemo):Ansistring;
 var lStr:AnsiString;f:Longint;
 begin
 lStr:='';
 for f:=0 to imemo.lines.count-1 do
 lStr:=lStr+imemo.lines[f]+LN;
 MemoToStr:=lStr;
 end;
 procedure StrToMemo(iStr:Ansistring;iMemo:Tmemo);
 var f:Longint;lStr:Ansistring;
 begin
 F:=1;iMemo.Lines.clear;lStr:='';
 while f<=Length(iStr) do
 if iStr[f]=chr(13) then begin
    iMemo.Lines.Add(lStr);f:=f+1;
    if iStr[f]=chr(10) then f:=f+1;
    lStr:='';
    end
 else begin
 lStr:=lStr+iStr[f];f:=f+1;
 end;
 if lStr<>'' Then iMemo.Lines.add(lStr);
 end;

{%EndRegion}


{%EndRegion}
var   {Базовые структуры      ===========================}{%Region /FOLD }
                                                           BAS02:Longint;

var   {Описание Вершины       ===========================}{%Region /FOLD }
                                                           Reg05:Longint;
TYPE TVER=CLASS  // Описание вершиины

  NAM:RSTR;// Наименование элемента
  MCL:RBYT;// Режим отрисовки Цветов
  TXT:RSTR;// Текст
  YYY:RSIN;// Высота обьекта
  VIS:RBOL;// Видимость примитива
  VVI:RBOL;// Видимость примитива если он не мешает видеть персонажа
  CHE:RLON;// Обьект нужно перевычислить

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
  VIS:=true         ;// Видимость примитива
  VVI:=true         ;// Видимость примитива если он не мешает видеть персонажа
  SEL:=false        ;// Не выделен примитив
  IDD:=NewIdD       ;// оплучаем уникальный идентификатор
  NOM:=0            ;// Номер в списке всех вершин
  TIP:=T_VER        ;// Тип Вершины
  MCL:=1            ;// Режим отрисовки выбор режима разукрашивания примитивов
  YYY:=0            ;// Начальная высота расположения обьекта
  CHE:=100          ;// если больше 0 то нужно перевычислять обьект

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
  RASL:RSIN;
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
OB3:=trunc((GMax.X-GMin.X)*(GMax.Y-GMin.Y)*(GMax.Z-GMin.Z));
RASL:=RasRCS3(VERS[1].REA,VERS[2].REA);
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
  ILin.Del:=True;
  if KolD+1>MaxKolDelLins then ERR('Массив с удаленными линиями переполнен');
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
  COLS:Array[1..4] of RCol;// Собственые цвета для вершин в плоскости
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
GMax.Y:=GMax.Y+MinRAsInMir+10;
GMax.Z:=GMax.Z+MinRAsInMir;

GMin.X:=GMin.X-MinRAsInMir;
GMin.Y:=GMin.Y-MinRAsInMir-10;
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

COLS[1]:=RanRcol;
COLS[2]:=RanRcol;
COLS[3]:=RanRcol;
COLS[4]:=RanRcol;

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
  IPlo.Del:=True;
  if KolD+1>MaxKolDelPlos then  ERR('Масив с удаленными плоскостями переполнен');
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
Var Rez:TELE;f:Longint;
begin
//-----------------------------------------------------
Rez:=TELE.CREATE;// Создаю экземпляр Элемента
Rez.OBJ:=OBJ;
Rez.ELE:=Self;
//-----------------------------------------------------

//-----------------------------------------------------
f:=1;while(f<=KolE)and(not ELES[f].DEL)do inc(f);
if f>KolE then begin
if KolE+1>MaxKOlVerInEle Then ERR('ПРевышено количество элементов в элементе');
ELES[KolE+1]:=Rez;// Добавляю элемент в список элементов
KolE:=KolE+1;// Увеличиваю количество  элементов
end else ELES[f]:=Rez;

MirEles.AddE(Rez);
//-----------------------------------------------------
E:=Rez;
end;
function    TELE.V(iX,iY,iZ:RSIN):TVER;// Добавляет вершину
Var Rez:TVER;f:Longint;
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
f:=1;while(f<=KolV)and(not VERS[f].DEL) do inc(f);
if f>KolV then begin
if KolV+1>MaxKOlVerInEle Then ERR('ПРевышено количество вершин в элементе');
VERS[KolV+1]:=Rez;// Добавляю Верину в список верши элемента
KolV:=KolV+1;// Увеличиваю количество вершин в элементе
end else VERS[f]:=Rez;
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
MirVers.ECOO2[VERS[f].NOM]:=
SerRCS8(MirVers.ECOO2[VERS[f].NOM],VERS[f].ECR);
MirVers.ECOO1[VERS[f].NOM]:=MirVers.ECOO2[VERS[f].NOM];
end;
end;
procedure   TELE.E_INIC;// Вычисление Экранны координат
var f:Longint;
begin
ECR:=REA;
for f:=1 to KolE do with ELES[f] do E_INIC;
for f:=1 to KolV do with VERS[f] do ECR:=REA;
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
  IEle.Del:=True;
  for f:=1 to iEle.KOlV do // Удаляю вершины
  if not iEle.VERS[f].del then MirVers.addD(iEle.VERS[f]);
  for f:=1 to iEle.KolE do // Удаляю элементы
  if not iEle.ELES[f].del then MirEles.AddD(iEle.Eles[f]);
  if KolD+1>MaxKolDelEles then ERR('МАсив с удаленными элементами переполнен');
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
  OCEL:RCS3;// Цель куда нужно перпемесчаться глобально
  OMOV:RCS3;// Куда нужно перемещаться в данный момент времени
  OPER:RBOL;// Если это управляемый персонаж
  MTP :TVER;// Маршрутная точка через котрую нужно пройти
  //OGRA:RBOL;// Являеться ли обьект гравитационным
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
  Procedure   O_Gaba;// Вычислене габаритов
  procedure   O_SWAP;// прямое изменение координат обьекта на экране
  Procedure   O_MASH(iMah:RSin);// Маштабирование
  procedure   O_Rabo;Virtual;// Работа
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
Function    AddO(iObj:TOBJ):Tobj;
procedure   AddD(iObj:TOBJ);
Constructor Create;
end;
var  MirObjs:TOBJS;
var  PER:TOBJ;// Персонаж котрым будем управлять
procedure   TOBJ.O_MATH;// Перевычисление Реальных Координат
var f:Longint;
begin
// Вычилсяю минимальные и максимальные значения вложеных элемнтов
E_Math;// Получаю Мат      Координаты
O_SREA;// Получаю Реальные Координаты
O_SECR;// Получаю Экранные координаты
O_GABA;// Вычисление габаритов
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
Procedure   TOBJ.O_GABA;// Вычислене габаритов
var f:Longint;
begin
E_GABA;
for f:=1 to KOlP do if not PLOS[f].DEL THEN PLOS[f].P_GABA;
for f:=1 to KOlL do if not LINS[f].DEL THEN LINS[f].L_GABA;
end;
procedure   TOBJ.O_INIC;// Запись реальных координат в экранные
var f:Longint;
begin
inherited E_INIC;
for f:=1 to KolP do with PLOS[F] do ECR:=REA;
for f:=1 to KolL do with LINS[F] do ECR:=REA;
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
Procedure   TOBJ.AddDels(iObj:Tobj);// * Добавлет зависимый обьект
begin
if (KolD+1>MaxKolObjInObj) then
ERR(' TOBJ.AddDels(iObj:Tobj) (KolD+1>MaxKolObjInObj)');
Dels[KolD+1]:=iObj;
KolD:=Kold+1;
end;
Procedure   TOBJ.DelDels(iObj:Tobj);// * Удаляет зависимый обьект
var f,f2:Longint;
begin
for f:=1 to KolD do
if DELS[f]=iObj Then begin
for f2:=f to KolD-1 do DELS[f2]:=DELS[f2+1];
KolD:=Kold-1;
end
end;
function    TOBJ.P(iVer1,iVer2,iVer3,iVer4:TVER):TPLO;// Добавляет плоскость
Var Rez:TPLO;f:Longint;
begin
//-----------------------------------------------------
Rez:=TPLO.CREATE(iVer1,iVer2,iVer3,iVer4);
Rez.Obj:=Obj;
Rez.Ele:=Self;
//-----------------------------------------------------

//-----------------------------------------------------
f:=1;while(f<=KOlP)and(not PLOS[f].DEL)do inc(f);
if f>KolP then begin
if KOlP+1>MaxKOlPloInObj Then ERR('ПРевышено количество плоскостей в обьекте');
PLOS[KolP+1]:=Rez;
KolP:=KolP+1;
end else PLOS[F]:=Rez;
MirPlos.AddP(Rez);
//-----------------------------------------------------
P:=Rez;
end;
function    TOBJ.L(iVer1,iVer2:TVER):TLIN;// Добавляет Линию
Var Rez:TLin;f:Longint;
begin
//-----------------------------------------------------
Rez:=TLIN.CREATE(iVer1,iVer2);
Rez.Obj:=Obj;
Rez.Ele:=Self;
//-----------------------------------------------------

//-----------------------------------------------------
f:=1;while(f<=KolL)and(not LINS[f].DEL) do inc(f);
if f>KolL then begin
if F+1>MaxKOlLinInObj Then ERR('ПРевышено количество линий в обьекте');
LINS[KolL+1]:=Rez;
KolL:=KolL+1;
end else LINS[f]:=Rez;
MirLins.AddL(Rez);
//-----------------------------------------------------
L:=Rez;
end;
procedure   TOBJ.O_Rabo;// Работа Обьекта
begin

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
OPER:=false;
OCEL:=NilRCS3;
OMOV:=NilRCS3;
end;
Destructor  Tobj.Destroy;
begin
inherited Destroy;
end;
procedure   TOBJS.AddD(iObj:TOBJ);
Var F:Longint;
begin
   if not iOBJ.Del then begin
   iOBJ.Del:=true;
   for f:=1 to iOBJ.KolL do // Удалене Линий
   if not iOBJ.Lins[f].del Then MirLins.AddD(iOBJ.Lins[f]);
   for f:=1 to iOBJ.KolP do // Удалене плоскостией
   if not iOBJ.Plos[f].del Then MirPLos.AddD(iOBJ.Plos[f]);
   for f:=1 to iOBJ.KOlV do // Вершины на удаление
   if not iOBJ.Vers[f].del Then MirVers.addD(iOBJ.VERS[f]);
   for f:=1 to iOBJ.KolE do // Удаление элементов
   if not iOBJ.Eles[f].del Then MirEles.AddD(iOBJ.Eles[f]);
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
var   {Анимации               ===========================}{%Region /FOLD }
                                                           RegA0:Longint;

TYpe  TAni=class(Tver)
end;

TYPE TAniS=CLASS
KOLA:Longint;
KOLD:Longint;
AniS:Array[1..MaxKOlAniInMir] of TAni;
DELA:Array[1..MaxKolDelScrs ] of TAni;
Function    AddA(iAni:TAni):TAni;
procedure   AddD(iAni:TAni);
Constructor Create;
end;
var  MirAnis:TAniS;
procedure   TAniS.AddD(iAni:TAni);
Var F:Longint;
begin
   if not iAni.Del then begin
   iAni.Del:=true;
   if KolD+1>MaxKolDelAnis then
   ERR('МАсив с удаленными анимациями переполнен');
   DELA[KolD+1]:=iAni;
   KolD:=KolD+1;
   end else ERR('Попытка удалить уже удаленную анимацию ');
end;
function    TAniS.AddA(iAni:TAni):TAni;
var F:Longint;Ex:Boolean;
begin
Ex:=False;
//------------------------------------------------------------------------------
if KolD>MinKolDelAnis then begin Ex:=True;
iAni.Nom:=DelA[1].NOM;
AniS[iAni.Nom]:=iAni;
DelA[1].Free;
for f:=1 to KolD-1 Do DelA[F]:=DelA[F+1];
KOlD:=KolD-1;
end;
//------------------------------------------------------------------------------
if Not Ex then Begin
if KolA+1>MaxkolScrinMir Then
ERR(' TScrS.AddS(iScr:TScr) KolS+1>MaxkolScrinMir');
iAni.Nom:=KolA+1;
KolA:=KolA+1;
AniS[iAni.Nom]:=iAni;
end;
AddA:=IAni;
end;
Constructor TAniS.Create;
begin
KolA:=0;
KolD:=0;
end;


{%EndRegion}
var   {Интепретатор           ===========================}{%Region /FOLD }
                                                           RegI0:Longint;

//------------------------------------------------------------------------------
Type  TEl=Class  // Элемент исполнения

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
  Procedure VlogitADD;// Вложение математических операций
  Procedure VlogitMUL;// Вложение математических операций
  Procedure VlogitSRA;// Вложение математических операций
  Procedure VlogitLET;// Вложение математических операций

  Function  FinFun(N:Ansistring):Tel;// ПОиск функции или переменной

  Procedure Cle   ;// Очистка элемента
  Function  Cop(iRod,iPre:Tel):Tel;// Создает копию элемента
  Procedure TRuns ;// Выполняет структуру
  Procedure TRun  ;// Выполняет 1 елемент
  Procedure RunFun;// Найти и выполнить пользовательскую функцию
  Procedure Op_ADD;// Сложение
  Procedure Op_SUB;// Вычитание
  Procedure Op_DIV;// Деление
  Procedure Op_MUL;// умножение

  Procedure Op_MEN;// Меньше
  Procedure Op_BOL;// Больше
  Procedure Op_BRA;// Больше либо равно
  Procedure Op_MRA;// Меньше либо равно
  Procedure Op_NER;// Не равно

  Procedure Op_Let;// Прсивоение
  Procedure Op_SCO;// Скобка
  Procedure Op_WHI;// While
  Procedure Op_PRI;// Вывод в консоль

end;
TYpe  TScr=class(Tver)
PRG:Tel;// ПРограмма
Function  ReadPars(S:Ansistring):Tel;
Procedure ViewElem(E:Tel;O:Ansistring);
Procedure ProgStru;
end;
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
//------------------------------------------------------------------------------
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
Function  Tel.Add(S:AnsiString;T:LongWord):Tel;
Var // Создает и Добавляет элемент в конец списка
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
Procedure TEl.VlogitMUL;// Вложение математических операций   '*/'
Var
Uka:Tel;
Begin
Uka:=Blo;
While UKA<>Nil do
Begin
if (Uka.pre<>nil) and (Uka.nex<>nil) and
   ((Uka.TXT='/') or (Uka.TXT='*'))
   Then begin
   Uka.Add(UKA.Pre);
   Uka.Add(UKA.Nex);
   end;
UKA.VlogitMUL;
Uka:=Uka.Nex;
end;
end;
Procedure TEl.VlogitADD;// Вложение математических операций   '+-'
Var
Uka:Tel;
Begin
Uka:=Blo;
While UKA<>Nil do
Begin
if (Uka.pre<>nil) and (Uka.nex<>nil) and
   ((Uka.TXT='+') or (Uka.TXT='-'))
   Then begin
   Uka.Add(UKA.Pre);
   Uka.Add(UKA.Nex);
   end;
UKA.VlogitADD;
Uka:=Uka.Nex;
end;
end;
Procedure TEl.VlogitSRA;// Вложение математических операций '><!='
Var
Uka:Tel;
Begin
Uka:=Blo;
While UKA<>Nil do
Begin
if (Uka.pre<>nil) and (Uka.nex<>nil) and
   ((Uka.TXT='<') or (Uka.TXT='>' ) or (Uka.TXT='<=')or
   (Uka.TXT='>=') or (Uka.TXT='!=') or (Uka.TXT='<>'))
   Then begin
   Uka.Add(UKA.Pre);
   Uka.Add(UKA.Nex);
   end;
UKA.VlogitSRA;
Uka:=Uka.Nex;
end;
end;
Procedure TEl.VlogitLET;// Вложение математических операций '><!='
Var
Uka:Tel;
Begin
Uka:=Blo;
While UKA<>Nil do
Begin
if (Uka.pre<>nil) and (Uka.nex<>nil) and (Uka.TXT=':=')
   Then begin
   Uka.Add(UKA.Pre);
   Uka.Add(UKA.Nex);
   end;
UKA.VlogitLET;
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
 sleep(1);
 If (Not UKA.FUN)    or
    (Uka.Txt='WHILE')or
    (UKA.Txt='IF')   Then Uka.TRun;
Uka:=Uka.Nex;
end;
end;
//------------------------------------------------------------------------------

Procedure Tel.Op_ADD;//  Сложение
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna) then
 zna:=FloatToStr(StrToFloat(Blo.zna)+StrToFloat(Blo.nex.zna)) else
 zna:=Blo.zna+Blo.nex.zna;
end;
end;
Procedure Tel.Op_SUB;// Вычитание
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna) then
 zna:=FloatToStr(StrToFloat(Blo.zna)-StrToFloat(Blo.nex.zna)) else
 ERR('Нельзя вычитать строки');
end;
end;
Procedure Tel.Op_DIV;//   Деление
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna) then
 if StrToFloat(Blo.nex.zna)=0 then
 zna:=FloatToStr(StrToFloat(Blo.zna)/StrToFloat(Blo.nex.zna)) else
 ERR('Делени на ноль') else ERR('Нельзя делить строки');
end;
end;
Procedure Tel.Op_MUL;// Умножение
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna) then
 zna:=FloatToStr(StrToFloat(Blo.zna)/StrToFloat(Blo.nex.zna)) else
 ERR('Нельзя Умножать строки');
end;
end;

Procedure Tel.Op_MEN;//    Меньше
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna)
 then zna:= BoolToStr(StrToFloat(Blo.zna)<StrToFloat(Blo.nex.zna))
 else zna:= BoolToStr(Blo.zna<Blo.nex.zna);
end;
end;
Procedure Tel.Op_BOL;//    Больше
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna)
 then zna:= BoolToStr(StrToFloat(Blo.zna)>StrToFloat(Blo.nex.zna))
 else zna:= BoolToStr(Blo.zna>Blo.nex.zna);
end;
end;
Procedure Tel.Op_MRA;// Меньше Ра
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna)
 then zna:= BoolToStr(StrToFloat(Blo.zna)<=StrToFloat(Blo.nex.zna))
 else zna:= BoolToStr(Blo.zna<=Blo.nex.zna);
end;
end;
Procedure Tel.Op_BRA;// Больше Ра
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna)
 then zna:= BoolToStr(StrToFloat(Blo.zna)>=StrToFloat(Blo.nex.zna))
 else zna:= BoolToStr(Blo.zna>=Blo.nex.zna);
end;
end;
Procedure Tel.Op_NER;//  Не равно
begin
if (blo<>nil)  and (blo.nex<>nil) Then
begin
 blo.TRun;
 blo.nex.TRun;
 if EtoCif(Blo.zna) and EtoCif(Blo.nex.zna)
 then zna:= BoolToStr(StrToFloat(Blo.zna)<>StrToFloat(Blo.nex.zna))
 else zna:= BoolToStr(Blo.zna<>Blo.nex.zna);
end;
end;

Procedure Tel.Op_LET; // = Операция присваивания значения
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
Procedure Tel.Op_SCO; // Выполняет скобку
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
Procedure Tel.Op_PRI; // Вывод в консоль
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
Form15.PRI(co);
end;

//------------------------------------------------------------------------------
Procedure Tel.TRun;// Выполняет 1 елемент
Begin
if Txt='+'              Then Op_ADD else // Сложение
if Txt='-'              Then Op_SUB else // Вычитание
if Txt='/'              Then Op_DIV else // Деление
if Txt='*'              Then Op_MUL else // Умножение
if Txt='<'              Then Op_MEN else // Меньше
if Txt='>'              Then Op_BOL else // Больше
if Txt='>='             Then Op_BRA else // Больше либо равно
if Txt='<='             Then Op_MRA else // Меньше либо равно
if Txt='<>'             Then Op_NER else // Неравно
if Txt='!='             Then Op_NER else // Неравно
if Txt=':='             Then Op_Let else // ПРисвоение
if Txt='('              Then Op_Sco else // ОТкрывающаяся скобка
if Txt='{'              Then TRuns  else // Открывающитйся блок
if Txt='WHILE'          Then Op_WHI else // Цикл while
if Txt='PRINT'          Then Op_PRI else // Оператор PRINT
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
Function  TScr.ReadPars(S:Ansistring):Tel; //  Разбивает строку на слова
var
  REZ:Tel;     // Списко слов на которые разита программа
  UKA:LongWord;// указатель на читаемый символ
  LEN:LongWord;// Длина Строки

Function REadSlo:Ansistring;// ДЛя чтения Операторов
Var
  REz:Ansistring;
begin
REz:='';
While (UKA<=LEN) and (
                        ((S[UKA]>='A') and (S[UKA]<='Z')) or
                        ((S[UKA]>='a') and (S[UKA]<='z')) or
                        ( S[UKA]='.' ) or
                        ( S[UKA]='_' )
                      ) do
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

If (UKA+1<=LEN) and        (
  (S[UKA]+S[UKA+1]='>=') or
  (S[UKA]+S[UKA+1]='<=') or
  (S[UKA]+S[UKA+1]='<>') or
  (S[UKA]+S[UKA+1]=':=')   )
      Then
      begin
      REZ:=REZ+S[UKA]+S[UKA+1];
      UKA:=UKA+2;
      end else
If (UKA<=LEN) and (
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
  (S[UKA]='=')    )
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
Procedure TScr.ViewElem(E:Tel;O:Ansistring);
Var // Выводит на печать содержимое элемента
L:TEl;
begin
L:=E.BLO;
While L<>Nil Do
 begin
 form15.memo1.Lines.add(O+L.TXT);
 if l.Blo<>Nil Then ViewElem(l,O+' ');
 L:=L.Nex;
 end;
end;
Procedure TScr.ProgStru;// Формирует структуру программы
begin
PRG.VlogitSc('(',')');
PRG.VlogitSc('{','}');
PRG.VlogitPA;
PRG.VlogitBl;
PRG.VlogitMUL;
PRG.VlogitADD;
PRG.VlogitSRA;
PRG.VlogitLET;
end;

TYPE TScrS=CLASS
SEL:Boolean;
KOLS:Longint;
KOLD:Longint;
SCRS:Array[1..MaxKOlScrInMir] of TSCR;
DELS:Array[1..MaxKolDelScrs ] of TSCR;
Function    AddS(iScr:TSCR):TSCR;
procedure   AddD(iScr:TSCR);
Constructor Create;
end;
var  MirScrs:TScrS;
procedure   TScrS.AddD(iScr:TScr);
Var F:Longint;
begin
   if not iScr.Del then begin
   iScr.Del:=true;
   if KolD+1>MaxKolDelScrs then
   ERR('МАсив с удаленными скриптами переполнен');
   DELS[KolD+1]:=iScr;
   KolD:=KolD+1;
   end else ERR('Попытка удалить уже удаленный скрипт');
end;
function    TScrS.AddS(iScr:TScr):TScr;
var F:Longint;Ex:Boolean;
begin
Ex:=False;
//------------------------------------------------------------------------------
if KolD>MinKolDelScrs then begin Ex:=True;
iScr.Nom:=DelS[1].NOM;
ScrS[iScr.Nom]:=iScr;
DelS[1].Free;
for f:=1 to KolD-1 Do DelS[F]:=DelS[F+1];
KOlD:=KolD-1;
end;
//------------------------------------------------------------------------------
if Not Ex then Begin
if KolS+1>MaxkolScrinMir Then
ERR(' TScrS.AddS(iScr:TScr) KolS+1>MaxkolScrinMir');
iScr.Nom:=KolS+1;
KolS:=KolS+1;
ScrS[iScr.Nom]:=iScr;
end;
AddS:=IScr;
end;
Constructor TScrS.Create;
begin
KolS:=0;
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
function  SELANIS:TSels;// Возвращает Список выделеных Анимаций
function  SELSCRS:TSels;// Возвращает Список выделеных Скриптов
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
function  TSels.SELANIS:TSels;// Возвращает Список выделеных Анимаций
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=T_ANI) then REz.Add(SELS[f]);
 SELANIS:=Rez;
end;
function  TSels.SELScrS:TSels;// Возвращает Список выделеных Скриптов
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=T_SCR) then REz.Add(SELS[f]);
 SELScrS:=Rez;
end;

{%EndRegion}
var   {Цвета                  ===========================}{%Region /FOLD }
                                                           Reg16:Longint;

type TCols=class
lDrKv:RLon;
lDrKp:RLon;
 DrKP:RLon;
KolV:RLon;// Количество вершин
KolP:RLon;// Количество Плоскостей
EVERS:Array[0..MaxKolVerInMir] of TVER;// Координаты всех вершин
ECOO1:Array[0..MaxKolVerInMir] of RCS3;// Координаты всех вершин
ECOO2:Array[0..MaxKolVerInMir] of RCS3;// Координаты вершин для отрисовке
ECOL1:Array[0..MaxKolVerInMir] of RCOL;// Цвета всех вершин
ECOL2:Array[0..MaxKolVerInMir] of RCOL;// Цвета всех вершин для отрисовки
EPlo1:Array[1..MaxKolPloInMir] of RPLO;// Индексы вершин Плоскостей формируються
EPlo2:Array[1..MaxKolPloInMir] of RPLO;// Индексы вершин Плоскостей для Экрана
function addV(iVer:Tver;iCol:RCol):RLON;
function addP(iVer1,iVer2,iVer3,iVer4:RLON):RLON;
constructor Create;
procedure   Swap;// Формирет масив вершин цаетов и индексов
end;
var MirCols:TCols;
function    TCols.addV(iVer:Tver;iCol:RCol):RLON;// Добавить вершину на от
begin
 lDrKv:=lDrKv+1;
 EVERS[lDrKv]:=Iver;
 ECOO1[lDrKv]:=Iver.ECR;// Экранная коорддината
 ECOL1[lDrKv]:=iCol;// Экранн цвет
 addV:=lDrKv;
end;
function    TCols.addP(iVer1,iVer2,iVer3,iVer4:RLON):RLON;// Доабв поскось
begin
 lDrKp:=lDrKp+1;
 EPlo1[lDrKp].VERS[1]:=iVer1;
 EPlo1[lDrKp].VERS[2]:=iVer2;
 EPlo1[lDrKp].VERS[3]:=iVer3;
 EPlo1[lDrKp].VERS[4]:=iVer3;
 EPlo1[lDrKp].VERS[5]:=iVer4;
 EPlo1[lDrKp].VERS[6]:=iVer1;
 addP:=lDrKp;
end;
constructor TCols.create;// Конструктор
begin
KolV:=0;
KolP:=0;
end;
procedure   TCols.Swap;// Формирет масив вершин цаетов и индексов
var lVer1,lVer2,lVer3,lVer4,lPlo1:RLON;f:RLON;
begin
lDrKp:=0;
lDrKv:=0;
for f:=1 to MirPLos.KolP do with MirPLos.PLos[f] do
if not Del and Vis and VVI then
     if MCL=1 then begin // Используем для цвета цвета вершин
     {
     lver1:=addV(VERS[1],VERS[1].ECO);
     lver2:=addV(VERS[2],VERS[2].ECO);
     lver3:=addV(VERS[3],VERS[3].ECO);
     lver4:=addV(VERS[4],VERS[4].ECO);
     lPlo1:=addP(lVer1,lVer2,lVer3,lVer4);
     }
     end
else if MCL=2 then begin // Используем для цвета цвет плоскости

     lver1:=addV(VERS[1],COL);sleep(1);
     lver2:=addV(VERS[2],COL);
     lver3:=addV(VERS[3],COL);
     lver4:=addV(VERS[4],COL);
     lPlo1:=addP(lVer1,lVer2,lVer3,lVer4);

     end
else if MCL=3 then begin // Используем для цвета цвета заданые в самой плоскои

     lver1:=addV(VERS[1],COLS[1]);sleep(1);
     lver2:=addV(VERS[2],COLS[2]);
     lver3:=addV(VERS[3],COLS[3]);
     lver4:=addV(VERS[4],COLS[4]);
     lPlo1:=addP(lVer1,lVer2,lVer3,lVer4);

     end;
     Move(ECoo1,ECoo2,(lDrKv+1)*SizeOf(RCS3));
     Move(ECol1,ECol2,(lDrKv+1)*SizeOf(RCOL));
     Move(EPlo1,EPlo2,(lDrKP+0)*SizeOf(RPLO));
     DrKP:=lDrKP;
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
     if iEle.Nam=iNam Then REz:=iEle;// Смотрю свое имя
//-------------------------------------------------
f:=1;if (iEle.TIP=T_OBJ)  Then
     while (f<=TOBJ(iEle).KolP) and (REz=Nil) do // Ищу среди Плоскостей
     if TOBJ(iEle).PLOS[f].NAM=iNAm then REz:=TOBJ(iEle).PLOS[f] else inc(f);
//-------------------------------------------------
f:=1;if (iEle.TIP=T_OBJ)  Then // Ищу среди Линий
     while (f<=TOBJ(iEle).KolL) and (REz=Nil) do
     if TObj(iEle).LINS[f].NAM=iNAm then REz:=TObj(iEle).LINS[f] else inc(f);
//-------------------------------------------------
f:=1;while (f<=iEle.KolV) and (REz=Nil) do // Ищу среди вершин
     if iEle.VERS[f].NAM=iNam then REz:=iEle.VERS[f] else inc(f);
//-------------------------------------------------
f:=1;while (f<=iEle.KolE) and (REz=Nil) do begin // Ищу среди Элементов
     REz:=I_FinNam(iEle.ELES[f],inam);inc(f);end;
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

while (f<=MirAnis.KolA) and (REz=Nil) do begin
if MirANIs.ANIS[f].NAM=iNam Then Rez:=MirANIs.ANIS[f];
f:=f+1;
end;

while (f<=MirScrs.KolS) and (REz=Nil) do begin
if MirScrs.ScrS[f].NAM=iNam Then Rez:=MirScrs.ScrS[f];
f:=f+1;
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
procedure I_RefSpiAnis(             iLis:TCheckListBox);//Список анимац
var
f:longint;// лдя циклов
NomItems:Longint;// Перебирать записи в листбоксе
begin
NomItems:=0;// Для перебора обье4ктов в списке
for f:=1 to MirAnis.KolA do
if Not MirAnis.AniS[f].DEL then begin // Если Анимация не удалена
NomItems:=NomItems+1;
if NomItems<iLis.Items.count then begin
// Изменяем записи в списке только если обьект в списке изменился
   iLis.selected[NomItems]:=MirAnis.ANIS[f].Sel;
   //form4.CheckListBox6.Checked[NomItems]:=MirObjs.OBJS[f].Sel;
   iLis.Items[NomItems]:=MirANis.ANIS[f].NAM;
if iLis.Items.Objects[NomItems]<>MirAnis.ANIS[f] then
   iLis.Items.Objects[NomItems]:=MirAnis.ANIS[f];
end
else
begin
iLis.Items.AddObject(MirANis.ANiS[f].Nam,MirANis.ANiS[f]);
iLis.selected[iLis.Count-1]:=MirANis.ANiS[f].Sel;
end

end;

// Удаляем лишнии записи в конце списка
while iLis.count-1>NomItems do
iLis.items.delete(iLis.count-1);


end;
procedure I_RefSpiScrs(             iLis:TCheckListBox);//Список скрипт
var
f:longint;// лдя циклов
NomItems:Longint;// Перебирать записи в листбоксе
begin
NomItems:=0;// Для перебора обье4ктов в списке
for f:=1 to MirScrs.KolS do
if Not MirScrs.ScrS[f].DEL then begin // Если обьект не удалён
NomItems:=NomItems+1;
if NomItems<iLis.Items.count then begin
// Изменяем записи в списке только если обьект в списке изменился
   iLis.selected[NomItems]:=MirScrs.ScrS[f].Sel;
   //form4.CheckListBox6.Checked[NomItems]:=MirObjs.OBJS[f].Sel;
   iLis.Items[NomItems]:=MirScrs.ScrS[f].NAM;
if iLis.Items.Objects[NomItems]<>MirScrs.ScrS[f] then
   iLis.Items.Objects[NomItems]:=MirScrs.ScrS[f];
end
else
begin
iLis.Items.AddObject(MirScrs.ScrS[f].Nam,MirScrs.ScrS[f]);
iLis.selected[iLis.Count-1]:=MirScrs.ScrS[f].Sel;
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
     I_RefSpiAnis((application.Components[f] as tform5) .CheckListBox2);
     I_RefSpiScrs((application.Components[f] as tform5) .CheckListBox3);
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
else if  (application.Components[f] is tform10) then begin
     (application.Components[f] as tform10).U_RefreshPlo;
     end
else if  (application.Components[f] is tform12) then begin
     (application.Components[f] as tform12).U_RefreshAni;
     end
else if  (application.Components[f] is tform13) then begin
     (application.Components[f] as tform13).U_RefreshScr;
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
edit1.Enabled :=false;edit1.text :='';
edit2.Enabled :=false;edit2.text :='';
edit3.Enabled :=false;edit3.text :='';
edit4.Enabled :=false;edit4.text :='';
edit5.Enabled :=false;edit5.text :='';
edit6.Enabled :=false;edit6.text :='';
edit7.Enabled :=false;edit7.text :='';edit7.color :=clDefault;
edit8.Enabled :=false;edit8.text :='';
edit9.Enabled :=false;edit9.text :='';
edit10.Enabled:=false;edit10.text:='';edit10.color:=clDefault;
edit11.Enabled:=false;edit11.text:='';edit11.color:=clDefault;
end
else begin // Если Есть выбраный активный элемент
// Читаюю координатиы
 edit1.Enabled:=true;I_GETX(Act,Edit1);
 edit2.Enabled:=true;I_GETY(Act,Edit2);
 edit3.Enabled:=true;I_GETZ(Act,Edit3);
 edit7.Enabled:=true;I_GETC(Act,Edit7);
 edit8.Enabled:=true;I_GETA(Act,Edit8);
 edit9.Enabled:=true;I_GETN(Act,Edit9);
edit10.Enabled:=true;I_GETM(Act,edit10);
edit11.Enabled:=true;I_GETV(Act,edit11);
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
 form9:TForm9;
 form10:TForm10;
 form12:TForm12;
 form13:TForm13;
begin
 form5 :=I_FindFormObjs      ;if Form5 <>nil Then begin // Обьекты
 Form5.U_RefreshObjs;
 end;
 form6 :=I_FindFormObj (iver);if Form6 <>nil Then begin //  Обьект
 Form6.U_RefreshObj;
 end;
 form7 :=I_FindFormEle (iver);if Form7 <>nil Then begin // Элемент
 Form7.U_RefreshEle;
 I_RefreshEditorPrimitiv(TEle(iver).Ele);// Обновить родительский элемент
 end;
 form8 :=I_FindFormVer (iver);if Form8 <>nil Then begin // Вершина
 Form8.U_RefreshVer;
 I_RefreshEditorPrimitiv(TVer(iver).Ele);// Обновить родительский элемент
 end;
 form9 :=I_FindFormLin (iver);if Form9 <>nil Then begin //   Линия
 Form9.U_RefreshLin;
 I_RefreshEditorPrimitiv(TLin(iver).Ele);// Обновить родительский элемент
 end;
 form10:=I_FindFormPlo (iver);if Form10<>nil Then begin // Плоскос
 Form10.U_RefreshPlo;
 I_RefreshEditorPrimitiv(TPlo(iver).Ele);// Обновить родительский элемент
 end;
 form12:=I_FindFormAni (TAni(iver));if Form12<>nil Then begin // Анимация
 Form12.U_RefreshAni;
 Form5.U_RefreshObjs;
 end;
 form13:=I_FindFormScr (TScr(iver));if Form13<>nil Then begin // Скрипт
 Form13.U_RefreshScr;
 Form5.U_RefreshObjs;
 end;
end;
procedure I_GetN(iPri:Pointer;iEdit:TEdit);
begin

if (Tobject(iPri) is Tver) then
if iEdit.Text<>TVEr(iPri).NAM then iEdit.Text:=TVEr(iPri).NAM;

end;
procedure I_GetT(iPri:Pointer;iMemo:TMemo);
begin

if (Tobject(iPri) is Tver) then
if iMemo.Text<>TVEr(iPri).txt then StrToMemo(TVEr(iPri).Txt,iMemo);

end;
procedure I_GeMl(iPlo:Pointer;iEdit:TEdit);
begin
if TPlo(iPlo).MCl<>inInt(iEdit.TEXT)  then begin
   iEdit.Text:=intToStr(TPlo(iPlo).MCL);
   end;
end;
procedure I_GetM(iVer:Pointer;iEdit:TEdit);
begin
if (boolToStr(TVEr(iVer).MAR)<>iEdit.TEXT)  then begin
   if TVEr(iVer).MAR then iEdit.Color:=clred else iEdit.Color:=clDefault;
   iEdit.Text:=BoolToStr(TVEr(iVer).MAR);
   end;
end;
procedure I_GetV(iVer:Pointer;iEdit:TEdit);
begin
if (boolToStr(TVEr(iVer).VIS)<>iEdit.TEXT)  then begin
   if TVEr(iVer).VIS then iEdit.Color:=clred else iEdit.Color:=clDefault;
   iEdit.Text:=BoolToStr(TVEr(iVer).VIS);
   end;
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
if iEdit.Text<>InString(RColRGBtoInt(TVEr(iVer).COL)) then begin
   lCol:=TVEr(iVer).Col;
   iEdit.Color:=RGBToColor(lCOL.R,lCOL.G,lCOL.B);
   iEdit.Text:=InString(RColRGBtoInt(TVEr(iVer).COL));
end;
end;

procedure I_GCV1(iPlo:Pointer;iEdit:TEdit);
var
lCol:Rcol;
begin
if iEdit.Text<>InString(RColRGBtoInt(TPlo(iPlo).COLS[1])) then begin
   lCol:=TPlo(iPlo).ColS[1];
   iEdit.Color:=RGBToColor(lCOL.R,lCOL.G,lCOL.B);
   iEdit.Text:=InString(RColRGBtoInt(TPlo(iPlo).COLS[1]));
end;
end;
procedure I_GCV2(iPlo:Pointer;iEdit:TEdit);
var
lCol:Rcol;
begin
if iEdit.Text<>InString(RColRGBtoInt(TPlo(iPlo).COLS[2])) then begin
   lCol:=TPlo(iPlo).Cols[1];
   iEdit.Color:=RGBToColor(lCOL.R,lCOL.G,lCOL.B);
   iEdit.Text:=InString(RColRGBtoInt(TPlo(iPlo).COLS[2]));
end;
end;
procedure I_GCV3(iPlo:Pointer;iEdit:TEdit);
var
lCol:Rcol;
begin
if iEdit.Text<>InString(RColRGBtoInt(TPlo(iPlo).COLS[3])) then begin
   lCol:=TPlo(iPlo).Cols[3];
   iEdit.Color:=RGBToColor(lCOL.R,lCOL.G,lCOL.B);
   iEdit.Text:=InString(RColRGBtoInt(TPlo(iPlo).COLS[3]));
end;
end;
procedure I_GCV4(iPlo:Pointer;iEdit:TEdit);
var
lCol:Rcol;
begin
if iEdit.Text<>InString(RColRGBtoInt(TPlo(iPlo).COLS[4])) then begin
   lCol:=TPlo(iPlo).Cols[4];
   iEdit.Color:=RGBToColor(lCOL.R,lCOL.G,lCOL.B);
   iEdit.Text:=InString(RColRGBtoInt(TPlo(iPlo).COLS[4]));
end;
end;

procedure I_GAV1(iPlo:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TPlo(iPlo).Cols[1].A) Then begin
   iEdit.Text:=InString(TPLO(iPlo).Cols[1].A);
end;
end;
procedure I_GAV2(iPlo:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TPlo(iPlo).Cols[2].A) Then begin
   iEdit.Text:=InString(TPlo(iPlo).Cols[2].A);
end;
end;
procedure I_GAV3(iPlo:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TPlo(iPlo).Cols[3].A) Then begin
   iEdit.Text:=InString(TPlo(iPlo).Cols[3].A);
end;
end;
procedure I_GAV4(iPlo:Pointer;iEdit:TEdit);
begin
if iEdit.Text<>InString(TPlo(iPlo).Cols[4].A) Then begin
   iEdit.Text:=InString(TPLo(iplo).Cols[4].A);
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
//-----------------------------------------------
procedure I_SeMl(iPlo:Pointer;iEdit:TEdit);
begin
if iPlo<>Nil Then
if (TPLo(iPlo).MCL<>inInt(iEdit.TEXT)) Then begin

G_Change:=true;
TPlo(iPlo).MCL:=inInt(iEdit.TEXT);
I_RefreshActivePrimitiv;
I_RefreshEditorPrimitiv(iPlo);
BLOK(iPlo);

end;
end;
procedure I_SetN(iVer:Pointer;iEdit:TEdit);
begin
if iVer<>Nil Then
if (TVEr(iVer).NAM<>iEdit.Text) Then begin

if (I_FinNam(iEdit.Text)=nil)or(pointer(I_FinNam(iEdit.Text))=iVer)
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

end else iEdit.Color:=clDefault;
end;
procedure I_SetT(iVer:Pointer;iMemo:TMemo);
begin
if iVer<>Nil Then
if (TVEr(iVer).Txt<>iMemo.Text) Then begin
  G_Change:=true;
  TVEr(iVer).Txt:=MemoToStr(iMemo);
  I_RefreshActivePrimitiv;
  I_RefreshEditorPrimitiv(iVer);
end;
end;
procedure I_SetM(iVer:Pointer;iEdit:TEdit);
begin
if iVer<>Nil Then
if (boolToStr(TVEr(iVer).MAR)<>iEdit.TEXT) Then begin

G_Change:=true;
TVEr(iVer).MAR:=StrToBool(iEdit.TEXT);
if TVEr(iVer).MAR THEN iEdit.Color:=clRed else iEdit.Color:=clDefault;
I_RefreshActivePrimitiv;
I_RefreshEditorPrimitiv(iVer);
BLOK(iVer);

end;
end;
procedure I_SetV(iVer:Pointer;iEdit:TEdit);// Видимость
begin
if iVer<>Nil Then
if (boolToStr(TVEr(iVer).VIS)<>iEdit.TEXT) Then begin

G_Change:=true;
TVEr(iVer).VIS:=StrToBool(iEdit.TEXT);
if TVEr(iVer).VIS THEN iEdit.Color:=clRed else iEdit.Color:=clDefault;
I_RefreshActivePrimitiv;
I_RefreshEditorPrimitiv(iVer);

end;
end;
procedure I_SetX(iVer:Pointer;iEdit:TEdit);
begin
if iVer<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>InString(TVEr(iVer).Loc.X) then begin
   G_Change:=true;
   TVEr(iVer).Loc.X:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iVer);
   BLOK(iVer);

end;
end;
procedure I_SetY(iVer:Pointer;iEdit:TEdit);
begin
if iVer<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TVEr(iVer).Loc.Y) then begin
   G_Change:=true;
   TVEr(iVer).Loc.Y:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iVer);
   BLOK(iVer);
end;
end;
procedure I_SetZ(iVer:Pointer;iEdit:TEdit);
begin
if iVer<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TVEr(iVer).Loc.Z) then begin
   G_Change:=true;
   TVEr(iVer).Loc.Z:=inFloat(iEdit.Text);
   I_RefreshEditorPrimitiv(iVer);
   BLOK(iVer);
end;
end;

procedure I_SetC(iVer:Pointer;iEdit:TEdit);
begin
if iVer<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(RColRgbToInt(TVEr(iVer).COL))  then begin

   G_Change:=true;
   TVEr(iVer).COL.R:=Red  (trunc(inFloat(iEdit.Text)));
   TVEr(iVer).COL.G:=Green(trunc(inFloat(iEdit.Text)));
   TVEr(iVer).COL.B:=Blue (trunc(inFloat(iEdit.Text)));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iVer);
   BLOk(iVer);
end;

end;
procedure I_SCV1(iPlo:Pointer;iEdit:TEdit);
begin
if iPlo<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(RColRgbToInt(TPlo(iPlo).COLS[1]))  then begin

   G_Change:=true;
   TPLo(iPlo).COLS[1].R:=Red  (trunc(inFloat(iEdit.Text)));
   TPLo(iPlo).COLS[1].G:=Green(trunc(inFloat(iEdit.Text)));
   TPLo(iPLo).COLS[1].B:=Blue (trunc(inFloat(iEdit.Text)));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iPlo);
   BLOk(iPlo);
end;

end;
procedure I_SCV2(iPlo:Pointer;iEdit:TEdit);
begin
if iPLo<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(RColRgbToInt(TPlo(iPlo).COLS[2]))  then begin

   G_Change:=true;
   TPLo(iPlo).COLS[2].R:=Red  (trunc(inFloat(iEdit.Text)));
   TPLo(iPlo).COLS[2].G:=Green(trunc(inFloat(iEdit.Text)));
   TPLo(iPLo).COLS[2].B:=Blue (trunc(inFloat(iEdit.Text)));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iPlo);
   BLOk(iPlo);
end;

end;
procedure I_SCV3(iPlo:Pointer;iEdit:TEdit);
begin
if iPLo<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(RColRgbToInt(TPlo(iPlo).COLS[3]))  then begin

   G_Change:=true;
   TPLo(iPlo).COLS[3].R:=Red  (trunc(inFloat(iEdit.Text)));
   TPLo(iPlo).COLS[3].G:=Green(trunc(inFloat(iEdit.Text)));
   TPLo(iPLo).COLS[3].B:=Blue (trunc(inFloat(iEdit.Text)));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iPlo);
   BLOk(iPlo);
end;

end;
procedure I_SCV4(iPlo:Pointer;iEdit:TEdit);
begin
if iPLo<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(RColRgbToInt(TPlo(iPlo).COLS[4]))  then begin

   G_Change:=true;
   TPLo(iPlo).COLS[4].R:=Red  (trunc(inFloat(iEdit.Text)));
   TPLo(iPlo).COLS[4].G:=Green(trunc(inFloat(iEdit.Text)));
   TPLo(iPLo).COLS[4].B:=Blue (trunc(inFloat(iEdit.Text)));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iPlo);
   BLOk(iPlo);
end;

end;

procedure I_SAV1(iPlo:Pointer;iEdit:TEdit);
begin
if iPlo<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TPlo(iPlo).COLS[1].A) then begin

   G_Change:=true;
   TPLo(iPLo).COLS[1].A:=trunc(inFloat(iEdit.Text));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iPlo);
   BLOk(iPlo);
end;
end;
procedure I_SAV2(iPlo:Pointer;iEdit:TEdit);
begin
if iPlo<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TPlo(iPlo).COLS[2].A) then begin

   G_Change:=true;
   TPLo(iPLo).COLS[2].A:=trunc(inFloat(iEdit.Text));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iPLo);
   BLOk(iPlo);
end;
end;
procedure I_SAV3(iPlo:Pointer;iEdit:TEdit);
begin
if iPlo<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TPlo(iPlo).COLS[3].A) then begin

   G_Change:=true;
   TPLo(iPLo).COLS[3].A:=trunc(inFloat(iEdit.Text));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iPlo);
   BLOk(iPlo);
end;
end;
procedure I_SAV4(iPlo:Pointer;iEdit:TEdit);
begin
if iPlo<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TPlo(iPlo).COLS[4].A) then begin

   G_Change:=true;
   TPLo(iPLo).COLS[4].A:=trunc(inFloat(iEdit.Text));
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iPlo);
   BLOk(iPlo);
end;
end;

procedure I_SetA(iVer:Pointer;iEdit:TEdit);
begin
if iVer<>Nil Then
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
if iEle<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TEle(iEle).EUGL.X) then begin

   G_Change:=true;
   TEle(iEle).EUGL.X:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iEle);
   BLOK(iele);

end;
end;
procedure I_SeUY(iEle:Pointer;iEdit:TEdit);
begin
if iEle<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TEle(iEle).EUGL.Y) then begin

   G_Change:=true;
   TEle(iEle).EUGL.Y:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iEle);
   BLOK(iEle);

end;
end;
procedure I_SeUZ(iEle:Pointer;iEdit:TEdit);
begin
if iEle<>Nil Then
if isFloat(iEdit.Text) then
if iEdit.Text<>inString(TEle(iEle).EUGL.Z)  then begin
   G_Change:=true;
   TEle(iEle).EUGL.Z:=inFloat(iEdit.Text);
   I_RefreshActivePrimitiv;
   I_RefreshEditorPrimitiv(iEle);
   BLOK(iEle);

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

procedure I_DrVer   (iCoo:RCS3;iCol:RCol);// Вывод   Вершины
begin
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_POINTS);
glVertex3f(iCoo.X,iCoo.Y,iCoo.Z);
glEnd();
end;
procedure I_DrVer   (iVer:TVer;iCol:RCol);// Вывод   Вершины
begin
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_POINTS);
glVertex3f(iVer.ECR.X,iVer.ECR.Y,iVer.ECR.Z);
glEnd();
end;
procedure I_DrLin   (iLin:TLin;iCol:RCol);// Вывод     Линии
var C:RCol;
begin
C:=iLin.Col;
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_LINES);
glVertex3f(iLin.VERS[1].ECR.X,iLin.VERS[1].ECR.Y,iLin.VERS[1].ECR.Z);
glVertex3f(iLin.VERS[2].ECR.X,iLin.VERS[2].ECR.Y,iLin.VERS[2].ECR.Z);
glEnd();
end;
procedure I_DrPlo   (iPlo:TPlo;iCol:RCol);// Вывод Плоскости
var C:RCol;
begin
C:=iPlo.Col;
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_QUADS);
glVertex3f(iPlo.Vers[1].ECR.X,iPlo.Vers[1].ECR.Y,iPlo.Vers[1].ECR.Z);
glVertex3f(iPlo.Vers[2].ECR.X,iPlo.Vers[2].ECR.Y,iPlo.Vers[2].ECR.Z);
glVertex3f(iPlo.Vers[3].ECR.X,iPlo.Vers[3].ECR.Y,iPlo.Vers[3].ECR.Z);
glVertex3f(iPlo.Vers[4].ECR.X,iPlo.Vers[4].ECR.Y,iPlo.Vers[4].ECR.Z);
glEnd();
end;
procedure I_DrEle   (iEle:TEle;iCol:RCol);// Вывод  Элемента
var C:RCol;
begin
C:=iEle.Col;
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_LINES);
I_DrCub(iEle.GMin,iEle.GMax);
glEnd();
end;
procedure I_DrObj   (iObj:TObj;iCol:RCol);// Вывод   ОБьекта
begin
glColor4ub(iCol.R,iCol.G,iCol.B,iCol.A);
glBegin(GL_LINES);
I_DrCub(iObj.GMin,iObj.GMax);
glEnd();
end;




{%EndRegion}

var   {----------------------- Добавлоение примитива  ===}{%Region /FOLD }
                                                          E_Reg11:Longint;
Procedure  I_TOBJ_ANI_01(iObj1,iObj2:TObj;var iStr:Ansistring);forward;
Procedure  I_TOBJ_PUT_01(iObj:TObj;var iStr:Ansistring);forward;
function   I_GetEl(iVer:Pointer):Tele;// Извлекает Элемен в котором находимся
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
function   I_AddVerCOP(iEle:Pointer):Pointer;// Создает копию вершины рядом
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x+10,
             TVER(iEle).LOC.y,
             TVER(iEle).LOC.z);
nVer.Col:=TVER(iEle).Col;
nVer.Nam:=I_NewNamIdd('V ');
I_RefAllForm;
I_AddVerCOP:=nVer;
U_OpenPoint(nVer,nVer.Ele);
end;
function   I_AddObjCOP(iEle:Pointer):Pointer;// Создает копию обьекта
var
lStr:Ansistring;
rez:Pointer;
begin
I_TOBJ_PUT_01(TObj(iEle),lStr);// превращаем обьект в строку
rez:=I_SCENA_DOU_01(lStr);// Превращаем строку в обьект
if rez<>Nil Then  begin
            Tobj(rez).LOC.x:=Tobj(rez).LOC.x+10;
            U_OpenObject(rez);
            end;
I_AddObjCOP:=Rez;
end;
function   I_AddPriCop(iPri:Pointer):Pointer;// Создает копию Примитива
Var
lVer:Tver;
Rez:Pointer;
begin
lVer:=Tver(iPri)   ;
if lVer.TIP=T_VER Then Rez:=I_AddVerCOP(iPri) else
//if lVer.TIP=T_ELE Then Rez:=I_AddEleCOP(iPri) else
if lVer.TIP=T_OBJ Then Rez:=I_AddObjCOP(iPri) ;
I_AddPriCop:=Rez;
end;
function   I_GetOb(iVer:Pointer):TObj;// Извлекает Обьект в котором находимся
var REz:TObj;lVer:TVer;
begin

      lVer:=TVer(iVer);
      if lVer=nil then ERR(' I_GetOb iVer=nil  ') else
      if lVer.OBJ.TIP=T_OBJ Then Rez:=TObj(lVer.OBJ) else
      ERR(' I_GetOb iVer.OBJ.TIP<>T_OBJ ');
      I_GetOb:=Rez;

end;
function   I_AddVerSYX(iEle:Pointer):Pointer;// Создает симетричную вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x*-1,TVER(iEle).LOC.y,TVER(iEle).LOC.z);
nVer.Nam:=I_NewNamIdd('V ');
nVer.Col:=TVER(iEle).Col;
I_RefAllForm;
I_AddVerSYX:=nVer;
U_OpenPoint(nVer,nVer.Ele);
end;
function   I_AddVerSYY(iEle:Pointer):Pointer;// Создает симетричную вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x,TVER(iEle).LOC.y*-1,TVER(iEle).LOC.z);
nVer.Nam:=I_NewNamIdd('V ');
nVer.Col:=TVER(iEle).Col;
I_RefAllForm;
I_AddVerSYY:=nVer;
U_OpenPoint(nVer,nVer.Ele);
end;
function   I_AddVerSYZ(iEle:Pointer):Pointer;// Создает симетричную вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x,TVER(iEle).LOC.y,TVER(iEle).LOC.z*-1);
nVer.Nam:=I_NewNamIdd('V ');
nVer.Col:=TVER(iEle).Col;
I_RefAllForm;
I_AddVerSYZ:=nVer;
U_OpenPoint(nVer,nVer.Ele);
end;
function   I_AddVer150(iEle:Pointer):Pointer;// Создает симетричную вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x,TVER(iEle).LOC.y+150,TVER(iEle).LOC.z);
nVer.Nam:=I_NewNamIdd('V ');
nVer.Col:=TVER(iEle).Col;
I_RefAllForm;
I_AddVer150:=nVer;
U_OpenPoint(nVer,nVer.Ele);
end;
function   I_AddVni150(iEle:Pointer):Pointer;// Создает симетричную вершину
Var
rEle:TEle;
nVer:TVer;
begin
G_Change:=true;
rEle:=I_GetEl(iEle);
nVer:=rEle.V(TVER(iEle).LOC.x,TVER(iEle).LOC.y-150,TVER(iEle).LOC.z);
nVer.Nam:=I_NewNamIdd('V ');
nVer.Col:=TVER(iEle).Col;
I_RefAllForm;
I_AddVni150:=nVer;
U_OpenPoint(nVer,nVer.Ele);
end;
function   I_AddVerMar(iPlo:Pointer):Pointer;// Создает  Маршрутные вершину
Var
rEle:TEle;la,lb,lc,ld:RCS3;lPlo:Tplo;
procedure Center(ia,ib,ic,id:RCS3;iG:Longint);
var
LAC,LAB,LBC,LCD,LDA:RCS3;nVer:TVer;
begin
LAC:=SerRCS3(ia,ic);
LAB:=SerRCS3(ia,ib);
LBC:=SerRCS3(ib,ic);
LCD:=SerRCS3(ic,id);
LDA:=SerRCS3(id,ia);
nVer:=rEle.V(LAC.x,LAC.y,LAC.z);
nVer.Nam:=I_NewNamIdd('V ');
nVer.Col:=CreRcol(Random(100),Random(150)+100,100,255);
nVer.MAR:=True;
if iG<2 then begin
Center(LDA,ia,lAB,lAC,ig+1);
Center(LAB,ib,lBC,lAC,ig+1);
Center(LBC,ic,lCD,lAC,ig+1);
Center(LCD,id,lDA,lAC,ig+1);
end;
end;
begin
if iPlo<>Nil Then
if Tver(iPlo).TIP=T_PLO then begin
G_Change:=true;
rEle:=I_GetOb(iPlo);// ПОлучаю родительский элемент
lPlo:=TPlo(iPlo);
lA:=lPlo.VERS[1].Rea;
lB:=lPlo.VERS[2].Rea;
lC:=lPlo.VERS[3].Rea;
lD:=lPlo.VERS[4].Rea;
center(la,lb,lc,ld,0);
I_RefAllForm;
end;
I_AddVerMar:=Nil;
end;
function   I_AddVerLan(iEle:Pointer):Pointer;// Создает Ландшафтные вершины
Var
rEle:TEle;
nVer:TVer;
HX,Hz:Double;
V:Array[-3..3,-3..3]  of Tver;
nPl:Tplo;
fx,fz:Longint;
begin
G_Change:=true;
rEle:=I_GetOb(iEle);// ПОлучаю родительский элемент
if Tver(iEle).TIP=T_PLO then begin

HX:=((TVER(iEle).GMAX.x-TVER(iEle).GMIN.x)/6);
HZ:=((TVER(iEle).GMAX.z-TVER(iEle).GMIN.z)/6);

for fx:=-3 to 3 do
for fz:=-3 to 3 do begin
nVer:=rEle.V(
  (HX*fx),
  0,
  (Hz*fz));
nVer.Nam:=I_NewNamIdd('V ');
nVer.Loc.Y:=Random(25);
nVer.Col:=CreRcol(Random(100),Random(150)+100,100,255);
V[fx,fz]:=nVer;
end;

for fx:=-3 to 2 do
for fz:=-3 to 2 do begin
nPl:=TObj(rEle).P(
             v[fx  ,fz  ],
             v[fx  ,fz+1],
             v[fx+1,fz+1],
             v[fx+1,fz  ]);
nPl.Nam:=I_NewNamIdd('P ');
nPl.Col:=TVER(iEle).Col;
end;

I_RefAllForm;
end;
I_AddVerLan:=Nil;
end;
function   I_AddVer(iEle:Pointer):Pointer;// Добавляет Вершину
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
function   I_AddLin(iObj:Pointer):Pointer;// Доабвляет   Линию
Var
rObj:TObj;
nLin:TLin;
lSel:TSels;
begin
G_Change:=true;
lSel:=MirSels.SELVERS;
if lSel.KOl>=2 Then
if lSel.SELS[1].obj=lSel.SELS[2] Then begin
rObj:=I_GetOb(iObj);
nLin:=rObj.L(lSel.SELS[2],
             lSel.SELS[1]);
nLin.Nam:=I_NewNamIdd('L ');
end;
lSel.free;
I_RefAllForm;
I_AddLin:=nLin;
end;
function   I_AddPLi(iObj:Pointer):Pointer;// Доабвляет пустую  Линию
Var
rObj:TObj;
nLin:TLin;
lSel:TSels;
begin
G_Change:=true;
rObj:=I_GetOb(iObj);
nLin:=rObj.L(rObj,rObj);
nLin.Nam:=I_NewNamIdd('L ');
I_AddPLi:=nLin;
end;
function   I_AddPlo(iObj:Pointer):Pointer;// Доабвляет Плоскос
Var
rObj:TObj;
nPLo:TPlo;
lSel:TSels;
begin
G_Change:=true;
lSel:=MirSels.SELVERS;
if lSel.KOl>=4 Then
if (lSel.SELS[1].OBJ=lSel.SELS[2].OBJ) and
   (lSel.SELS[2].OBJ=lSel.SELS[3].OBJ) and
   (lSel.SELS[3].OBJ=lSel.SELS[4].OBJ) and
   (lSel.SELS[4].OBJ=lSel.SELS[1].OBJ) then begin
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
function   I_AddPPl(iObj:Pointer):Pointer;// Доаб пуст Плоскос
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
function   I_AddEle(iEle:Pointer):Pointer;// Доабвляет Элемент
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
function   I_AddObj:Pointer;// Добавляет новый обьект
Var nObj:TObj;
begin
G_Change:=true;
nObj:=TObj.Create;
nObj.Nam:=I_NewNamiDd('O ');
MirObjs.AddO(nObj);
I_RefAllForm;
I_AddObj:=nObj;
end;
function   I_AddAni:Pointer;// Добавить Анимацию
var
nAni:TAni;
lSelObjs:TSels;
begin
nAni:=Nil;
lSelObjs:=MirSels.SELOBJS;
if lSelObjs.KOl=2 then begin
G_Change:=true;

// Следующие состояние
nAni:=TAni.Create;
nAni.Nam:=I_NewNamiDd('A ');
I_TOBJ_ANI_01(TObj(lSelObjs.SELS[2]),TObj(lSelObjs.SELS[1]),nAni.TXT);
MirAnis.AddA(nAni);
// Предыдущие состояние
nAni:=TAni.Create;
nAni.Nam:=I_NewNamiDd('A ');
I_TOBJ_ANI_01(TObj(lSelObjs.SELS[1]),TObj(lSelObjs.SELS[2]),nAni.TXT);
MirAnis.AddA(nAni);
I_RefAllForm;

end;
lSelObjs.free;
I_AddAni:=nAni;
end;
function   I_AddPAn:Pointer;// Добавить пустую анимацию
var
nAni:TAni;
begin
nAni:=Nil;
G_Change:=true;
// Следующие состояние
nAni:=TAni.Create;
nAni.Nam:=I_NewNamiDd('A ');
MirAnis.AddA(nAni);
I_RefAllForm;
I_AddPAn:=nAni;
end;
function   I_AddScr:Pointer;// Добавить пустой скрипт
var nScr:TScr;
begin
G_Change:=true;
nScr:=TScr.Create;
nScr.Nam:=I_NewNamiDd('S ');
MirScrs.AddS(nScr);
I_RefAllForm;
I_AddScr:=nScr;
end;
function   I_AddPSc:Pointer;// Добавить пустой скрипт
var nScr:TScr;
begin
G_Change:=true;
nScr:=TScr.Create;
nScr.Nam:=I_NewNamiDd('S ');
MirScrs.AddS(nScr);
I_RefAllForm;
I_AddPSc:=nScr;
end;
function   I_RUN(iScr:Pointer;iMemo:TMemo):POinter;// Выполнить скрипт
var lScr:TScr;
begin
lScr:=TScr(iScr);
if lScr.PRG<>nil Then lScr.PRG.Cle;
lScr.PRG:=lScr.ReAdPArs(AnsiUpperCase(lScr.TXT));
lScr.ProgStru;// Формирование структуры программы
//lScr.ViewElem(lScr.PRG,''); //Для отладки вывод структуры
lScr.PRG.TRUNS;
I_RUN:=Nil;
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
procedure I_DelFormsVer(iVer:TVer);// Удаляет формы связаную с   Вершиной
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
procedure I_DelFormsEle(iEle:TEle);// Удаляет формы связаную с  Элементом
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
procedure I_DelFormsObj(iObj:TObj);// Удаляет формы связаную с   Обьектом
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
procedure I_DelFormsAni(iAni:TAni);// Удаляет формы связаную с   Анимацие
var
f:Longint;
lForm12:TForm12;
begin
    lForm12:=I_FindFormANi(iAni);
    while lForm12<>Nil do begin
    lForm12.close;
    lForm12:=I_FindFormAni(iAni);
    end;
end;
procedure I_DelFormsScr(iScr:TScr);// Удаляет формы связаную с   Скриптам
var
f:Longint;
lForm13:TForm13;
begin
    lForm13:=I_FindFormScr(iScr);
    while lForm13<>Nil do begin
    lForm13.close;
    lForm13:=I_FindFormScr(iScr);
    end;
end;

procedure I_DelVer(iVer:POinter);// Удаление Вершины
begin
if not tVer(iVer).Del then begin
G_Change:=true;
I_SetSel(iVer,false);// Снимаю выделение елси оно есть
I_DelFormsVer(Tver(iVer));
MirVers.AddD(Tver(iVer));
I_RefAllForm;
end else ERR(' I_DelVer Попытка удалить уже удаленную вершину');
end;
procedure I_DelLin(iLin:POinter);// Удаление   Линии
begin
if not tLin(ILin).Del then begin
G_Change:=true;
I_SetSel(iLin,false);// Снимаю выделение елси оно есть
I_DelFormsLin(TLin(iLin));
MirLins.AddD(TLin(iLin));
I_RefAllForm;
end else ERR('I_DelLin попутка удалить линию котрая уже удалена');
end;
procedure I_DelPLo(iPlo:POinter);// Удаление Плоскос
begin
if Not TPlo(IPlo).Del then begin
G_Change:=true;
I_SetSel(iPlo,false);// Снимаю выделение елси оно есть
I_DelFormsPlo(TPlo(iPlo));
MirPlos.AddD(TPlo(iPlo));
I_RefAllForm;
end else ERR('I_DelPLo ПОпытка удалить уже удаленную плоскость');
end;
procedure I_DelEle(iEle:POinter);// Удаление Элемент
var F:longint;lEle:TEle;
begin
lEle:=Tele(iele);
if not lEle.Del then begin
G_Change:=true;
I_SetSel(lEle,false);// Снимаю выделение елси оно есть

for f:=1 to lEle.KOlV do // Снимаю выделение с вершин
if not lEle.VERS[f].del then I_SetSel(lEle.VERS[f],false);
for f:=1 to lEle.KolE do // Снимаю выделение с Элементов
if not lEle.ELES[f].del then I_SetSel(lEle.ELES[f],false);

I_DelFormsEle(lEle);
MirEles.AddD(lEle);
I_RefAllForm;
end else  ERR(' I_DelEle ПОпытка удалить уже удаленный элемент ');
end;
procedure I_DelObj(iObj:POinter);// Удаление Обьекта
var f:Longint;lObj:TObj;
begin
lObj:=Tobj(iOBJ);
if not lObj.Del then begin
G_Change:=true;
I_SetSel(lObj,false);// Снимаю выделение если оно есть
for f:=1 to lObj.KolL do // Сниманию выдлеение с Линий
if not lObj.Lins[f].del Then I_SetSel(lObj.Lins[f],false);
for f:=1 to lOBJ.KolP do // Сниманию выдлеение с плоскостией
if not lOBJ.Plos[f].del Then I_SetSel(lOBJ.Plos[f],false);
for f:=1 to lOBJ.KOlV do // Сниманию выдлеение с Вершин
if not lOBJ.Vers[f].del Then I_SetSel(lOBJ.VERS[f],false);
for f:=1 to lOBJ.KolE do // Сниманию выдлеение с элементов
if not lOBJ.Eles[f].del Then I_SetSel(lOBJ.Eles[f],false);
I_DelFormsObj(lObj);
MirObjs.AddD(lObj);
I_RefAllForm;
end else ERR(' I_DelObj Попытка удалить уже удаленный обьект');
end;
procedure I_DelAni(iAni:POinter);// Удаление Анимаци
var f:Longint;lANi:TAni;
begin
lAni:=TAni(iAni);
if not lAni.Del then begin
G_Change:=true;
I_SetSel(lAni,false);// Снимаю выделение если оно есть
I_DelFormsAni(lAni);
MirAnis.AddD(lAni);
I_RefAllForm;
end else ERR(' I_DelAni Попытка удалить уже удаленную анимацию ');
end;
procedure I_DelScr(iScr:POinter);// Удаление Скрипта
var f:Longint;lScr:TScr;
begin
lScr:=TScr(iScr);
if not lScr.Del then begin
G_Change:=true;
I_SetSel(lScr,false);// Снимаю выделение если оно есть
I_DelFormsScr(lScr);
MirScrs.AddD(lScr);
I_RefAllForm;
end else ERR(' I_DelScr Попытка удалить уже удаленный скрипт');
end;

procedure I_DelDel(iPri:POinter);
begin
if      iPri<>Nil       then
if TVER(iPri).TIP=T_VER then I_DelVer(iPri) else
if TVER(iPri).TIP=T_LIN then I_DelLin(iPri) else
if TVER(iPri).TIP=T_PLO then I_DelPlo(iPri) else
if TVER(iPri).TIP=T_ELE then I_DelEle(iPri) else
if TVER(iPri).TIP=T_OBJ then I_DelObj(iPri) ;
end;

procedure I_DelNotUseVer;// Удаляет не используемые вершины
var fv,fp,fl,kd:Longint;d:Boolean;
begin
fv:=1;kd:=0;
while  fv<=MirVers.KolV do begin
if MirVers.VerS[Fv].Del=false then
begin
d:=true;
fp:=1;
while  (fp<=MirPlos.KolP) and (d=true)do begin
if  MirPlos.PLOS[Fp].DEL=false  then begin
if  MirPlos.PLOS[Fp].VERS[1]=MirVers.VerS[Fv] then d:=false;
if  MirPlos.PLOS[Fp].VERS[2]=MirVers.VerS[Fv] then d:=false;
if  MirPlos.PLOS[Fp].VERS[3]=MirVers.VerS[Fv] then d:=false;
if  MirPlos.PLOS[Fp].VERS[4]=MirVers.VerS[Fv] then d:=false;
end;
fp:=fp+1;
end;


fl:=1;
while  (fl<=MirLINs.KolL) and (d=true)do begin
if MirLins.LinS[Fl].DEL=false  then
begin
if  MirLins.LINS[Fl].VERS[1]=MirVers.VerS[Fv] then d:=false;
if  MirLins.LINS[Fl].VERS[2]=MirVers.VerS[Fv] then d:=false;
end;
fl:=fl+1;
end;
if d then  begin I_DelVer(MirVers.VerS[Fv]);KD:=KD+1;end;
end;
FV:=FV+1;
end;
I_RefAllForm;
ShowMessage('Удалили '+intToStr(KD)+' Вершин ');
end;

{%EndRegion}
var   {----------------------- ПОиск примитива        ===}{%Region /FOLD }
                                                           G_Reg11:Longint;

function  I_FIN_ANI(          iNam:Ansistring):TAni;// Ищит Анимацию
var
Rez:TAni;
F:Longint;
begin
          rez:=Nil;
          f:=1;while(f<=MirAnis.KOlA)and(REz=NIl)do
          if (not MirAnis.AniS[f].DEL) and (MirAnis.AniS[f].NAM=iNam)
          then Rez:=MirAnis.ANiS[f]
          else f:=f+1;
          I_FIN_ANI:=Rez;
end;
function  I_FIN_SCR(          iNam:Ansistring):TScr;// Ищит Скрипт
var
Rez:TScr;
F:Longint;
begin
          rez:=Nil;
          f:=1;while(f<=MirScrs.KOlS)and(REz=NIl)do
          if (not MirScrs.ScrS[f].DEL) and (MirScrs.ScrS[f].NAM=iNam)
          then Rez:=MirScrs.ScrS[f]
          else f:=f+1;
          I_FIN_Scr:=Rez;
end;


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

iStr:=iStr+'M('+boolToStr(iVer.Mar)+')';// являеться ли примитив маршрутным

iStr:=iStr+'X('+InString(iVer.LOC.X)+')';// Координаты вершины X
iStr:=iStr+'Y('+InString(iVer.LOC.Y)+')';// Координаты вершины Y
iStr:=iStr+'Z('+InString(iVer.LOC.Z)+')';// Координаты вершины Z

iStr:=iStr+'C('+intToStr(RColRGBAtoInt(iVer.COL))+')';// Цвет


iStr:=iStr+LN;

end;
Procedure I_TLIN_PUT_01(iLin:TLin;var iStr:Ansistring);
begin
iStr:=iStr+'L('+iLin.NAM+')';// Сохраняю имя

iStr:=iStr+'M('+boolToStr(iLin.Mar)+')';// являеться ли примитив маршрутным

iStr:=iStr+'C('+intToStr(RColRGBAtoInt(iLin.COL))+')';// Цвет

iStr:=iStr+'e('+iLin.VERS[1].NAm+')';// Вершина 1
iStr:=iStr+'f('+iLin.VERS[2].NAm+')';// Вершина 2

iStr:=iStr+LN;

end;
Procedure I_TPLO_PUT_01(iPlo:TPLo;var iStr:Ansistring);
begin
iStr:=iStr+'P('+iPlo.NAM+')';// Сохраняю имя

iStr:=iStr+'M('+boolToStr(iPlo.Mar)+')';// являеться ли примитив маршрутным
iStr:=iStr+'Q('+IntToStr(iPlo.MCL)+')';// Способ отрисовки цветов плоскости


iStr:=iStr+'C('+intToStr(RColRGBAtoInt(iPlo.COL))+')';// Цвет

iStr:=iStr+'a('+iPlo.VERS[1].NAm+')';// Вершина 1
iStr:=iStr+'b('+iPlo.VERS[2].NAm+')';// Вершина 2
iStr:=iStr+'c('+iPlo.VERS[3].NAm+')';// Вершина 3
iStr:=iStr+'d('+iPlo.VERS[4].NAm+')';// Вершина 4

iStr:=iStr+'h('+intToStr(RColRGBAtoInt(iPlo.COLS[1]))+')';// Цвет покос Вер 1
iStr:=iStr+'i('+intToStr(RColRGBAtoInt(iPlo.COLS[2]))+')';// Цвет покос Вер 2
iStr:=iStr+'j('+intToStr(RColRGBAtoInt(iPlo.COLS[3]))+')';// Цвет покос Вер 3
iStr:=iStr+'l('+intToStr(RColRGBAtoInt(iPlo.COLS[4]))+')';// Цвет покос Вер 4

iStr:=iStr+LN;

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

iStr:=iStr+'C('+intToStr(RColRGBAtoInt(iEle.COL))+')';// Цвет

iStr:=iStr+LN;

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

iStr:=iStr+'C('+intToStr(RColRGBAtoInt(iObj.COL))+')';// Цвет

iStr:=iStr+LN;

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
iStr:=iStr+LN;
iStr:=iStr+LN;
end;
Procedure I_OBJS_PUT_01(var iStr:Ansistring);
var f:Longint;
begin
for f:=1 to MirObjs.KOLO do
if NOT MirObjs.OBJS[f].DEL Then I_TOBJ_PUT_01(MirObjs.OBJS[f],iStr);
iStr:=iStr+LN;
iStr:=iStr+LN;
end;


Procedure I_TANI_PUT_01(iAni:TAni;var iStr:Ansistring);// Записать анимцию
var f:Longint;
begin
iStr:=iStr+'K('+iAni.NAM+')';// Сохраняю имя скрипта
iStr:=iStr+ '"'+iAni.txt+'"';// Сохраняю текст Анимации
iStr:=iStr+LN;
iStr:=iStr+LN;
end;
Procedure I_TSCR_PUT_01(iScr:TScr;var iStr:Ansistring);// Записать Скрипт
begin
iStr:=iStr+'S('+iScr.NAM+')';// Сохраняю имя скрипта
iStr:=iStr+ '"'+iScr.txt+'"';// Сохраняю текст скрипта
iStr:=iStr+LN;
iStr:=iStr+LN;
end;

Procedure I_ANIS_PUT_01(var iStr:Ansistring);// Сохраняет анимации
var f:Longint;
begin
for f:=1 to MirAnis.KOLA do
if NOT MirAnis.ANIS[f].DEL Then I_TANI_PUT_01(MirAnis.ANIS[f],iStr);
iStr:=iStr+LN;
iStr:=iStr+LN;
end;
Procedure I_SCRS_PUT_01(var iStr:Ansistring);// Сохраняет скрипты
var f:Longint;
begin
for f:=1 to MirSCRs.KOLS do
if NOT MirScrs.SCRS[f].DEL Then I_TSCR_PUT_01(MirScrs.SCRS[f],iStr);
iStr:=iStr+LN;
iStr:=iStr+LN;
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
I_RAV_Ele:=Rez;
end;
function  I_RAV_ELES(iEle1,iEle2:TEle):Boolean;
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
I_RAV_ElES:=Rez;
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

if not RavCol(iVer.COL,lVer.COL) then
iStr:=iStr+'C('+intToStr(RColRGBAtoInt(iVer.COL))+')';

iStr:=iStr+LN;
end;

end;
Procedure I_TELE_ANI_01(iObj:Tobj;iEle:TEle;var iStr:Ansistring);
var f:Longint;
lver:Tver;
lEle:Tele;
begin
lEle:=I_FIN_ELE(iObj,iEle.NAM);
if not I_RAV_ELES(lEle,iEle) then begin

if not I_RAV_ELE(lEle,iEle) then begin
iStr:=iStr+'E('+iEle.NAM+')';// Сохраняю имя

if lEle.LOC.X<>iEle.LOC.X then iStr:=iStr+'X('+InString(iEle.LOC.X)+')';// Координаты вершины X
if lEle.LOC.Y<>iEle.LOC.Y then iStr:=iStr+'Y('+InString(iEle.LOC.Y)+')';// Координаты вершины Y
if lEle.LOC.Z<>iEle.LOC.Z then iStr:=iStr+'Z('+InString(iEle.LOC.Z)+')';// Координаты вершины Z

if lEle.EUGL.X<>iEle.EUGL.X then iStr:=iStr+'x('+InString(iEle.EUGL.X)+')';// Углы наклона X
if lEle.EUGL.Y<>iEle.EUGL.Y then iStr:=iStr+'y('+InString(iEle.EUGL.Y)+')';// Углы наклона Y
if lEle.EUGL.Z<>iEle.EUGL.Z then iStr:=iStr+'z('+InString(iEle.EUGL.Z)+')';// Углы наклона Z

if not RavCol(iEle.COL,lEle.COL) then iStr:=iStr+'C('+intToStr(RColRGBAtoInt(iEle.COL))+')';

iStr:=iStr+LN;
end;

for f:=1 to iEle.KOlV do
if NOT iEle.Vers[f].DEL THEN I_TVER_ANI_01(iObj,iEle.Vers[f],iStr);

for f:=1 to iEle.KOlE do
if NOT iEle.Eles[f].DEL THEN I_TELE_ANI_01(iObj,iEle.Eles[f],iStr);


end;
end;
Procedure I_TOBJ_ANI_01(iObj1,iObj2:TObj;var iStr:Ansistring);
var f:Longint;
begin
for f:=1 to iObj2.KOlE do
if NOT iObj2.Eles[f].DEL Then begin
iStr:=iStr+'O(self)'+LN;// Сохраняю Текущий контекст
I_TELE_ANI_01(iObj2,iObj1.Eles[f],iStr);
end;
end;

{%EndRegion}
var   {----------------------- Сохранение и загрузка  ===}{%Region /FOLD }
                                                           I_Reg11:Longint;


procedure MARHS;forward;
procedure OBINS;forward;
function  I_SCENA_DOU_01(var iStr:Ansistring):Pointer;// дублирует обьекты
var
lPos:Longint;
lNam:Ansistring;
lTxt:Ansistring;
lPri:TVER;
lVer:TVer;
fVer:TVer;
fAni:TAni;
fScr:TScr;
lLin:TLin;
fLin:TLin;
lPlo:TPlo;
fPlo:TPlo;
lEle:TEle;
fEle:TEle;
lObj:Tobj;
fObj:Tobj;
LAni:TAni;
LScr:TScr;
begin
TREM:='';
lPos:=1;lObj:=Nil;lEle:=Nil;lPlo:=Nil;lLin:=Nil;lVer:=Nil;
While lPos<Length(iStr) do begin    I_Del_Spac(lPos,iStr);// ПРопускаю спец сим

     if iStr[lPos]='O' Then begin INC(lPos);
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
else if iStr[lPos]='K' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя анимации
     lTxt:=I_GetKa(lPos,iStr);// Запоминаю Текст анимации
     fAni:=I_FIN_Ani(lNam);// Ищу Анимацию
     if fAni=nil then begin // Если такого анимация не существует
                 lAni:=TAni(I_AddPAn); // Создаю его
                 lAni.Nam:=lNam;// Назанчаю имя
                 lAni.Txt:=lTxt;// Назанчаю Текст
                 end
                 else begin
                 lAni:=TAni(I_AddPAn); // Создаю его
                 lAni.Nam:=I_NewNamIdd(lNam);// Назанчаю Новое имя
                 lAni.Txt:=lTxt;// Назначаю  текст
                 end;
     lAni:=TAni(lAni);// Указываю текущим
     end
else if iStr[lPos]='S' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя скрипта
     lTxt:=I_GetKa(lPos,iStr);// Запоминаю Текст скрипта
     fScr:=I_FIN_Scr(lNam);// Ищу Анимацию
     if fScr=nil then begin // Если такого анимация не существует
                 lScr:=TScr(I_AddPSc); // Создаю его
                 lScr.Nam:=lNam;// Назанчаю имя
                 lScr.Txt:=lTxt;// Назанчаю имя
                 end
                 else begin
                 lScr:=TScr(I_AddPSc); // Создаю его
                 lScr.Nam:=I_NewNamIdd(lNam);// Назанчаю новое имя
                 lScr.Txt:=lTxt;// Назанчаю имя
                 end;
     lScr:=TScr(lScr);// Указываю текущим
     end
else if iStr[lPos]='L' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя
     fLin:=I_FIN_Lin(lObj,lNam);// Ищю Линию с таким же именем
     if fLin=nil then begin
                 lLin:=TLin(I_AddPLi(lObj));// Если нету создает Линию
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
else if iStr[lPos]='M' Then begin INC(lPos);
     LPri.Mar:=StrToBool(I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='Q' Then begin INC(lPos);
     LPri.MCL:=inInt(I_GetSC(lPos,iStr));
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
else if iStr[lPos]='C' Then begin INC(lPos);
     LPri.COL:=IntToCol(InInt(I_GetSC(lPos,iStr)))
     end
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
else if iStr[lPos]='h' Then begin INC(lPos);
     lPLo.COLS[1]:=IntToCol(InInt(I_GetSC(lPos,iStr)))
     end
else if iStr[lPos]='i' Then begin INC(lPos);
     lPLo.COLS[2]:=IntToCol(InInt(I_GetSC(lPos,iStr)))
     end
else if iStr[lPos]='k' Then begin INC(lPos);
     lPLo.COLS[3]:=IntToCol(InInt(I_GetSC(lPos,iStr)))
     end
else if iStr[lPos]='l' Then begin INC(lPos);
     lPLo.COLS[4]:=IntToCol(InInt(I_GetSC(lPos,iStr)))
     end
else if iStr[lPos]='(' Then I_GetSC(lPos,iStr)
else if iStr[lPos]='"' Then TREM:=TREM+I_GetKa(lPos,iStr) else inc(lPos);
end;
I_SCENA_DOU_01:=lObj;
// A, B, C, D, E, F, Z, H, I, K, L, M, N, O, P, Q, R, S, T, V и X.
form15.PRI(TREM);
end;
Procedure I_SCENA_KAD_01(var iStr:Ansistring);// Устанавливает кадр
var
R_O,R_P:Boolean;
lPos:Longint;
lNam:Ansistring;
lTxt:Ansistring;
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
While lPos<Length(iStr) do begin  I_Del_Spac(lPos,iStr);// ПРопускаю спец сим

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
else if iStr[lPos]='K' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя анимации
     lTxt:=I_GetKa(lPos,iStr);// Запоминаю Текст Анимации
     end
else if iStr[lPos]='S' Then begin INC(lPos);
     lNam:=I_GetSC(lPos,iStr);// Запоминаю имя скрипта
     lTxt:=I_GetKa(lPos,iStr);// Запоминаю Текст скрипта
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
else if iStr[lPos]='M' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.Mar:=StrToBool(lZna);
     end
else if iStr[lPos]='Q' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPlo.MCL:=inInt(lZna);
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
else if iStr[lPos]='C' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then LPri.COL:=IntToCol(inInt(lZna))
     end
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
else if iStr[lPos]='h' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lPlo.COLS[1]:=IntToCol(inInt(lZna))
     end
else if iStr[lPos]='i' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lPlo.COLS[2]:=IntToCol(inInt(lZna))
     end
else if iStr[lPos]='k' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lPlo.COLS[3]:=IntToCol(inInt(lZna))
     end
else if iStr[lPos]='l' Then begin INC(lPos);
     lZna:=I_GetSC(lPos,iStr);
     if R_O and R_P Then lPlo.COLS[4]:=IntToCol(inInt(lZna))
     end
else if iStr[lPos]='(' Then I_GetSC(lPos,iStr)
else if iStr[lPos]='"' Then I_GetKa(lPos,iStr) else inc(lPos);
end
// A, B, C, D, E, F, Z, H, I, K, L, M, N, O, P, Q, R, S, T, V и X.
end;
procedure I_SET_ANIMATION(iAni:TCheckListBox);// Устанавливает анимацию
var
fa,fo:Longint;
lSelObjs:TSels;
lAni:TAni;
sAni:AnsiString;
begin
lSelObjs:=MirSels.SELObjS;
for fa:=1 to iAni.Items.count-1 do
if iAni.Selected[fa]     then
for fo:=1 to lSelObjs.KOl do begin
lAni:=TAni(iAni.Items.Objects[fa]);
sAni:='O('+lSelObjs.Sels[fo].NAM+')'+lAni.TXT;
I_SCENA_KAD_01(sAni);
end;
lSelObjs.free;
end;
procedure I_SaveScena(iNamFile:Ansistring);// Сохранение сцены
var lStr:Ansistring;
begin
lStr:='"'+TREM+'"'+LN+LN;
I_OBJS_PUT_01(lStr);// Сохраняет все обьекты в сцене в виде строки
I_ANIS_PUT_01(lStr);// Сохраняет все анимации в сцене в виде строки
I_SCRS_PUT_01(lStr);// Сохраняет все скрипты в сцене в виде строки
StrToFile(iNamFile,lStr);// Сохраняет Строку в Файл
G_Change:=false;// Указывает что все изменения сохранены
end;
procedure I_LoadScena(iNamFile:Ansistring);// Загрузка сцены
var
lStr:AnsiString;
f:longint;
begin
FileToStr(iNamFile,lStr);// Читает файл в строку
I_ClearScena;// Очищаем сцену
I_SCENA_DOU_01(lStr);// Преобразет строку в Обьекты
G_Change:=false;// Указываем что изменений нету
for f:=1 to MirObjs.KolO do
if not MirObjs.OBJS[f].DEL then begin
MirObjs.OBJS[f].O_MATH;
MirObjs.OBJS[f].O_INIC;
end;
MARHS;// Раставляем маршрутные точки
OBINS;// Определяем какой обьект в каком
end;

{%EndRegion}
var   {----------------------- Бардак                 ===}{%Region /FOLD }
                                                           J_Reg11:Longint;

procedure I_DoubleObject(iTObj:Pointer;LiS:TCheckListBox);// Создает копию обьек
var
lStr:Ansistring;
begin
I_TOBJ_PUT_01(TObj(iTObj),lStr);// превращаем обьект в строку
I_SCENA_DOU_01(lStr);// Превращаем строку в обьект
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
if MirSels.Kol<>0 then form4.Act:=MirSels.Sels[1] else form4.Act:=Nil;
I_RefreshActivePrimitiv;
// -----------------------------------------------------------------------------
end;
procedure I_ClearScena;// Очищает Сцену
var f:Longint;
begin
 G_Change:=true;
 for f:=1 to MirObjs.KolO do I_DelObj(MirObjs.OBJS[f]);
 for f:=1 to MirAnis.KolA do I_DelAni(MirAnis.ANIS[f]);
 for f:=1 to MirScrs.KolS do I_DelScr(MirScrs.ScrS[f]);
 G_FileName:='';
 form15.Memo1.Clear;
 GIDD:=0;
end;
procedure I_CLOSE;
begin
Clos:=true;
sleep(777);
end;

{%EndRegion}

{%EndRegion}
var   {Таймеры                ===========================}{%Region /FOLD }
                                                           Reg14:Longint;


function  VhoditCooPlo3d(iCoo:RCS3;iPLo:TPlo):Boolean;
var Rez:Boolean;
begin
Rez:=False;
if Vhodit3D(iCoo,iPlo.GMin,iPLo.GMAx) then rez:=true;
VhoditCooPlo3d:=REz;
end;
function  VhoditCooPlo2d(iCoo:RCS3;iPLo:TPlo):Boolean;
var Rez:Boolean;
begin
Rez:=False;
if Vhodit2D(iCoo,iPlo.GMin,iPLo.GMAx) then rez:=true;
VhoditCooPlo2d:=REz;
end;
function  FinPlos(iCoo:Rcs3):TPlo;// Ищит плоскость в котрой принадлеж КОО
var REz:Tplo;f:Longint;
begin
 REz:=Nil;
 for f:=1 to MirPLos.KolP do // Перебираем плоскости
 if not MirPLos.PLOS[f].DEl then // Если плоскость не удалена
 if Vhodit3D(iCoo,MirPLos.PLOS[f].GMin,MirPLos.PLOS[f].GMAx) then
    rez:=MirPLos.PLOS[f];
 FinPlos:=rez;
end;
function  FinPlos(iObj:Tobj;iCoo:Rcs3):TPlo;// Ищит плоскость в котрой принадлеж КОО
var REz:Tplo;f:Longint;
begin
 REz:=Nil;
 for f:=1 to iObj.KolP do // Перебираем плоскости
 if not iObj.PLOS[f].DEl then // Если плоскость не удалена
 if Vhodit3D(iCoo,iObj.PLOS[f].GMin,iObj.PLOS[f].GMAx) then rez:=iObj.PLOS[f];
 FinPlos:=rez;
end;

var   {Маршрутизация          ===========================}{%Region /FOLD }
                                                           Reg1M:Longint;

Type TR=record // Опсиание ребра
  Ver1:Longint;// номер вершины 1
  Ver2:Longint;// номер вершины 2
  ras:Single  ;// Растояние между вершинами
end;
Type TV=record // Опсиание вершины
  Ver:TVER   ; // Вершина
  ras:Single ; // Растояние
  Fla:Boolean; // Флаг
end;
Function  DEKS(iObj:Tobj;iVer1,iVer2:Tver):Single;// Алгоритм Дэйкстры
Var // Находим минимальное растояние между 2 маршрутными вершинами в обьекте
R:Array[1..MaxKolVerInEle] of TR   ;// Рёбра
V:Array[1..MaxKolVerInEle] of TV   ;// Вершины
MinRas:Single;
N,KR,KV,f:Longint;
Ex:Boolean;
function NV(iVer:Tver):Longint;
var f,Rez:longint;
begin
Rez:=0;
for f:=1 to KV do
if iVer=V[f].VER then rez:=f;
NV:=rez;
end;
begin


KV:=0;// Заполняю масив с вершинами
for f:=1 to iObj.KolV do
if not iObj.VERS[f].DEL then
if     iObj.VERS[f].MAR then begin
KV:=KV+1;
V[KV].VER:=iObj.VERS[f];
V[KV].Fla:=False;
V[KV].Ras:=1000000;
end;

KR:=0;// Заполня масив с ребрами
for f:=1 to iObj.KolL do
if not iObj.LINS[f].DEL then
if iObj.LINS[f].MAR then begin
KR:=KR+1;
R[KR].VER1:=NV(iObj.LINS[f].VERS[1]);
R[KR].VER2:=NV(iObj.LINS[f].VERS[2]);
R[KR].RAS:=iObj.LINS[f].RASL;
if R[KR].VER1=0 then ShowMessage('ERR');
if R[KR].VER2=0 then ShowMessage('ERR');
if R[KR].RAS=0  then ShowMessage('ERR');

end;


// Вычисление растояний до каждой вершины алгоритм Дейкстры


V[NV(iVer1)].RAS:=0;

ex:=true;
for f:=1 to KV do
if V[f].Fla=false Then ex:=false;


while Ex=false do begin

// Ищим вершину с минимальным растоянием ----------------------------

MinRas:=1000000;
for f:=1 to KV do
if not V[f].FLA    Then
if V[f].RAS<MinRas Then
                   begin
                   MinRas:=V[f].Ras;// Минимальнео растояние
                   N:=f;// Номер в масиве где минималное растояние
                   end;

V[N].FLA:=true;// Устанавливаем флаг в 1
V[N].RAS:=MinRas;// MinRas сумма растояний до текузей вершины

//-------------------------------------------------------------------

for f:=1 to KR do
begin

if (R[f].VER1=N)  then begin
if  V[R[f].VER2].RAS>R[f].RAS+V[N].RAS then V[R[f].VER2].RAS:=MinRas+R[f].RAS;end;

if (R[f].VER2=N)  then begin
if  V[R[f].VER1].RAS>R[f].RAS+V[N].RAS then V[R[f].VER1].RAS:=MinRas+R[f].RAS;end;

end;

ex:=true;
for f:=1 to KV do
if V[f].Fla=false Then ex:=false;

end;//==============================================================



DEKS:=V[NV(iVer2)].Ras;
end;
function  FindMar(iObj:TObj;iCoo:RCS3):TVer;// Ищим маршрутную точку ближ к
var
f:Longint;
LRAS:RSIN;
MRAS:RSIN;
Rez:TVer;
begin
 Rez:=Nil;MRAS:=1000000;
 if iObj<>Nil then
 for f:=1 to iObj.KolV do
 if not iObj.VERS[f].DEL then
 if     iObj.VERS[f].MAR then begin
 LRAS:=RasRCS3(iCoo,iObj.VERS[f].REA);
 if  LRAS<MRAS then begin
     MRAS:=LRAS       ;
     REz:=iObj.VERS[f];
 end;
 end;
 FindMar:=REz;
end;
function  FindMar(iObj:TObj;iCoo:RCS3;iPlo:Tplo):TVer;// Ищим маршрутную точку ближ к
var
f:Longint;
LRAS:RSIN;
MRAS:RSIN;
Rez:TVer;
begin
 Rez:=Nil;MRAS:=1000000;
 if (iObj<>nil)and(iPLo<>Nil)Then
 for f:=1 to iObj.KolV do if (not iObj.VERS[f].DEL)and(iObj.VERS[f].MAR)then
 begin
    LRAS:=RasRCS3(iCoo,iObj.VERS[f].REA);
    if(iObj.VERS[f].Gpl=iPLo)and(LRAS<MRAS)
    then begin MRAS:=LRAS;REz:=iObj.VERS[f];end;
 end;
 if rez=nil then rez:=FindMar(iObj,iCoo);
 FindMar:=REz;
end;
procedure GoGo;// Маршрутизация персонажа
var
f,f2:longint;// Для циклов
lDom:TObj;// ОБьект в котром находиться персонаж
lPer:TObj;// Персонаж
lPMr:Tver;//
lCPl:TPlo;// Плоскость на которой находиться цель
lCMr:Tver;// Маршрутная точка рядом с целью
MPER:Tver;// Маршрутные точки куда нужно двигаться
LRAS:RSIN;// Растояние лоакльное для цикла
MRAS:RSIN;// МИниамльное растояние найденое
Ex:Boolean;
begin
for f:=1 to MirObjs.KolO do
if not MirObjs.OBJS[f].DEL then // если обьект неудален
if MirObjs.OBJS[f].GOB<>NIL THEN
if    MirObjs.OBJS[f].OPER then // если обьект персонаж   // Если мы не на месте
if RAsRCS3(MirObjs.OBJS[f].LOC,MirObjs.OBJS[f].OCEL)>3 then begin
   //---------------------------------------------------------------------------
   Ex:=false;
   //---------------------------------------------------------------------------
   lPer:=MirObjs.OBJS[f]  ;// Персонаж с котроым рабоатем
   lDom:=Tobj(Per.GOB)    ;// Обьект в котором находиться персонаж
   lPMr:=FindMar(lDom,PER.REA,TPlo(PER.Gpl)); // Ищи мар точку рядом с песронажем
   //---------------------------------------------------------------------------
   lCPl:=FinPlos(Per.OCEL);// Ищим плоскотсь в которой находиться цель
   lCMr:=FindMar(lDom,PER.OCEL,lCPl); // Ищи мар точку рядом с целью
   //---------------------------------------------------------------------------
   // Если на одной плоскости с персонажем нету маршрутных точек
   if lPMr=nil Then begin PEr.OMOV:=Per.OCEL;ex:=true;end;
   //---------------------------------------------------------------------------
   // Если персонаж и цель на одной плоскости
   if (not ex) and (lCPl=lPer.Gpl) Then begin PEr.OMOV:=Per.OCEL;ex:=true;end;
   //---------------------------------------------------------------------------
   // Если маршрутные точки ближнии к цели и персонажу совпдают
   if (not ex) and (lPMr=lCMr) Then begin PEr.OMOV:=Per.OCEL;ex:=true;end;
   //---------------------------------------------------------------------------
   if (not ex) then begin
   MPER:=Nil; MRAS:=10000000;
   for F2:=1 to lDom.KolL do
   if(Not lDom.LINS[f2].DEL)and(lDom.LINS[f2].MAR)then begin
   if  lDom.LINS[f2].VERS[1]=lPMr then begin
   LRAS:=DEKS(lDom,lDom.LINS[f2].VERS[2],lCMr); // Рстояние от
   if MRAS>LRAS then begin
      MRAS:=LRAS;// Запорминаем новое растояние
      MPER:=lDom.LINS[f2].VERS[2];// Маршрутная точка через котрую нужно пройти
   end;end;
   if  lDom.LINS[f2].VERS[2]=lPMr then begin
   LRAS:=DEKS(lDom,lDom.LINS[f2].VERS[1],lCMr); // Рстояние от
   if MRAS>LRAS then begin
      MRAS:=LRAS;// Запорминаем новое растояние
      MPER:=lDom.LINS[f2].VERS[1];// Маршрутная точка через котрую нужно пройти
   end;end;
   end;
   //---------------------------------------------------------------------------
   // MPER - Маршрутная точка к котрой нужно перемещаться
   if MPER<>NIL Then begin PEr.OMOV:=MPER.REA;PEr.MTP:=MPER; end;
   //---------------------------------------------------------------------------
   end;
   //---------------------------------------------------------------------------
   end;
end;

{%EndRegion}

procedure MAROBJ(iObj:TObj);// Правельно определяет маршрутные вершины
var fl,fv:Longint;
begin
with iObj do begin
//------------------------------------------------------------------------------
// Определяем на какой плоскости лежат маршрутные точки
for fV:=1 to KOlV do
if not VERS[fv].DEL Then
if     VERS[fv].MAR Then
begin
iObj.MAR:=true;
VERS[fv].GPL:=FinPlos(iObj,VERS[fv].REA);
if VERS[fv].GPL<>nil then TPlo(VERS[fv].GPL).MAR:=True;
end;
//------------------------------------------------------------------------------
// Определяем какие линии являтюсять марштурными
for fl:=1 to KOlL do
if not LINS[fl].DEL Then
if (not LINS[fl].VERS[1].DEL) and
   (not LINS[fl].VERS[2].DEL) and
   (    LINS[fl].VERS[1].MAR) and
   (    LINS[fl].VERS[2].MAR) Then LINS[fl].MAR:=true
                              else LINS[fl].Mar:=False;
//------------------------------------------------------------------------------
// ВНИАМНИЕ СНИМАТЬ МАРКЕР МАРШУТНАЯ ПЛОСКОСТЬ НУЖНО В ДРУГОМ МЕСТЕ

end;
end;
procedure OBIOBJ(iObj:TObj);// Опредеяет в каком обьекте находиться обьект
var fg:Longint;RezPl:Tplo;
begin
RezPl:=Nil;
//---------------------------------------------------------
// Опредеяем находиться ли обьект в том же обьекте где и был
if iObj.Gob<>nil then
if (not Vhodit3D(iObj.REA,iObj.Gob.GMin,iObj.Gob.GMax)) or
   (NOT TObj(iObj.GOb).MAR) THEN // Если этот обьект немаршрутный
begin TObj(iObj.GOb).DelDels(iObj);iObj.Gob:=Nil;end;
//---------------------------------------------------------
// Ищим в каком обьекте находиться даннй обьект
for fg:=1 to MirObjs.KOlO do
if  NOT MirObjs.OBJS[Fg].DEL   THEN
if      MirObjs.OBJS[Fg].MAR   THEN
if      MirObjs.OBJS[Fg]<>iObj THEN with MirObjs.OBJS[fg] do
if iObj.OB3<Ob3   then
if Vhodit3D(iObj.REA,GMin,GMax) then
if(iObj.GOb=nil) or (iObj.GOb.OB3>Ob3) then
  begin
  if iObj.GOb<>Nil Then TObj(iObj.GOb).DelDels(iObj);
  AddDels(iObj);
  iObj.Gob:=MirObjs.OBJS[Fg];
  end;
//---------------------------------------------------------
// Определяем плоскость на котрой находиться обьект
if iObj.GOb<>Nil then with TObj(iObj.GOb) do begin

  for fg:=1 to KOlP do // ПРоверяем сперва 3D
  if not PLOS[fg].DEL then
  if     PLOS[fg].MAR then
  if  VhoditCooPlo3d(iObj.REA,PLOS[fg]) then
  if  (REzPl=NIL) then REzPl:=PLOS[fg] else
  if  (iObj.MTP<>NIL) THEN
  if  (iObj.MTP.GPL<>NIL) THEN
  if  (iObj.MTP.GPL=PLOS[fg]) then REzPl:=PLOS[fg];

  if RezPl=Nil Then
  for fg:=1 to KOlP do // ПРоверяем 2D если 3D нету
  if not PLOS[fg].DEL then
  if     PLOS[fg].MAR then
  if  VhoditCooPlo2d(iObj.REA,PLOS[fg]) then REzPl:=PLOS[fg];

  iObj.Gpl:=RezPl;

end;
//---------------------------------------------------------
if RezPl<>Nil Then iObj.YYY:=RezPl.P_Viso(iObj.REA);


end;
procedure MARHS;// Определяет маршрутные плоскости линии и обьекты
var Fo:Longint;
begin
for fo:=1 to MirObjs.KOlO do
if not MirObjs.OBJS[Fo].DEL Then MAROBJ(MirObjs.OBJS[Fo]);
end;
procedure OBINS;// Определяет какой обьект находитсья в каком
var
fo:Longint;
begin
// Какой обьект находиться в каком
for fo:=1 to MirObjs.KOlO do
if not MirObjs.OBJS[fo].DEL then
if NOT MirObjs.OBJS[fo].MAR then OBIOBJ(MirObjs.OBJS[fo]);
end;
procedure MPERS;// Перемещение персонажей
var f:Longint;lPer:Tobj;
begin

if form4.CheckBox3.Checked then begin
   //---------------------------------------------------------------------------
   // Определяем кто персонаж в игре
   for f:=1 to MirObjs.KolO do
   if length(MirObjs.OBJS[f].NAM)>1 then
   if MirObjs.OBJS[f].NAM[1]='_' then begin
   lPer:=MirObjs.OBJS[f];
   lPer.OPER:=TRUE;
   if lPer.NAM='_USER' then  PER:=lPer;
   if RasRcs2(lPer.OMOV,lPer.loc)>1 Then begin



   if RasRcs2(lPer.OCEL,lPer.loc)>3 Then
   lPer.ELES[1].EUGL.y:=
   GRAD((lPer.OMOV.x-lPer.loc.x),(lPer.OMOV.z-lPer.loc.z))+(pi/2);

   lPer.loc:=MovRCS3(lPer.loc,lPer.OMOV,5);
   OBIOBJ(lPer);
   LPER.LOC.Y:=LPER.YYY;
   lPer.CHE:=100;
   end;

   end;
   //---------------------------------------------------------------------------
   // Маршрутизируем персонажей в игре
   GOGO;
end;
end;
procedure BLOK(iVer:Pointer);
begin
tObj(Tver(iVer).Obj).O_MATH ;// Перевычисляем обьект
tObj(Tver(iVer).Obj).CHE:=100;
MAROBJ(TObj(Tver(iVer).Obj));// Перевычисляем маршрутные точки
OBIOBJ(TObj(Tver(iVer).Obj));// Определяет какой обьект находитсья в каком
end;


procedure I_EDI_IDD;// ОТрисо IDшник редктируемых   примитивов
var
f:LongWord;
RC,SC:LongWord;
lPri:TVer;
begin
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
//------------------------------------------------------------------------------
SC:=0                ; begin // Рисую   Вершины
if form4.MenuItem14.Checked then
for f:=1 to MirVers.KolV do
if not  MirVers.VERS[f].DEL then
if      MirVers.VERS[f].VIS then
if not  MirVers.VERS[f].MAR then
I_DrVer(MirVers.VERS[f],IntToCol(f+SC)); end;
//------------------------------------------------------------------------------
SC:=SC+MaxKOlVerInMir; begin // Рисую   Вершины
if form4.MenuItem16.Checked then
for f:=1 to MirVers.KolV do
if not MirVers.VERS[f].DEL then
if     MirVers.VERS[f].VIS then
if     MirVers.VERS[f].MAR then
I_DrVer(MirVers.VERS[f],IntToCol(f+SC));
end;
//------------------------------------------------------------------------------
SC:=SC+MaxKOlVerInMir; begin // Рисую     Линии
if form4.MenuItem22.Checked then
for f:=1 to MirLins.KolL do
if not MirLins.LINS[f].DEL then
if     MirLins.LINS[f].VIS then
if Not MirLins.LINS[f].MAR then
I_DrLin(MirLins.LINS[f],IntToCol(f+SC)); end;
//------------------------------------------------------------------------------
SC:=SC+MaxKOlLinInMir; begin // Рисую МАР Линии
if form4.MenuItem31.Checked then
for f:=1 to MirLins.KolL do  // Маршрутные линии
if not  MirLins.LINS[f].DEL then
if      MirLins.LINS[f].VIS then
if      MirLins.LINS[f].MAR then
I_DrLin(MirLins.LINS[f],IntToCol(f+SC)); end;
//------------------------------------------------------------------------------
SC:=SC+MaxKOlLinInMir; begin // Рисую Плоскости
if form4.MenuItem13.Checked then
for f:=1 to MirPlos.KolP do
if not MirPlos.PLOS[f].DEL then
if     MirPlos.PLOS[f].VIS then
if     MirPlos.PLOS[f].VVI then
I_DrPlo(MirPLos.PLOS[f],IntToCol(f+SC)); end;
//------------------------------------------------------------------------------
SC:=SC+MaxKOlPloInMir; begin // Рисую  элементы
if form4.MenuItem12.Checked then
for f:=1 to MirEles.KolE do
if not MirEles.ELES[f].DEL then
if     MirEles.ELES[f].VIS then
I_DrEle(MirEles.ELES[f],IntToCol(f+SC)); end;
//------------------------------------------------------------------------------
SC:=SC+MaxKOlEleInMir; begin // Рисую   обьекты
if form4.MenuItem10.Checked then
for f:=1 to MirObjs.KolO do
if not MirObjs.OBJS[f].DEL then
if     MirObjs.OBJS[f].VIS then
I_DrObj(MirObjs.OBJS[f],IntToCol(f+SC)); end;
//------------------------------------------------------------------------------
SC:=SC-MaxKOlVerInMir-MaxKOlVerInMir-MaxKOlLinInMir-MaxKOlLinInMir-
       MaxKOlPloInMir-MaxKOlEleInMir;
RC:=0;lPri:=Nil;
glReadPixels(MouD.X,form3.ClientHeight-MouD.Z,1,1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if RC=0 then // Если ничего не выбрано
while MirSels.Kol<>0 do I_SetSel(MirSels.sels[MirSels.Kol],false);
//------------------------------------------------------------------------------
if (RC>=1) and (RC<=MirVers.KolV) then // Если выбрана Вершина
lPri:=MirVers.Vers[RC];
RC:=RC-MaxKOlVerInMir;
//------------------------------------------------------------------------------
if (RC>=1) and (RC<=MirVers.KolV) then // Если выбрана Маршрутная Вершина
lPri:=MirVers.Vers[RC];RC:=RC-MaxKOlVerInMir;
//------------------------------------------------------------------------------
if (RC>=1) and (RC<=MirLins.KolL) then // Если выбрана Лииния
lPri:=MirLins.Lins[RC];RC:=RC-MaxKOlLinInMir;
//------------------------------------------------------------------------------
if (RC>=1) and (RC<=MirLins.KolL) then // Если выбрана Маршрутная Лииния
lPri:=MirLins.Lins[RC];RC:=RC-MaxKOlLinInMir;
//------------------------------------------------------------------------------
if (RC>=1) and (RC<=MirPlos.KolP) then // Если выбрана плоскость
begin {lPri:=MirPlos.Plos[RC];} end;RC:=RC-MaxKOlPLoInMir;
//------------------------------------------------------------------------------
if (RC>=1) and (RC<=MirEles.KolE) then // Если выбран Элемент
lPri:=MirEles.Eles[RC];RC:=RC-MaxKOlEleInMir;
//------------------------------------------------------------------------------
if (RC>=1) and (RC<=MirObjs.KolO) then // Если выбран обьект
lPri:=MirObjs.Objs[RC];RC:=RC-MaxKOlObjInMir;
//------------------------------------------------------------------------------

if (lPri<>Nil) and LBUT and SBUT then begin // Если разреше выделять
lPri.Sel:=not lPri.Sel ;// Инвертируем выделение
I_SetSel(lPri,lPri.Sel);// Фикируем
LBUT:=false;
end;
if (lPri<>Nil) and DBUT then begin  // Перемещение
CaP3:=lPri.Rea;DBUT:=false;LBUT:=false;
end;
end;
procedure I_EDI_COL;// Отрисв цветам редактируемых  примитивов
var f:Longint;
Begin // Отрисовка редактора
// Отрисовываю все ОБьекты в игровом мире
if form4.MenuItem10.Checked then // ОБьекты
for f:=1 to MirObjs.KolO do
if not MirObjs.OBJS[f].DEL then
if     MirObjs.OBJS[f].VIS then
if Not MirObjs.OBJS[f].SEL
then  I_DrObj(MirObjs.OBJS[f],MirObjs.OBJS[f].Col)
else  I_DrObj(MirObjs.OBJS[f],CreRCol(255,0,0,255));//RanRCol

// Отрисовываю все элементы  в игровом мире
if form4.MenuItem12.Checked then // Элемент
for f:=1 to MirEles.KolE do
if MirELEs.ELES[f].ELE.VIS then
if MirELEs.ELES[f].OBJ.VIS then
if not MirEles.ELES[f].DEL then
if     MirEles.ELES[f].VIS then
if Not MirEles.ELES[f].SEL
Then I_DrEle(MirEles.ELES[f],MirEles.ELES[f].COL)
else I_DrEle(MirEles.ELES[f],CreRCol(255,0,0,255));

// Отрисовываю все Плоскости в игровом мире
if form4.MenuItem13.Checked then // Плоскос
for f:=1 to MirPlos.KolP do
if MirPlos.PLOS[f].ELE.VIS then
if MirPlos.PLOS[f].OBJ.VIS then
if not MirPlos.PLOS[f].DEL then
if     MirPlos.PLOS[f].VIS then
if     MirPlos.PLOS[f].VVI then
if Not MirPlos.PLOS[f].SEL
then I_DrPlo(MirPlos.PLOS[f],MirPlos.PLOS[f].Col)
else I_DrPlo(MirPlos.PLOS[f],CreRCol(255,0,0,255));


// Отрисовываю все Линии в игровом мире
if form4.MenuItem22.Checked then // Линии
for f:=1 to MirLins.KolL do
if MirLins.LINS[f].ELE.VIS then
if MirLins.LINS[f].OBJ.VIS then
if not MirLins.LINS[f].DEL then
if     MirLins.LINS[f].VIS then
if not MirLins.LINS[f].MAR then
if Not MirLins.LinS[f].SEL
then I_DrLin(MirLins.LinS[f],MirLins.LinS[f].COL)
else I_DrLin(MirLins.LinS[f],CreRCol(255,0,0,255));


// Отрисовываю все маршпутные Линии в игровом мире
if form4.MenuItem31.Checked then // Линии
for f:=1 to MirLins.KolL do
if MirLins.LINS[f].ELE.VIS then
if MirLins.LINS[f].OBJ.VIS then
if not MirLins.LINS[f].DEL then
if     MirLins.LINS[f].VIS then
if     MirLins.LINS[f].MAR then
if Not MirLins.LinS[f].SEL
then I_DrLin(MirLins.LinS[f],MirLins.LinS[f].COL)
else I_DrLin(MirLins.LinS[f],CreRCol(255,0,0,255));


// Отрисовываю все вершины в игровом мире
if form4.MenuItem14.Checked then   // Вершины
for f:=1 to MirVers.KolV do
if MirVers.VERS[f].ELE.VIS then
if MirVers.VERS[f].OBJ.VIS then
if not MirVers.VERS[f].DEL then
if     MirVers.VERS[f].VIS then
if not MirVers.VERS[f].MAR then
if Not MirVers.VERS[f].SEL
then I_DrVer(MirVers.VERS[f],MirVers.VERS[f].COL)
else I_DrVer(MirVers.VERS[f],CreRCol(255,0,0,255));


// Отрисовываю все вершины в игровом мире
if form4.MenuItem16.Checked then   // Вершины
for f:=1 to MirVers.KolV do
if MirVers.VERS[f].ELE.VIS then
if MirVers.VERS[f].OBJ.VIS then
if not MirVers.VERS[f].DEL then
if     MirVers.VERS[f].VIS then
if     MirVers.VERS[f].MAR then
if Not MirVers.VERS[f].SEL
then I_DrVer(MirVers.VERS[f],MirVers.VERS[f].COL)
else I_DrVer(MirVers.VERS[f],CreRCol(255,0,0,255));



end;
//------------------------------------------------------------------------------
procedure I_SCE_IDD;// Отрисовка игровой сцены IDшнгиками

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

if LBUT and SBUT then begin // Если разреше выделять
iPlo.Sel:=not iPlo.Sel ;// Инвертируем выделение
I_SetSel(iPlo,iPlo.Sel);// Фикируем
LBUT:=false;
end;

if DBUT then begin // Перемешение
        CaP3:=OpredelitCoo(
               MouD.X,
               form3.ClientHeight-MouD.Z,
               iver1,
	       iver2,
	       iver3,
	       iver4,
	       7
	       );
        if PER<>NIL then PER.OCEL:=CaP3;
        DBUT:=False;LBUT:=false;
        end;

end;
end;

var f:Longint;RC:Longword;P:TPLO;
begin
if form4.MenuItem13.Checked or form4.MenuItem6.Checked then begin
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
for f:=1 to MirPlos.KolP do
if   not MirPLos.Plos[f].DEL then
if       MirPLos.Plos[f].VVI then
if       MirPLos.Plos[f].VIS then
with MirPLos.Plos[f] do
ploskost(VERS[1].ECR,VERS[2].ECR,VERS[3].ECR,VERS[4].ECR,IntToCol(f));
RC:=0;
glReadPixels(MouD.X,form3.ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirPlos.KolP) then
begin P:=MirPlos.PLos[RC];OpredelitCoo(P);end else P:=Nil;
end;
end;
procedure I_SCE_COL;// Отрисовка игровой сцены Цветами
begin
glClearColor(GFon.R*(1/255),GFon.G*(1/255),GFon.B*(1/255),GFon.A*(1/255)); // Задаем фон
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);// очистка экрана
glVertexPointer(3, GL_FLOAT, 0, @MirVers.ECOO2);
glColorPointer (4, GL_UNSIGNED_BYTE, 0,@MirVers.ECOL2);
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
if form4.MenuItem6.Checked then Begin // отрисовка плоскостей

glDrawElements(GL_TRIANGLES,MirPlos.DrKP*6,GL_UNSIGNED_INT,@MirPlos.EPlo2[1]);

glVertexPointer(3, GL_FLOAT, 0, @MirCols.ECOO2);
glColorPointer (4, GL_UNSIGNED_BYTE, 0,@MirCols.ECOL2);
glDrawElements(GL_TRIANGLES,MirCols.DrKP*6,GL_UNSIGNED_INT,@MirCols.EPlo2[1]);

glVertexPointer(3, GL_FLOAT, 0, @MirVers.ECOO2);
glColorPointer (4, GL_UNSIGNED_BYTE, 0,@MirVers.ECOL2);

end;
if form4.MenuItem8.Checked then begin // отрисовка Линий
glDisableClientState(GL_COLOR_ARRAY);
//GlEnable(GL_POLYGON_OFFSET_LINE);
//glPolygonOffset(1.0, 4.0);
glColor4ub(0,0,0,255);
glDrawElements(GL_LINES    ,MirLins.DrKl*2,GL_UNSIGNED_INT,@MirLins.ELin2[1]);
//glTranslateD(0,0,2);// Отодвигаем камеру на нужное растояние
//glDrawElements(GL_LINES    ,MirLins.DrKl*2,GL_UNSIGNED_INT,@MirLins.ELin2[1]);
//glTranslateD(0,0,-4);// Отодвигаем камеру на нужное растояние
//glDrawElements(GL_LINES    ,MirLins.DrKl*2,GL_UNSIGNED_INT,@MirLins.ELin2[1]);
//glTranslateD(2,0,2);// Отодвигаем камеру на нужное растояние
//glDrawElements(GL_LINES    ,MirLins.DrKl*2,GL_UNSIGNED_INT,@MirLins.ELin2[1]);
//glTranslateD(-4,0,0);// Отодвигаем камеру на нужное растояние
//glDrawElements(GL_LINES    ,MirLins.DrKl*2,GL_UNSIGNED_INT,@MirLins.ELin2[1]);
glEnableClientState(GL_COLOR_ARRAY);
end;
end;
//------------------------------------------------------------------------------
{
function  TheadMath(Par:Pointer):DWORD;stdcall;// Вычисление
var F:Longint;
begin
   SetThreadPriority(GetCurrentThread,THREAD_PRIORITY_LOWEST);
   while Clos=false do begin
     sleep(33);//----------------------------------------------
     for f:=1 to MirObjs.KolO do
     with MirObjs.OBJS[f] do if(not Del)and(CHE>0)THEN
     begin
       CHE:=CHE-1;
       O_MATH;
       O_SWAP;
       sleep(1);
     end;
     MPERS;
   end;
result:=0;
end;
function  TheadSwap(Par:Pointer):DWORD;stdcall;// Вывод сцены в буфер
var
F:Longword;// ДЛя циклов
lDrKp:Longword;// Реальное количество Вершин Плоскостей
lDrKL:Longword;// Реальное количество Вершин Линий
begin
   SetThreadPriority(GetCurrentThread,THREAD_PRIORITY_LOWEST);
   while Clos=false do begin
     sleep(500);
     // ========================================================================
     with MirVers do for f:=1 to KOlV do
     if   NOT Tobj(Vers[f].OBJ).OPER then
     if   Vers[f].ELE.VIS then
     if       Vers[f].VIS then
     if   not Vers[f].DEL then
     with Vers[f] do begin
     ECOO1[f]:=ECR;sleep(1);
     ECOL1[f]:=Col;
     end;
     // ========================================================================
     lDrKp:=0;
     with MirPlos do for f:=1 to KolP do
     if   Plos[f].OBJ.VIS then
     if   Plos[f].ELE.VIS then
     if       Plos[f].VIS then
     if   not Plos[f].DEL then
     if       Plos[f].VVI then
     if   Plos[f].MCL=1   then // Не использовать собственые цвета
     with Plos[f] do begin
     lDrKp:=lDrKp+1;sleep(1);
     EPlo1[lDrKp].VERS[1]:=Vers[1].Nom;
     EPlo1[lDrKp].VERS[2]:=Vers[2].Nom;
     EPlo1[lDrKp].VERS[3]:=Vers[3].Nom;
     EPlo1[lDrKp].VERS[4]:=Vers[3].Nom;
     EPlo1[lDrKp].VERS[5]:=Vers[4].Nom;
     EPlo1[lDrKp].VERS[6]:=Vers[1].Nom;
     end;
     MirPLos.DrKp:=lDrKp;
     // ========================================================================
     lDrKl:=0;
     with MirLins do for f:=1 to KolL do
     if   Lins[f].OBJ.VIS then
     if   Lins[f].ELE.VIS then
     if       Lins[f].VIS then
     if   not Lins[f].DEL then
     if   not Lins[f].MAR then
     with Lins[f] do begin
     lDrKl:=lDrKl+1;sleep(1);
     ELin1[lDrKl].VERS[1]:=Vers[1].Nom;
     ELin1[lDrKl].VERS[2]:=Vers[2].Nom;
     end;
     MirLins.DrKl:=lDrKl;
     // ========================================================================
     with MirVers do Move(ECoo1,ECoo2,(KolV+1)*SizeOf(RCS3));
     with MirVers do Move(ECol1,ECol2,(KolV+1)*SizeOf(RCOL));
     with MirLins do Move(ELin1,ELin2,(DrKl+0)*SizeOf(RLIN));
     with MirPlos do Move(EPlo1,EPlo2,(DrKP+0)*SizeOf(RPLO));
     // ========================================================================
     MirCols.Swap;
   end;
   result:=0;
end;
function  TheadSSwa(Par:Pointer):DWORD;stdcall;// Вывод сцены в буфер
var
FO:Longword;// ДЛя циклов
begin
   SetThreadPriority(GetCurrentThread,THREAD_PRIORITY_LOWEST);
   while Clos=false do begin
     sleep(100);

     // ========================================================================
     //with MirObjs do for fo:=1 to KOlO do begin
     //sleep(1);
     //if OBJS[FO].CHE>0 THEN OBJS[FO].O_SWAP;
     //end;
   end;
   result:=0;
end;
}
var   {Потоки                 ===========================}{%Region /FOLD }
                                                           Reg1T:Longint;

Type TheadMath = class(TThread)
    private
    protected
    procedure Execute; override;
    public
    Constructor Create(CreateSuspended : boolean);
end;
constructor TheadMath.Create(CreateSuspended : boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;
procedure   TheadMath.Execute;
var f:Longint;
begin
  Priority:=tpIdle;
  while (not Terminated) and (Clos=false) do
    begin
      sleep(33);//----------------------------------------------
      for f:=1 to MirObjs.KolO do
      with MirObjs.OBJS[f] do if(not Del)and(CHE>0)THEN
      begin
        CHE:=CHE-1;
        O_MATH;
        O_SWAP;
        sleep(1);
      end;
      MPERS;
    end;
end;

Type TheadSwap = class(TThread)
    private
    protected
    procedure Execute; override;
    public
    Constructor Create(CreateSuspended : boolean);
end;
constructor TheadSwap.Create(CreateSuspended : boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;
procedure   TheadSwap.Execute;
var
F:Longword;// ДЛя циклов
lDrKp:Longword;// Реальное количество Вершин Плоскостей
lDrKL:Longword;// Реальное количество Вершин Линий
begin
  Priority:=tpIdle;
  while (not Terminated) and (Clos=false) do
    begin
    sleep(500);
    // ========================================================================
    with MirVers do for f:=1 to KOlV do
    if   NOT Tobj(Vers[f].OBJ).OPER then
    if   Vers[f].ELE.VIS then
    if       Vers[f].VIS then
    if   not Vers[f].DEL then
    with Vers[f] do begin
    ECOO1[f]:=ECR;sleep(1);
    ECOL1[f]:=Col;
    end;
    // ========================================================================
    lDrKp:=0;
    with MirPlos do for f:=1 to KolP do
    if   Plos[f].OBJ.VIS then
    if   Plos[f].ELE.VIS then
    if       Plos[f].VIS then
    if   not Plos[f].DEL then
    if       Plos[f].VVI then
    if   Plos[f].MCL=1   then // Не использовать собственые цвета
    with Plos[f] do begin
    lDrKp:=lDrKp+1;sleep(1);
    EPlo1[lDrKp].VERS[1]:=Vers[1].Nom;
    EPlo1[lDrKp].VERS[2]:=Vers[2].Nom;
    EPlo1[lDrKp].VERS[3]:=Vers[3].Nom;
    EPlo1[lDrKp].VERS[4]:=Vers[3].Nom;
    EPlo1[lDrKp].VERS[5]:=Vers[4].Nom;
    EPlo1[lDrKp].VERS[6]:=Vers[1].Nom;
    end;
    MirPLos.DrKp:=lDrKp;
    // ========================================================================
    lDrKl:=0;
    with MirLins do for f:=1 to KolL do
    if   Lins[f].OBJ.VIS then
    if   Lins[f].ELE.VIS then
    if       Lins[f].VIS then
    if   not Lins[f].DEL then
    if   not Lins[f].MAR then
    with Lins[f] do begin
    lDrKl:=lDrKl+1;sleep(1);
    ELin1[lDrKl].VERS[1]:=Vers[1].Nom;
    ELin1[lDrKl].VERS[2]:=Vers[2].Nom;
    end;
    MirLins.DrKl:=lDrKl;
    // ========================================================================
    with MirVers do Move(ECoo1,ECoo2,(KolV+1)*SizeOf(RCS3));
    with MirVers do Move(ECol1,ECol2,(KolV+1)*SizeOf(RCOL));
    with MirLins do Move(ELin1,ELin2,(DrKl+0)*SizeOf(RLIN));
    with MirPlos do Move(EPlo1,EPlo2,(DrKP+0)*SizeOf(RPLO));
    // ========================================================================
    MirCols.Swap;
    end;
end;

Type TheadSSwa = class(TThread)
    private
    protected
    procedure Execute; override;
    public
    Constructor Create(CreateSuspended : boolean);
end;
constructor TheadSSwa.Create(CreateSuspended : boolean);
begin
  FreeOnTerminate := True;
  inherited Create(CreateSuspended);
end;
procedure   TheadSSwa.Execute;
begin
  Priority:=tpIdle;
  while (not Terminated) and (Clos=false) do
    begin
    sleep(500);
    end;
end;

var
headMath:TheadMath;
headSwap:TheadSwap;
headSSwa:TheadSSwa;

{%EndRegion}



procedure TForm3.Timer1Timer(Sender: TObject);// Запускатор
var
x,z:RINT;
begin
Timer1.enabled:=false;// Отключаем запускатор

  RBUT:=False;// Парвая кнопка мыши нажата
  DBUT:=False;// Двойной Щелчок мыши
  SBUT:=False;// Кнопка Shift
  GFon:=CreRCol(150,150,250,255);// Формируем цвет фона
  MirVers:=TVERS.Create;// Создаем списки вершин
  MirLins:=TLINS.Create;// Создаем списки Линий
  MirPlos:=TPLOS.Create;// Создаем списки плоскостей
  MirEles:=TELES.Create;// Создаем списки элементов
  MirObjs:=TOBJS.Create;// Создаем списки Обьектов
  MirSels:=TSELS.Create;// Создаем Буфер обмена
  MirAnis:=TAniS.Create;// Создаем списки анимаций
  MirScrs:=TScrS.Create;// Создаем списки скриптов
  MirCols:=TCols.Create;// Создает Цветные Плоскости
  // Отдельный поток для расчета координат всех вершин
  headMath:=TheadMath.Create(false);
  headSwap:=TheadSwap.Create(false);
  headSswa:=TheadSswa.Create(false);
  //HMath:=CreateThread(nil,0,@TheadMath,nil,0,HMathTrId);
  //HSWAP:=CreateThread(nil,0,@TheadSWAP,nil,0,HSwapTrId);
  //HSSWA:=CreateThread(nil,0,@TheadSSWA,nil,0,HSSwaTrId);
  //OpenGl настройки
  OpenGLControl1.OnPaint:= @OpenGLControl1Paint; // for "mode delphi" this would be "GLBox.OnPaint := GLboxPaint"
  OpenGLControl1.invalidate;
  glEnable(GL_DEPTH_TEST);
  glDisable(GL_Blend);
  //glEnable(GL_Blend);
  glDepthFunc(GL_LEQUAL);
  //glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnableClientState(GL_COLOR_ARRAY);
  glEnableClientState(GL_VERTEX_ARRAY);
  GlPointSize(25);// размер точек
  GlLineWidth(10);// рзмер Линий
  OpenGLControl1Resize(nil);// Начальное вычисление пропрций
  Ras3:=-300;
  Timer2.enabled:=true;// Врубаем отрисовку
  Timer3.enabled:=true;// Врубаем подсчет количества кадров в секунду
  GlDraw:=true;
end;

procedure TForm3.OpenGLControl1Paint(Sender: TObject);
var Tr:QWord;lCap2:RCS3;
begin
if GlDraw then begin
  begin // Подготовка в отрисовке
  timer2.Enabled:=false;
  Tr:=GetTickCount;
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
  lCap2:=Cap2;
  if   form4.CheckBox2.Checked then begin
  lCap2.X:=Cap2.X;
  lCap2.Y:=Cap2.Y+100;
  lCap2.Z:=Cap2.Z;
  end;
  glTranslateD(-lCaP2.x,-lCaP2.y,-lCaP2.z);// Координаты камеры
  end;
  if lBUT or DBut then I_EDI_IDD;// Отрисвока IDDDDDD    РЕДАКТОР
  if lBUT or DBut then I_SCE_IDD;// Отрисвока IDDDDDD    ИГРА
  I_SCE_COL;// Отрисвока Цветами    ИГРА
  I_EDI_COL;// Отрисвока Цветами    РЕДАКТОР
  begin // Завершение отрисовки
  OpenGLControl1.SwapBuffers;
  KolKAdVsek:=KolKAdVsek+1;
  TR:=GetTickCount-tr;
  timer2.Enabled:=true;
  end;
end;
end;
procedure TForm3.Timer2Timer(Sender: TObject);// ОТрисовка
begin
OpenGLControl1Paint(sender);
end;

procedure TForm3.Timer3Timer(Sender: TObject);// ПОдгонка чатсоты кадров
begin

  Caption:=IntToStr(KolKAdVsek)+' '+
             //FloatToStr(CaU2.X)+' '+
             //FloatToStr(CaU2.Z)+' '+
             intToStr(Trunc(Cap2.X))+' '+
             intToStr(Trunc(Cap2.Y))+' '+
             IntToStr(Trunc(Cap2.Z))+' '+
             FloatToStr(RAsN)+' '+
             IntToStr(MirVers.KOLV)+' '+
             boolToStr(SBUT)+' '
             ;
if (KolKAdVsek>33) and (Timer2.interval<50) then Timer2.interval:=Timer2.interval+1;
if (KolKAdVsek<33) and (Timer2.interval>20) then Timer2.interval:=Timer2.interval-1;
KolKAdVsek:=0;

//if (MouN.X>form4.Left) and
//(MouN.X<=form4.Left+form4.width) and
//(MouN.Z> form4.Top) and
//(MouN.Z<=form4.Top+form4.Height)
//then form4.Visible:=true else form4.Visible:=false;


end;

{%EndRegion}
var   {События формы          ===========================}{%Region /FOLD }
                                                           Reg15:Longint;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  halt;
end;
procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
     i_CLOSE;
end;
procedure TForm3.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Shift=[ssShift] then SBUT:=true;
  //showmessage(intToStr(key));
end;

procedure TForm3.FormKeyPress(Sender: TObject; var Key: char);
var lPri:TVer;
begin

  if (ord(Key)=63) or (ord(Key)=101) then
  if MirSels.KOl>0 then  begin
  lPri:=MirSels.Sels[1];
  if lPri.TIP=T_VER then  U_OpenPoint(lPri,lPri.ELE);
  if lPri.TIP=T_LIN then  U_OpenLine(lPri,lPri.ELE);
  if lPri.TIP=T_PLO then  U_OpenPLos(lPri,lPri.ELE);
  if lPri.TIP=T_ELE then  U_OpenElement(lPri,lPri.ELE);
  if lPri.TIP=T_OBJ then  U_OpenObject(lPri);

  end;
end;
procedure TForm3.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  SBUT:=false;
  if key=46 then I_DelDel(form4.Act);
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
  gluPerspective(45, OpenGLControl1.Width / OpenGLControl1.Height,MinRAsInMir,MAxRAsInMir);// Устанвока перспективы (Угол обзора в градусах,Соотношение сторон ,Ближний предел ,дальний предел )
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
  if Button=mbRight then RBut:=False;
  if Button=mbLeft  then LBut:=False;
end;
procedure TForm3.OpenGLControl1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  MouN.X:=X;// Это где находиться мышка в натсоящий момент времени
  MouN.Z:=Y;// Смето Y я использую Z не помню почему ну просто так
  if RBut Then begin
  CaU3.X:=CaU1.X+(MouN.Z-MouD.Z); // Вычитаю разницу между тем где была
  CaU3.Z:=CaU1.Z+(MouN.X-MouD.X); // Нажата мышка и настоящим моментом
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
  if Button=mbRight then RBut:=true;
  if Button=mbLeft  then LBut:=true;
end;

{%EndRegion}
end.

{
procedure MATH;// Перевычисление обьектов
var fo:RLON;
begin
for fo:=1 to MirObjs.KOlO do
if not MirObjs.OBJS[Fo].DEL Then begin
MirObjs.OBJS[Fo].O_MATH;
end;
end;
}
