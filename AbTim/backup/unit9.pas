unit Unit9; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,unit3, Types;
type

  { TForm9 }

  TForm9 = class(TForm)
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit3Change(Sender: TObject);
    procedure Edit3DblClick(Sender: TObject);
    procedure Edit3MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit3MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit5DblClick(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit7DblClick(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
  private

  public
  LIN:pointer;
  ELE:pointer;
  procedure U_RefreshLin;
  end;

var
  Form9: TForm9;


procedure U_OpenLine(iLin,iEle:Pointer);
function  I_FindFormLin(iLin:Pointer):Tform9;// Ищим форму с вершиной
implementation {$R *.lfm}
procedure U_OpenLine(iLin,iEle:Pointer);
var lForm9:TForm9;
begin
  If I_FindFormLin(iLin)=Nil then begin
  lForm9:=TForm9.Create(application);
  lForm9.Visible:=True;
  lForm9.Lin:=iLin;
  lForm9.Ele:=iEle;
  lForm9.U_RefreshLin;
  end else I_FindFormLin(iLin).SetFocus;
end;
function  I_FindFormLin(iLin:Pointer):Tform9;// Ищим форму с вершиной
var Rez:Tform9;f:Longint;
begin
Rez:=Nil;
for f:=0 to application.ComponentCount-1 do
if  (application.Components[f] is tform9) then
if  (application.Components[f] as tform9).visible then
if ((application.Components[f] as tform9).LIN=iLin) then
     REz:=application.Components[f] as tform9;
I_FindFormLin:=Rez;
end;
procedure TForm9.U_RefreshLin;
begin
I_GetN(Lin,Edit1);
I_GetC(Lin,Edit3);
I_GetA(Lin,Edit4);
end;
procedure TForm9.Edit1Change(Sender: TObject);
begin
  I_SetN(Lin,Edit1);
end;
procedure TForm9.Edit2Change(Sender: TObject);
begin
end;
procedure TForm9.Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-GStep);
    if inFloat(TEdit(Sender).Text)<1 then TEdit(Sender).Text:='3';
end;
procedure TForm9.Edit2MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+GStep);
    if inFloat(TEdit(Sender).Text)>3 then TEdit(Sender).Text:='1';
end;
procedure TForm9.Edit3Change(Sender: TObject);
begin
  I_SetC(Lin,Edit3);
end;
procedure TForm9.Edit3DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  TEdit(sender).Color:=ColorDialog1.Color;
  TEdit(sender).Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm9.Edit3MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-1);
end;
procedure TForm9.Edit3MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
    TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+1);
end;
procedure TForm9.Edit4Change(Sender: TObject);
begin
  I_SetA(Lin,Edit4);
end;
procedure TForm9.Edit5Change(Sender: TObject);
begin
end;
procedure TForm9.Edit5DblClick(Sender: TObject);
begin
end;
procedure TForm9.Edit6Change(Sender: TObject);
begin
end;
procedure TForm9.Edit7Change(Sender: TObject);
begin
end;
procedure TForm9.Edit7DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  edit7.Color:=ColorDialog1.Color;
  edit7.Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm9.Edit8Change(Sender: TObject);
begin
end;
end.

