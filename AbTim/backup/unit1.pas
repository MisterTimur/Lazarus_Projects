unit Unit1; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,unit3;
type { TForm1 } TForm1 = class(TForm)
    Label1: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private

  public

  end;
var Form1: TForm1;
implementation
{$R *.lfm}
{ TForm1 }
procedure TForm1.Timer1Timer(Sender: TObject);
begin

  timer1.Enabled:=false; // Отключаем таймер формы 1
  form3.Visible:=true;// Делаем вимой форму отрисовки
  form4.Visible:=true;// Инструменты редактирования
  form1.Visible:=false;// Скрываем стартовую форму
  form3.timer1.Enabled:=true;// Запускаем запускатор формы 4

end;

end.

