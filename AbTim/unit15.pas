unit Unit15; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;
type { TForm15 } TForm15 = class(TForm)
    Memo1: TMemo;
    Panel1: TPanel;
  private

  public
  procedure PRI(iStr:Ansistring);
  end;
var Form15: TForm15;
implementation {$R *.lfm}
procedure TForm15.PRI(iStr:Ansistring);
begin
memo1.lines.add(iStr);
end;

end.

