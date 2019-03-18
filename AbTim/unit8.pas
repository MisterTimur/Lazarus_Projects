unit Unit8; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus, Types,unit3;
type

  { TForm8 }

  TForm8 = class(TForm)
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    PopupMenu1: TPopupMenu;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit5DblClick(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private

  public
  Ver:Pointer;
  rEle:Pointer;
  MHeight:Longint;
  procedure U_RefreshVer;
  end;

var
  Form8: TForm8;

procedure U_OpenPoint(iVer,irEle:Pointer);// Создает форму с вершиной
function  I_FindFormVer(iVer:Pointer):Tform8;// Ищим форму с вершиной
implementation {$R *.lfm} { TForm8 }
procedure U_OpenPoint(iVer,irEle:Pointer);
var lForm8:TForm8;
begin
  If I_FindFormVer(iVer)=Nil then begin
  lForm8:=TForm8.Create(application);
  lForm8.Visible:=True;
  lForm8.Ver:=iVer;
  lForm8.rEle:=irEle;
  lForm8.U_RefreshVer;
  end else I_FindFormVer(iVer).SetFocus;
end;
function  I_FindFormVer(iVer:Pointer):Tform8;// Ищим форму с вершиной
var Rez:Tform8;f:Longint;
begin
Rez:=Nil;
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform8) then
if  (application.Components[f] as tform8).visible then
if ((application.Components[f] as tform8).VER=iVer) then
     REz:=application.Components[f] as tform8;
I_FindFormVer:=Rez;
end;
procedure TForm8.U_RefreshVer;
begin
I_GetN(Ver,Edit1);
I_GetX(Ver,Edit2);
I_GetY(Ver,Edit3);
I_GetZ(Ver,Edit4);
I_GetC(Ver,Edit5);
I_GetA(Ver,Edit6);
end;
procedure TForm8.Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-GStep);
end;
procedure TForm8.Edit1Change(Sender: TObject);
begin
  I_SetN(Ver,Edit1);
end;
procedure TForm8.Edit2Change(Sender: TObject);
begin
  I_SetX(Ver,Edit2);
end;
procedure TForm8.Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+GStep);
end;
procedure TForm8.Edit3Change(Sender: TObject);
begin
  I_SetY(Ver,Edit3);
end;
procedure TForm8.Edit4Change(Sender: TObject);
begin
  I_SetZ(Ver,Edit4);
end;
procedure TForm8.Edit5Change(Sender: TObject);
begin
   I_SetC(Ver,Edit5);
end;
procedure TForm8.Edit5DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  edit5.Color:=ColorDialog1.Color;
  edit5.Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm8.Edit6Change(Sender: TObject);
begin
  I_SetA(Ver,Edit6);// Устанавливает прозрачность
end;
procedure TForm8.FormCreate(Sender: TObject);
begin
  MHeight:=Height;
  caption:='Vertex';
  left:=OknoWidth(form3.left+form3.Width-width-10);
  top:=OknoHeight(form3.top+form3.height-height-50);
end;
procedure TForm8.MenuItem1Click(Sender: TObject);
begin
   I_AddVerCOp(Ver);
end;
procedure TForm8.MenuItem2Click(Sender: TObject);
begin
   I_AddVerSYX(Ver);
end;
procedure TForm8.MenuItem3Click(Sender: TObject);
begin
   I_AddVerSYY(Ver);
end;
procedure TForm8.MenuItem4Click(Sender: TObject);
begin
   I_AddVerSYZ(Ver);
end;
procedure TForm8.MenuItem5Click(Sender: TObject);
begin
   I_AddVer150(Ver);
end;
procedure TForm8.Panel1Click(Sender: TObject);
begin
  if Height=panel1.height then begin
  Top:=Top-(MHeight-height);
  Height:=mHeight;
  end
  else begin
  MHeight:=Height;
  Height:=panel1.height;
  Top:=Top+MHeight-height;
  end;
end;
end.

