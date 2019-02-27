unit Unit8; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Types,unit3;
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
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit5DblClick(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
  private

  public
  Ver:Pointer;
  Ele:Pointer;
  end;

var
  Form8: TForm8;

procedure U_OpenPoints(iVer,iEle:Pointer);
implementation {$R *.lfm} { TForm8 }
procedure U_OpenPoints(iVer,iEle:Pointer);
var lForm8:TForm8;
begin

  lForm8:=TForm8.Create(application);
  lForm8.Visible:=True;
  lForm8.Ver:=iVer;
  lForm8.Ele:=iEle;
  I_GetN(iVer,lForm8.Edit1);
  I_GetX(iVer,lForm8.Edit2);
  I_GetY(iVer,lForm8.Edit3);
  I_GetZ(iVer,lForm8.Edit4);
  I_GetCol(iVer,lForm8.Edit5);
  I_GetAlp(iVer,lForm8.Edit6);

end;
procedure TForm8.Edit2MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-GStep);
end;
procedure TForm8.Edit1Change(Sender: TObject);
begin

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
   I_SetCol(Ver,Edit5);
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
  I_SetAlp(Ver,Edit6);// Устанавливает прозрачность
end;



end.

