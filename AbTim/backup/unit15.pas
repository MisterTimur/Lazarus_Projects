unit Unit15; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;
type { TForm15 } TForm15 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private

  public
  MHeight:Longint;
  procedure PRI(iStr:Ansistring);
  end;
var Form15: TForm15;
implementation {$R *.lfm} uses unit3;
procedure TForm15.Edit1Change(Sender: TObject);
begin

end;
procedure TForm15.FormCreate(Sender: TObject);
begin
  MHeight:=height;
end;
procedure TForm15.Panel1Click(Sender: TObject);
begin
  if Height=panel1.height then begin
  Height:=mHeight;
  end
  else begin
  MHeight:=Height;
  Height:=panel1.height;
  end;
end;
procedure TForm15.PRI(iStr:Ansistring);
begin
memo1.lines.add(iStr);
end;
end.

