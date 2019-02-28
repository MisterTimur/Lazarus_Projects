unit Unit4;{$mode objfpc}{$H+}interface uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, StdCtrls, Menus,UNit5,unit3;
type

  { TForm4 }

  TForm4 = class(TForm)
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    FontDialog1: TFontDialog;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
  private

  public
  Sel:Pointer;
  end;
var Form4: TForm4;
implementation{$R *.lfm}{ TForm4 }
procedure TForm4.MenuItem5Click(Sender: TObject);
begin
   Tform5.create(application).show;
   MenuItem5.Enabled:=false;
end;
procedure TForm4.FormCreate(Sender: TObject);
begin
  Sel:=nil;
  left:=form3.Left+form3.width-width-30;
  top:=form3.top+form3.height-height-10;
end;
end.

