unit Unit4; {$mode objfpc}{$H+} interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, CheckLst, Menus,unit3;
type
{ TForm4 }
 TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckListBox3: TCheckListBox;
    CheckListBox4: TCheckListBox;
    CheckListBox5: TCheckListBox;
    CheckListBox6: TCheckListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    PopupMenu4: TPopupMenu;
    PopupMenu5: TPopupMenu;
    PopupMenu6: TPopupMenu;
    Splitter1: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
  private

  public

  end;
var Form4: TForm4;
implementation
{$R *.lfm}
{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  CheckListBox3.Align:=alClient;
  CheckListBox3.Visible:=true;
  CheckListBox4.Visible:=false;
  CheckListBox5.Visible:=false;
  CheckListBox6.Visible:=false;
end;
procedure TForm4.Button2Click(Sender: TObject);
begin
  CheckListBox3.Visible:=false;
  CheckListBox4.Align:=alClient;
  CheckListBox4.Visible:=true;
  CheckListBox5.Visible:=false;
  CheckListBox6.Visible:=false;
end;
procedure TForm4.Button3Click(Sender: TObject);
begin
  CheckListBox3.Visible:=false;
  CheckListBox4.Visible:=false;
  CheckListBox5.Align:=alClient;
  CheckListBox5.Visible:=true;
  CheckListBox6.Visible:=false;
end;
procedure TForm4.Button4Click(Sender: TObject);
begin
  CheckListBox3.Visible:=false;
  CheckListBox4.Visible:=false;
  CheckListBox5.Visible:=false;
  CheckListBox6.Align:=alClient;
  CheckListBox6.Visible:=true;
end;

procedure TForm4.MenuItem7Click(Sender: TObject);// Добавить обьект
begin
  I_NewObject;
end;
procedure TForm4.MenuItem8Click(Sender: TObject);// удалить обьект
begin
  if CheckListBox6.itemindex<CheckListBox6.items.count then
  if CheckListBox6.itemindex>0 then
  i_DelObject(CheckListBox6.items.objects[CheckListBox6.itemindex]);
end;

end.

