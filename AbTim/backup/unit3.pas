unit Unit3; {$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, FileUtil, OpenGLContext, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls,windows,CheckLst,Types,Gl,Glu;
type { TForm3 }  TForm3 = class(TForm)
    OpenGLControl1: TOpenGLControl;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
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

GStep:REal=0.1;// Шаг для Колеса мышки
G_FileName:Ansistring='';// Имя файла с котрым работаем
G_Change:Boolean=False;// В проекте есть не сохраненные изменения

procedure I_NewPoint(iEle:Pointer);// Создает Вершины
procedure I_DelPoint(iVer:Pointer);// Удаление Вершины

procedure I_NewPlos(iObj:Pointer);// Создает Плоскости
procedure I_DelPlos(iPlo:Pointer);// Удаление Плоскости

procedure I_NewElement(iEle:Pointer);// Создает новый Элемент
procedure I_DelElement(iEle:Pointer);// Удаление Элемента

procedure I_NewObject;// Создает новый обьект
procedure i_DelObject(iObj:pointer);// Удаление обьекта

procedure I_RefreshSpisokPoints   (iEle:POinter;iLis:TCheckListBox);
procedure I_RefreshSpisokPlos     (iObj:POinter;iLis:TCheckListBox);
procedure I_RefreshSpisokElements (iEle:POinter;iLis:TCheckListBox);
procedure I_RefreshSpisokObjects  (iLis:TCheckListBox);

procedure I_GetN(iVer:Pointer;iEdit:TEdit);
procedure I_GetX(iVer:Pointer;iEdit:TEdit);
procedure I_GetY(iVer:Pointer;iEdit:TEdit);
procedure I_GetZ(iVer:Pointer;iEdit:TEdit);
procedure I_GetCol(iVer:Pointer;iEdit:TEdit);
procedure I_GetAlp(iVer:Pointer;iEdit:TEdit);
procedure I_GetUX(iEle:Pointer;iEdit:TEdit);
procedure I_GetUY(iEle:Pointer;iEdit:TEdit);
procedure I_GetUZ(iEle:Pointer;iEdit:TEdit);

procedure I_SetN(iVer:Pointer;iEdit:TEdit);
procedure I_SetX(iVer:Pointer;iEdit:TEdit);
procedure I_SetY(iVer:Pointer;iEdit:TEdit);
procedure I_SetZ(iVer:Pointer;iEdit:TEdit);
procedure I_SetCol(iVer:Pointer ;iEdit:TEdit);
procedure I_SetAlp(iVer:Pointer ;iEdit:TEdit);
procedure I_SetUX(iEle:Pointer;iEdit:TEdit);
procedure I_SetUY(iEle:Pointer;iEdit:TEdit);
procedure I_SetUZ(iEle:Pointer;iEdit:TEdit);

function  I_RodEle(iEle,iObj:Pointer):Boolean;
procedure I_SetSel(iPri:pointer;iSel:boolean);

function isFloat(s:AnsiString):Boolean;
function inFloat(s:AnsiString):real;
function InString(i:REal):ansiString;

procedure I_ClearScena;// Очищает Сцену
procedure I_SaveScena(iNamFile:Ansistring);// Сохраняет сцену

{%EndRegion}
implementation {$R *.lfm} uses unit4,unit5,unit6,unit7,unit8;

const {Базовые Константы      ===========================}{%Region /FOLD }

  GMAxRAsInMir=1024*8;// Растояние на котором вершину не видно
  MAxRAsInMir=32;//Максимальное растояние в игровом мире от камеры

  MaxKolVerInEle=128;// Максимальное количество Вершин в Элементе
  MaxKolLinInObj=128;// Максимальное количество Линий в Элементе
  MaxKolPloInObj=256;// Максимальное количество Плоскостей в Элементе
  MaxKolObjInObj=128;// Максимальное количество Плоскостей в Элементе
  MaxKolEleInEle=128;// Максимальное количество Обьектов в Элементе

  MaxKOlVerInMir=1024*64;//Максимальное количество вершин в игровом мире
  MaxKOlPloInMir=1024*64;//Максимальное количество Плоскостей в игровом мире
  MaxKOlEleInMir=1024*64;//Максимальное количество Элементов в игровом мире
  MaxKOlObjInMir=1024*64;//Максимальное количество Обьектов в игровом мире

  MinKolDelVers=1024*4;// Минимальный размер очереди на удаление вершин
  MinKolDelPlos=1024*4;// Минимальный размер очереди на удаление плоскотей
  MinKolDelEles=1024*4;// Минимальный размер очереди на удаление элементов
  MinKolDelObjs=1024*4;// Минимальный размер очереди на удаление Обьектов

  MaxKolDelVers=1024*64;// Максимальный размер очереди на удаление вершин
  MaxKolDelPlos=1024*64;// Максимальный размер очереди на удаление плоскотей
  MaxKolDelEles=1024*64;// Максимальный размер очереди на удаление элементов
  MaxKolDelObjs=1024*64;// Максимальный размер очереди на удаление Обьектов

  MaxKolSelPris=1024*64 ;// Максимальнео количество выделеных примитивов

  T_VER=1;// Вршина
  T_PLO=2;// Плоскость
  T_ELE=3;// Элементы
  T_OBJ=4;// Обьекеты

  SCX= 0;
  SCZ= 0;
  RL = 3;
  _D = 3;

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


{%EndRegion}
var   {Базовые переменные     ===========================}{%Region /FOLD }

  GIDD:RLON;// Для генерации уникальных IDD
  GERR:RBOL;// Флаг ошибки Если в программе сбой

  KolKAdVsek:Longint;// Количество кадров в секунду

  HMath:HAndle;HMathTrId:DWORD;// Поток
  Clos:Boolean;// Флаг Завершения программы

  LBut:RBOL;// Состояние Левой кнопки мышки
  RBut:RBOL;// Состояние Правой кнопки мышки

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
      function NewIdd:RLon;// Генерирует уникальный IDD
      begin
      GIDD:=GIDD+1;
      NewIdd:=GIDD;
      end;
      function isFloat(s:AnsiString):Boolean;
      var f,c:Longint;r:real;Rez:Boolean;
      begin
        Rez:=False;
        val(s,r,c);
        if C=0 then Rez:=True;
        isFloat:=Rez;
      end;
      function inFloat(s:AnsiString):real;
      var f,c:Longint;r:real;Rez:Boolean;
      begin
        r:=0;
        val(s,r,c);
        inFloat:=r;
      end;
      function InString(i:REal):ansiString;
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
      While (Length(Rez)>1) and (
      (Rez[Length(Rez)]='0') or (Rez[Length(Rez)]='.')) do
      delete(rez,Length(Rez),1);
      InString:=REz;
      end;

{%EndRegion}

var   {Описание вершины       ===========================}{%Region /FOLD }
                                                           Reg05:Longint;
TYPE TVER=CLASS  // Опсиание вершиины

  NAM:RSTR;// Наименование элемента
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

  NAM:=''           ;
  SEL:=false        ;// Не выделен примитив
  IDD:=NewIdD       ;// оплучаем уникальный идентификатор
  NOM:=0            ;// Номер в списке отрисовки
  TIP:=1            ;

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
  I_SetSel(iVer,false);// Снимаю выделение елси оно есть
  IVer.Del:=True;
  if KolD+1>MaxKolDelVers then
  ERR(' TVERS.AddD(iVer:Tver) KolD+1>MaxKolDelVers');
  DELV[KolD+1]:=iVer;
  KolD:=KolD+1;
end;
Constructor TVERS.Create;
begin
KolV:=0;
KolD:=0;
end;

{%EndRegion}
var   {Описание Плоскоси      ===========================}{%Region /FOLD }
                                                           Reg06:Longint;

TYPE  TPLO=CLASS(TVER)
  VERS:Array[1..4] of TVER;// Вершины из котрых состоит плоскость
  Function    P_Viso(iCoo:RCS3):RSIN;// Определить высоту на плоскости
  Procedure   P_Gaba;// Вычислене габаритов
  Constructor Create(iVer1,iVer2,iVer3,iVer4:Tver);// Конструктор
  Destructor  destroy;override;
end;
TYPE TPLOS=CLASS
Kol2:RLON;// Клдичество реально рисуемых плоскостей
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

if (GMax.X<REA.x+0.01) then GMax.X:=REA.x+0.01;
if (GMax.Y<REA.y+0.01) then GMax.Y:=REA.y+0.01;
if (GMax.Z<REA.z+0.01) then GMax.Z:=REA.z+0.01;

if (GMin.X>REA.x-0.01) then GMin.X:=REA.x-0.01;
if (GMin.Y>REA.y-0.01) then GMin.Y:=REA.y-0.01;
if (GMin.Z>REA.z-0.01) then GMin.Z:=REA.z-0.01;

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
TIP:=2;

end;
Destructor  TPLO.Destroy;
begin
inherited Destroy;
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
  I_SetSel(iPlo,false);// Снимаю выделение елси оно есть
  IPlo.Del:=True;
  if KolD+1>MaxKolDelPlos then
  ERR(' TPLOS.AddD(iPlo:TPlo);  KolD+1>MaxKolDelPlos');
  DELP[KolD+1]:=iPlo;
  KolD:=KolD+1;
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
  DELE :Array[1..MaxKOlEleInMir] of TELE;// Список элемента  на удаление очередь
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
Rez:=TELE.CREATE;// Создаю экземпляр вершины
Rez.OBJ:=OBJ;
Rez.ELE:=Self;
ELES[KolE+1]:=Rez;// Добавляю Верину в список элементов
KolE:=KolE+1;// Увеличиваю количество  элементов
MirEles.AddE(Rez);
E:=Rez;
end;
function    TELE.V(iX,iY,iZ:RSIN):TVER;// Добавляет вершину
Var Rez:TVER;
begin
Rez:=TVER.CREATE;// Создаю экземпляр вершины
Rez.Obj:=Obj;
Rez.Ele:=Self;
VERS[KolV+1]:=Rez;// Добавляю Верину в список верши элемента
KolV:=KolV+1;// Увеличиваю количество вершин в элементе
MirVers.AddV(Rez);
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
ECR:=SerRCS3(ECR,REA);
for f:=1 to KolE do with ELES[f] do E_SECR;
for f:=1 to KolV do with VERS[f] do ECR:=SerRCS3(ECR,REA);
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

if (GMax.X<REA.x+0.01) then GMax.X:=REA.x+0.01;
if (GMax.Y<REA.y+0.01) then GMax.Y:=REA.y+0.01;
if (GMax.Z<REA.z+0.01) then GMax.Z:=REA.z+0.01;

if (GMin.X>REA.x-0.01) then GMin.X:=REA.x-0.01;
if (GMin.Y>REA.y-0.01) then GMin.Y:=REA.y-0.01;
if (GMin.Z>REA.z-0.01) then GMin.Z:=REA.z-0.01;

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
TIP:=3;
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
  I_SetSel(iEle,false);// Снимаю выделение елси оно есть
  IEle.Del:=True;
  for f:=1 to iEle.KOlV do MirVers.addD(iEle.VERS[f]);// Вершины на удаление
  for f:=1 to iEle.KolE do MirEles.AddD(iEle.Eles[f]);// Удаление элементов
  if KolD+1>MinKolDelEles then
  ERR(' TELES.AddD(iELE:TELE) KolD+1>MinKolDelEles' );
  DELE[KolD+1]:=iEle;
  KolD:=KolD+1;
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
  KolP:RLON;// Количество плоскостей
  KolD:RLON;// Количество Зависимых обьектов
  PLOS:Array[1..MaxKolPloInObj] of TPLO;// Плоскости
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
  constructor Create;// Констурктор
  Destructor  destroy;override;
  function    P(iVer1,iVer2,iVer3,iVer4:TVER):TPLO;// Добавляет плоскость

End;
TYPE TOBJS=CLASS
KOLO:Longint;
KOLD:Longint;
OBJS:Array[1..MaxKOlVerInMir] of TOBJ;
DELO:Array[1..MaxKOlVerInMir] of TOBJ;
Procedure   Ras;
Function    AddO(iObj:TOBJ):Tobj;
procedure   AddD(iObj:TOBJ);
Constructor Create;
end;
var  MirObjs:TOBJS;

function    TOBJ.P(iVer1,iVer2,iVer3,iVer4:TVER):TPLO;// Добавляет плоскость
Var Rez:TPLO;
begin
Rez:=TPLO.CREATE(iVer1,iVer2,iVer3,iVer4);
Rez.Obj:=Obj;
Rez.Ele:=Self;
PLOS[KolP+1]:=Rez;
KolP:=KolP+1;
MirPlos.AddP(Rez);
P:=Rez;
end;

Procedure   TOBJ.AddDels(iObj:Tobj);// Добавлет зависимый обьект
begin
if (KolD+1>MaxKolObjInObj) then
ERR(' TOBJ.AddDels(iObj:Tobj) (KolD+1>MaxKolObjInObj)');
Dels[KolD+1]:=iObj;
KolD:=Kold+1;
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
O_RAST;// ВЫчисление растояний
end;
procedure   TOBJ.O_SREA;// Вычисление Реальных координат
var f:Longint;
begin
inherited E_SREA;// Вычисление Реальных координат вершин и вложеных элементов
For F:=1 to KOlP do With PLOS[f] do REA:=SerRCs3(VERS[1].REA,VERS[3].REA);
end;
procedure   TOBJ.O_SECR;// Вычисление Экранных координат
var f:Longint;
begin
inherited E_SECR;
for f:=1 to KolP do with PLOS[F] do ECR:=SerRCS3(ECR,REA);
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
end;
procedure   TOBJ.O_RAST;// Вычисление Растояний от камеры
var f:Longint;
begin
inherited E_RAST;// Вычисление растоний от элементов и вершин
RAS:=RasRCS3(REA,CaP2);// Вычисление растояний от камеры до обьекта
// Вычисление растояния от камеры до плоскостей
for f:=1 to KolP do
With PLoS[f] do begin
REA:=SerRCS3(Vers[1].REA,Vers[3].REA);
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
TIP:=4;
Kadr:=1;
OBJ:=Self;
KolP:=0;
KolD:=0;
OBJ:=Self;
ELE:=Self;
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
I_SetSel(iObj,false);// Снимаю выделение елси оно есть
iOBJ.Del:=true;
for f:=1 to iOBJ.KolD do MirObjs.AddD(iOBJ.Dels[f]);// Удаление зависимых обьек
for f:=1 to iOBJ.KOlV do MirVers.addD(iOBJ.VERS[f]);// Вершины на удаление
for f:=1 to iOBJ.KolE do MirEles.AddD(iOBJ.Eles[f]);// Удаление элементов
for f:=1 to iOBJ.KolP do MirPLos.AddD(iOBJ.Plos[f]);// Удалене плоскостией
DELO[KolD+1]:=iOBJ;
KolD:=KolD+1;
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
var   {Загрузки выгрузки      ===========================}{%Region /FOLD }
                                                           Reg09:Longint;

Procedure I_Del_Spac(var iPos:Longint;var iStr:Ansistring);
begin
while (iStr[iPos]<=' ') and (length(iStr)>=iPos) do inc(iPos);
end;
function  I_GetSC(var iPos:Longint;var iStr:Ansistring):Ansistring;
var Rez:Ansistring;
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
I_GetSC:=Rez;
end;
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

for f:=1 to iEle.KOlV do I_TVER_PUT_01(iEle.Vers[f],iStr);
for f:=1 to iEle.KOlE do I_TELE_PUT_01(iEle.Eles[f],iStr);

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

for f:=1 to iObj.KOlV do I_TVER_PUT_01(iObj.Vers[f],iStr);
for f:=1 to iObj.KOlE do I_TELE_PUT_01(iObj.Eles[f],iStr);
for f:=1 to iObj.KOlP do I_TPLO_PUT_01(iObj.Plos[f],iStr);

end;

function  I_GetEl(iVer:TVer):Tele;// возвращает элемент в котором находимся
var REz:Tele;
begin

      if iVer=nil then ERR(' I_GetEl iVer=nil  ') else
      if iVer.TIP=T_VER Then Rez:=TEle(iVer.Ele) else
      if iVer.TIP=T_PLO Then Rez:=TEle(iVer.Ele) else
      if iVer.TIP=T_ELE Then Rez:=TEle(iVer) else
      if iVer.TIP=T_OBJ Then Rez:=TEle(iVer) else
      ERR(' I_GetEl last else ');
      I_GetEl:=Rez;

end;
function  I_GetOb(iVer:TVer):TObj;// возвращает Обьект в котором находимся
begin

end;
function  I_GetPl(iVer:TVer):TObj;// возвращает плоскость послед упоминаемую
begin

end;

function  I_FIN_VER(iVer:Tver;iNam:Ansistring):TVer;// Ищит вершину с заданым иенем
begin
end;
function  I_FIN_PLO(iVer:Tver;iNam:Ansistring):TPlo;// Ищит Плоскость с заданым иенем
begin
end;
function  I_FIN_ELE(iVer:Tver;iNam:Ansistring):TEle;// Ищит Элемент с заданым иенем
begin
end;
function  I_FIN_OBJ(iNam:Ansistring):TObj;// Ищит Обьект с заданым иенем
begin
end;


Procedure I_SCENA_GET_01(iVer:TVer;var iStr:Ansistring);
var
lPos:Longint;
lVer:TVer;
lPlo:TPlo;
lEle:TEle;
lObj:Tobj;
begin
lPos:=1;
While lPos<Length(iStr) do begin    I_Del_Spac(lPos,iStr);
// Созаю елси нету таких элементов если есть назначаю текущим ------
     if iStr[lPos]='O' Then begin
     lObj:=I_FIN_OBJ(I_GetSC(lPos,iStr));
     if lObj=nil
     then iVer:=MirObjs.AddO(TObj.Create)
     else iVer:=lObj;
     iVer.Nam:=I_GetSC(lPos,iStr);
     end
else if iStr[lPos]='E' Then begin
     lEle:=I_FIN_Ele(iVer,I_GetSC(lPos,iStr));
     if   lEle=nil
     then iVer:=I_GetEl(iVer).E(0,0,0)
     else iVer:=lEle;
     iVer.Nam:=I_GetSC(lPos,iStr);
     end
else if iStr[lPos]='P' Then begin
     lPlo:=I_FIN_Plo(iVer,I_GetSC(lPos,iStr));
     if   lPlo=nil
     then iVer:=I_GetOb(iVer).P(iVer,iVer,iVer,iVer)
     else iVer:=lPlo;
     iVer.Nam:=I_GetSC(lPos,iStr);
     end
else if iStr[lPos]='V' Then begin
     lVer:=I_FIN_Ver(iVer,I_GetSC(lPos,iStr));
     if lVer=Nil
     then iVer:=I_GetEl(iVer).V(0,0,0)
     else iVer:=lVer;
     iVer.Nam:=I_GetSC(lPos,iStr)
     end
// Имя          ----------------------------------------------------
else if iStr[lPos]='N' Then begin
     iVer.NAm:=I_GetSC(lPos,iStr);
     end
// Коринаты     ----------------------------------------------------
else if iStr[lPos]='X' Then begin
     iVer.LOC.X:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='Y' Then begin
     iVer.LOC.X:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='Z' Then begin
     iVer.LOC.Z:=inFloat(I_GetSC(lPos,iStr))
     end
// Цвета        ----------------------------------------------------
else if iStr[lPos]='R' Then begin
     iVer.COL.R:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='G' Then begin
     iVer.COL.G:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='B' Then begin
     iVer.COL.B:=StrToInt(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='A' Then begin
     iVer.COL.A:=StrToInt(I_GetSC(lPos,iStr))
     end
// Углы наклона ----------------------------------------------------
else if iStr[lPos]='x' Then begin
     I_GetEl(iVer).EUGL.X:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='y' Then begin
     I_GetEl(iVer).EUGL.Y:=inFloat(I_GetSC(lPos,iStr))
     end
else if iStr[lPos]='z' Then begin
     I_GetEl(iVer).EUGL.Z:=inFloat(I_GetSC(lPos,iStr))
     end
// Имена вершмин для плоскости -------------------------------------
else if iStr[lPos]='a' Then begin
     I_GetPl(iVer).VERS[1]:=I_FIN_VER(iVer,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='b' Then begin
     I_GetPl(iVer).VERS[2]:=I_FIN_VER(iVer,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='c' Then begin
     I_GetPl(iVer).VERS[3]:=I_FIN_VER(iVer,I_GetSC(lPos,iStr));
     end
else if iStr[lPos]='d' Then begin
      I_GetPl(iVer).VERS[4]:=I_FIN_VER(iVer,I_GetSC(lPos,iStr));
     end
else inc(lPos);
end
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
function  TSels.EST(iSel:Tver):Longint;// Возвращет номер в выделеных
var f,Rez:Longint;
begin
 Rez:=0;F:=1;
 while (f<=Kol) and (Rez=0) do
 if iSel=Sels[f] then Rez:=f else f:=f+1;
 EST:=Rez;
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
 if (SELS[f].TIP=1) then REz.Add(SELS[f]);
 SELVERS:=Rez;
end;
function  TSels.SELPLOS:TSels;// Возвращает Список выделеных Плоскостей
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=2) then REz.Add(SELS[f]);
 SELPLOS:=Rez;
end;
function  TSels.SELELES:TSels;// Возвращает Список выделеных Элементов
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=3) then REz.Add(SELS[f]);
 SELELES:=Rez;
end;
function  TSels.SELOBJS:TSels;// Возвращает Список выделеных ОБьектов
var Rez:TSels;f:longint;
begin
 REz:=TSels.Create;
 for f:=1 to Kol do
 if (SELS[f].TIP=4) then REz.Add(SELS[f]);
 SELOBJS:=Rez;
end;

{%EndRegion}
var   {Интерфейс редактора    ===========================}{%Region /FOLD }
                                                           Reg11:Longint;

procedure I_RefreshSpisokObjects (iLis:TCheckListBox);// Список с обьекта
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
procedure I_RefreshSpisokPoints  (iEle:POinter;iLis:TCheckListBox);
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
procedure I_RefreshSpisokPlos    (iObj:POinter;iLis:TCheckListBox);
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
procedure I_RefreshSpisokElements(iEle:POinter;iLis:TCheckListBox);
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

procedure I_GetN(iVer:Pointer ;iEdit:TEdit);
begin
iEdit.Text:=TVEr(iVer).NAM;
end;
procedure I_GetX(iVer:Pointer ;iEdit:TEdit);
begin
iEdit.Text:=InString(TVEr(iVer).LOC.X);
end;
procedure I_GetY(iVer:Pointer ;iEdit:TEdit);
begin
iEdit.Text:=InString(TVEr(iVer).LOC.Y);
end;
procedure I_GetZ(iVer:Pointer ;iEdit:TEdit);
begin
iEdit.Text:=InString(TVEr(iVer).LOC.Z);
end;

procedure I_GetCol(iVer:Pointer ;iEdit:TEdit);
begin
//iEdit.Text:=InString(ColToInt(TVEr(iVer).COL));
end;
procedure I_GetAlp(iVer:Pointer ;iEdit:TEdit);
begin
iEdit.Text:=InString(TVEr(iVer).Col.A);
end;


procedure I_GetUX(iEle:Pointer;iEdit:TEdit);
begin
iEdit.Text:=InString(TEle(iEle).EUGL.X);
end;
procedure I_GetUY(iEle:Pointer;iEdit:TEdit);
begin
iEdit.Text:=InString(TEle(iEle).EUGL.Y);
end;
procedure I_GetUZ(iEle:Pointer;iEdit:TEdit);
begin
iEdit.Text:=InString(TEle(iEle).EUGL.Z);
end;

procedure I_SetN(iVer:Pointer ;iEdit:TEdit);
begin
G_Change:=true;
TVEr(iVer).NAM:=iEdit.Text;
end;
procedure I_SetX(iVer:Pointer ;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then begin
TVEr(iVer).Loc.X:=inFloat(iEdit.Text);
TObj(TVEr(iVer).OBJ).O_MATH;
end;
end;
procedure I_SetY(iVer:Pointer ;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then begin
TVEr(iVer).Loc.Y:=inFloat(iEdit.Text);
TObj(TVEr(iVer).OBJ).O_MATH;
end;
end;
procedure I_SetZ(iVer:Pointer ;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then begin
TVEr(iVer).Loc.Z:=inFloat(iEdit.Text);
TObj(TVEr(iVer).OBJ).O_MATH;
end;
end;
procedure I_SetCol(iVer:Pointer;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then
TVEr(iVer).COL:=IntToCol(trunc(inFloat(iEdit.Text)));
end;
procedure I_SetAlp(iVer:Pointer;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then
TVEr(iVer).COL.A:=trunc(inFloat(iEdit.Text));
end;
procedure I_SetUX(iEle:Pointer;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then begin
TEle(iEle).EUGL.X:=inFloat(iEdit.Text);
TObj(TVEr(iEle).OBJ).O_MATH;
end;
end;
procedure I_SetUY(iEle:Pointer;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then begin
TEle(iEle).EUGL.Y:=inFloat(iEdit.Text);
TObj(TVEr(iEle).OBJ).O_MATH;
end;
end;
procedure I_SetUZ(iEle:Pointer;iEdit:TEdit);
begin
G_Change:=true;
if isFloat(iEdit.Text) then begin
TEle(iEle).EUGL.Z:=inFloat(iEdit.Text);
TObj(TVEr(iEle).OBJ).O_MATH;
end;
end;

procedure I_NewPoint(iEle:Pointer);// Создает Вершины
Var
rEle:TEle;
lVer:TVer;
begin
G_Change:=true;
rEle:=TEle(iEle);
lVer:=rEle.V(0,0,0);
lVer.Nam:='V '+IntToStr(lVer.IDD);
TObj(lVer.Obj).O_MATH;
end;
procedure I_DelPoint(iVer:Pointer);// Удаление Вершины
var
dVer:TVer;F:Longint;
begin
G_Change:=true;
dVer:=TVer(iVer);
// Удаление форм ---------------------------------------------------------------
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform8) then
if ((application.Components[f] as tform8).VER=iVer) then
    (application.Components[f] as tform8).close;
// удаление в структуре --------------------------------------------------------
MirVers.AddD(dVer);// Добавляем Вершину в удаляемые
end;
procedure I_NewPlos(iObj:Pointer);// Создает Вершины
Var
rObj:TObj;
lPLo:TPlo;
lSel:TSels;
begin
G_Change:=true;
lSel:=MirSels.SELVERS;
if lSel.KOl>=4 Then begin
rObj:=TObj(iObj);
lPlo:=rObj.P(lSel.SELS[4],
             lSel.SELS[3],
             lSel.SELS[2],
             lSel.SELS[1]);
lPlo.Nam:='P '+IntToStr(lPlo.IDD);
TObj(lPlo.Obj).O_MATH;
end;
lSel.free;
end;
procedure I_DelPLos(iPlo:Pointer);// Удаление Вершины
var
dPlo:TPlo;
begin
G_Change:=true;
dPlo:=TPlo(iPlo);
MirPLos.AddD(dPlo);// Добавляем Вершину в удаляемые
end;
procedure I_NewElement(iEle:Pointer);// Создает новый Элемент
Var
rEle:TEle;
lEle:TEle;
begin
G_Change:=true;
rEle:=TEle(iEle);
lEle:=rEle.E(0,0,0);
lEle.Nam:='E '+IntToStr(lEle.IDD);
TObj(lEle.Obj).O_MATH;
end;
procedure I_DelElement(iEle:Pointer);// Удаление Элементов
var
dEle:TEle;f:Longint;
begin
G_Change:=true;
dEle:=TEle(iEle);
// удаляем форму редактора   ---------------------------------------------------
for f:=0 to application.ComponentCount-1 do
if (application.Components[f] is tform8) then begin // Формы вершин
   if I_RodEle((application.Components[f] as tform8).ELE,dEle) then
   (application.Components[f] as tform8).close;
end else
if (application.Components[f] is tform7) then begin // Формы элементов
   if I_RodEle((application.Components[f] as tform7).ELE,dEle) then
   (application.Components[f] as tform7).close;
end;
// удаляем в самой структуре ---------------------------------------------------
MirEles.AddD(dEle);// Добавляем Элемент в удаляемые
end;
procedure I_NewObject;// Создает новый обьект
Var nObj:TObj;
begin
G_Change:=true;
nObj:=TObj.Create;
nObj.Nam:='Object '+IntToStr(nObj.IDD);
nObj.O_MATH;
MirObjs.AddO(nObj);
end;
procedure I_DelObject(iObj:pointer);// Удаление обьектов
Var
dObj:TObj;f:Longint;
begin
G_Change:=true;
dObj:=TObj(iObj);
// Удаление форм ---------------------------------------------------------------
for f:=0 to application.ComponentCount-1 do
     if (application.Components[f] is tform8) then begin // Вершины
     if I_RodEle((application.Components[f] as tform8).ELE,dObj) then
        (application.Components[f] as tform8).close;
     end
else if (application.Components[f] is tform7) then begin // Элементы
     if I_RodEle((application.Components[f] as tform7).ELE,dObj) then
     (application.Components[f] as tform7).close;
     end
else if (application.Components[f] is tform6) then  begin // обьекты
     if I_RodEle((application.Components[f] as tform6).OBJ,dObj) then
     (application.Components[f] as tform6).close;
     end;
// Удаление в тсруктуре --------------------------------------------------------
MirObjs.AddD(dObj);// Добавляем обьект в удаляемые
end;
procedure I_RefreshActiveElement;
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
I_GETX(Act,Edit1);edit1.Enabled:=true;
I_GETY(Act,Edit2);edit2.Enabled:=true;
I_GETZ(Act,Edit3);edit3.Enabled:=true;
I_GETCol(Act,Edit7);edit7.Enabled:=true;
I_GETAlp(Act,Edit8);edit8.Enabled:=true;
end;
// Читаюю углы наклона
if (TVer(Act).TIP=T_ELE)or(TVer(Act).TIP=T_OBJ)
then begin // Включаю углы наклона
I_GETUX(Act,Edit4);edit4.Enabled:=true;
I_GETUY(Act,Edit5);edit5.Enabled:=true;
I_GETUZ(Act,Edit6);edit6.Enabled:=true;
end
else begin // Отключаю углы наклона
I_GETUX(Act,Edit4);edit4.Enabled:=false;
I_GETUY(Act,Edit5);edit5.Enabled:=false;
I_GETUZ(Act,Edit6);edit6.Enabled:=false;
end;

end;
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
I_RefreshActiveElement;
// -----------------------------------------------------------------------------
end;

procedure I_DrVertex (iVer:TVer;iCol:RCol);// Вывод вершины
begin
glColor3ub(iCol.R,iCol.G,iCol.B);
glBegin(GL_POINTS);
glVertex3f(iVer.ECR.X,iVer.ECR.Y,iVer.ECR.Z);
glEnd();
end;
procedure I_DrPlos   (iPlo:TPlo;iCol:RCol);// Вывод Плоскости
var C:RCol;
begin
C:=iPlo.Col;
glColor3ub(iCol.R,iCol.G,iCol.B);
glBegin(GL_LINES);
with iPlo do begin

glVertex3f(iPlo.VErs[1].ECR.X,iPlo.VErs[1].ECR.Y,iPlo.VErs[1].ECR.Z);
glVertex3f(iPlo.VErs[2].ECR.X,iPlo.VErs[2].ECR.Y,iPlo.VErs[2].ECR.Z);
glVertex3f(iPlo.VErs[2].ECR.X,iPlo.VErs[2].ECR.Y,iPlo.VErs[2].ECR.Z);
glVertex3f(iPlo.VErs[3].ECR.X,iPlo.VErs[3].ECR.Y,iPlo.VErs[3].ECR.Z);
glVertex3f(iPlo.VErs[3].ECR.X,iPlo.VErs[3].ECR.Y,iPlo.VErs[3].ECR.Z);
glVertex3f(iPlo.VErs[4].ECR.X,iPlo.VErs[4].ECR.Y,iPlo.VErs[4].ECR.Z);
glVertex3f(iPlo.VErs[4].ECR.X,iPlo.VErs[4].ECR.Y,iPlo.VErs[4].ECR.Z);
glVertex3f(iPlo.VErs[1].ECR.X,iPlo.VErs[1].ECR.Y,iPlo.VErs[1].ECR.Z);

end;
glEnd();
end;
procedure I_DrElement(iEle:TEle;iCol:RCol);// Вывод Элемента
var C:RCol;
begin
C:=iEle.Col;
glColor3ub(iCol.R,iCol.G,iCol.B);
glBegin(GL_LINES);
with iEle do begin

glVertex3f(GMin.X,GMin.Y,GMin.Z);
glVertex3f(GMin.X,GMAx.Y,GMin.Z);

glVertex3f(GMAX.X,GMin.Y,GMin.Z);
glVertex3f(GMAX.X,GMAx.Y,GMin.Z);

glVertex3f(GMAX.X,GMin.Y,GMAX.Z);
glVertex3f(GMAX.X,GMAx.Y,GMAX.Z);

glVertex3f(GMin.X,GMin.Y,GMAX.Z);
glVertex3f(GMin.X,GMAx.Y,GMAX.Z);

end;
glEnd();
end;
procedure I_DrObject (iObj:TObj;iCol:RCol);// Вывод ОБьекта
begin
glColor3ub(iCol.R,iCol.G,iCol.B);
glBegin(GL_LINES);
with iObj do begin

glVertex3f(GMin.X,GMin.Y,GMin.Z);
glVertex3f(GMin.X,GMAx.Y,GMin.Z);

glVertex3f(GMAX.X,GMin.Y,GMin.Z);
glVertex3f(GMAX.X,GMAx.Y,GMin.Z);

glVertex3f(GMAX.X,GMin.Y,GMAX.Z);
glVertex3f(GMAX.X,GMAx.Y,GMAX.Z);

glVertex3f(GMin.X,GMin.Y,GMAX.Z);
glVertex3f(GMin.X,GMAx.Y,GMAX.Z);

end;
glEnd();
end;
procedure I_EDITDRAWSEL(ClientHeight:Longint);
var f,RC:LongWord;
begin
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
//------------------------------------------------------------------------------
for f:=1 to MirVers.KolV do if not MirVers.VERS[f].DEL then
I_DrVertex(MirVers.VERS[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirVers.KolV) then begin
MirVers.Vers[RC].Sel:=not MirVers.Vers[RC].Sel;
I_SetSel(MirVers.Vers[RC],MirVers.Vers[RC].Sel);CaP3:=MirVers.Vers[RC].ECR;
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
//------------------------------------------------------------------------------
for f:=1 to MirPlos.KolP do if not MirPlos.PLOS[f].DEL then
I_DrPlos(MirPLos.PLOS[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirPLos.KolP) then begin
MirPlos.Plos[RC].Sel:=not MirPlos.Plos[RC].Sel;
I_SetSel(MirPLos.PLos[RC],MirPlos.Plos[RC].Sel);
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
//------------------------------------------------------------------------------
for f:=1 to MirEles.KolE do if not MirEles.ELES[f].DEL then
I_DrElement(MirEles.ELES[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirEles.KolE) then begin
MirEles.Eles[RC].Sel:=not MirEles.Eles[RC].Sel;
I_SetSel(MirEles.Eles[RC],MirEles.Eles[RC].Sel);CaP3:=MirEles.Eles[RC].ECR;
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
//------------------------------------------------------------------------------
for f:=1 to MirObjs.KolO do if not MirObjs.OBJS[f].DEL then
I_DrObject(MirObjs.OBJS[f],IntToCol(f));
glReadPixels(MouD.X,ClientHeight-MouD.Z, 1, 1,GL_RGB,GL_UNSIGNED_BYTE,@RC);
if (RC>0) and (RC<=MirObjs.KolO) then begin
MirObjs.Objs[RC].Sel:=not MirObjs.Objs[RC].Sel;
I_SetSel(MirObjs.Objs[RC],MirObjs.Objs[RC].Sel);CaP3:=MirObjs.Objs[RC].ECR;
end;
glClearColor(0.0,0.0,0.0,1);// Указываем цвет очистки экрана
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
//------------------------------------------------------------------------------
end;
procedure I_EDITDRAW;
var f:Longint;
Begin // Отрисовка редактора

// Отрисовываю все вершины в игровом мире
for f:=1 to MirVers.KolV do if not MirVers.VERS[f].DEL then
if Not MirVers.VERS[f].SEL
then I_DrVertex(MirVers.VERS[f],CreRCol(0,0,0,255))
else I_DrVertex(MirVers.VERS[f],RanRcol);

// Отрисовываю все Плоскости в игровом мире
for f:=1 to MirPlos.KolP do if not MirPlos.PLOS[f].DEL then
if Not MirPlos.PLOS[f].SEL
then I_DrPlos(MirPlos.PLOS[f],CreRCol(0,0,0,255))
else I_DrPlos(MirPlos.PLOS[f],RanRcol);

// Отрисовываю все элементы  в игровом мире
for f:=1 to MirEles.KolE do if not MirEles.ELES[f].DEL then
if Not MirEles.ELES[f].SEL
Then I_DrElement(MirEles.ELES[f],CreRCol(0,0,0,255))
else I_DrElement(MirEles.ELES[f],RanRcol);

// Отрисовываю все ОБьекты в игровом мире
for f:=1 to MirObjs.KolO do if not MirObjs.OBJS[f].DEL then
if Not MirObjs.OBJS[f].SEL
then  I_DrObject(MirObjs.OBJS[f],CreRCol(0,0,0,255))
else  I_DrObject(MirObjs.OBJS[f],RanRCol)

end;


procedure I_ClearScena;// Очищает Сцену
var f:Longint;
begin
 G_Change:=true;
 for f:=1 to MirObjs.KolO do I_DelObject(MirObjs.OBJS[f]);
 G_FileName:='';
end;
procedure I_SaveScena(iNamFile:Ansistring);// Сохраняет сцену
begin
 G_Change:=false;
end;

{%EndRegion}
var   {Паралельные процесы    ===========================}{%Region /FOLD }
                                                           Reg12:Longint;
function  Math(Par:Pointer):DWORD;stdcall;// Вычисление
var F,K2:Longint;
begin
   SetThreadPriority(GetCurrentThread,THREAD_PRIORITY_LOWEST);
   while Clos=false do begin
     sleep(300);MirObjs.Ras;
     for f:=1 to MirObjs.KolO do
     MirObjs.OBJS[f].O_MATH;
     // ========================================================================
     with MirVers do for f:=1 to KOlV do
     if   not Vers[f].DEL then
     with Vers[f] do begin
     ECOO1[f]:=ECR;
     ECOL1[f]:=Col;
     end;
     // ========================================================================
     K2:=0;sleep(300);
     with MirPlos do for f:=1 to KolP do
     if   not Plos[f].DEL then
     with Plos[f] do begin
     K2:=K2+1;
     EPlo1[K2].VERS[1]:=Vers[1].Nom;
     EPlo1[K2].VERS[2]:=Vers[2].Nom;
     EPlo1[K2].VERS[3]:=Vers[3].Nom;
     EPlo1[K2].VERS[4]:=Vers[3].Nom;
     EPlo1[K2].VERS[5]:=Vers[4].Nom;
     EPlo1[K2].VERS[6]:=Vers[1].Nom;
     end;
     MirPLos.Kol2:=K2;sleep(300);
     // ========================================================================
     with MirVers do Move(ECoo1,ECoo2,(KolV+1)*SizeOf(RCS3));
     with MirVers do Move(ECol1,ECol2,(KolV+1)*SizeOf(RCOL));
     with MirPlos do Move(EPlo1,EPlo2,(Kol2+0)*SizeOf(RPLO));
     // ========================================================================
   end;
   result:=0;
end;

{%EndRegion}
var   {Нажатие по экрану      ===========================}{%Region /FOLD }
                                                           Reg13:Longint;

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

        CaP3:=OpredelitCoo(
               MouD.X,
               form3.ClientHeight-MouD.Z,
               iver1,
	       iver2,
	       iver3,
	       iver4,
	       16
	       );CaP3.Y:=CaP3.Y;
end;
end;

{%EndRegion}
var   {Таймеры                ===========================}{%Region /FOLD }
                                                           Reg14:Longint;

procedure TForm3.Timer1Timer(Sender: TObject);// Запускатор
var
x,z:RINT;
begin
Timer1.enabled:=false;// Отключаем запускатор

  GFon:=CreRCol(150,150,250,255);// Формируем цвет фона
  MirVers:=TVERS.Create;// Создаем списки вершин
  MirPlos:=TPLOS.Create;// Создаем списки плоскостей
  MirEles:=TELES.Create;// Создаем списки элементов
  MirObjs:=TOBJS.Create;// Создаем списки Обьектов
  MirSels:=TSELS.Create;// Создаем Буфер обмена
  // Отдельный поток для расчета координат всех вершин
  HMath:=CreateThread(nil,0,@Math,nil,0,HMathTrId);
  // OpenGl настройки
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_Blend);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glEnableClientState(GL_COLOR_ARRAY);
  glEnableClientState(GL_VERTEX_ARRAY);
  GlPointSize(10);// размер точек
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
  glDrawElements(GL_TRIANGLES,MirPlos.Kol2*6,GL_UNSIGNED_INT,@MirPlos.EPlo2[1]);
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
if (KolKAdVsek<33) and (Timer2.interval>1 ) then Timer2.interval:=Timer2.interval-1;
KolKAdVsek:=0;
end;

{%EndRegion}
var   {События формы          ===========================}{%Region /FOLD }
                                                           Reg15:Longint;
procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  halt;
end;



procedure TForm3.OpenGLControl1Resize(Sender: TObject);
begin
  glViewport  (0, 0, OpenGLControl1.Width, OpenGLControl1.Height);// Указываем размер области в котрой рисуем
  glMatrixMode(GL_PROJECTION);// Указываем матрицу с котрой будем работать
  glLoadIdentity;// Сброс в еденичную матрицу
  gluPerspective(60, OpenGLControl1.Width / OpenGLControl1.Height,0.02,MAxRAsInMir);// Устанвока перспективы (Угол обзора в градусах,Соотношение сторон ,Ближний предел ,дальний предел )
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




