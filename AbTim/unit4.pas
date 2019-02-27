unit Unit4;{$mode objfpc}{$H+}interface uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, StdCtrls,UNit5;
type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;
var Form4: TForm4;
implementation{$R *.lfm}{ TForm4 }
procedure TForm4.Button1Click(Sender: TObject);
begin
  Tform5.create(application).show;
  button1.Visible:=false;
end;
end.

