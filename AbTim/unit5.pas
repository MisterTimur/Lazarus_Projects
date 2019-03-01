unit Unit5;{$mode objfpc}{$H+}interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, Menus,Unit3,unit6,unit7,unit8, StdCtrls;
type

  { TForm5 }

  TForm5 = class(TForm)
    CheckListBox1: TCheckListBox;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    procedure CheckListBox1DblClick(Sender: TObject);
    procedure CheckListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
  mHeight:longint;
  end;

var
  Form5: TForm5;

procedure U_OpenObjects();
implementation {$R *.lfm} { TForm5 }uses unit4;
procedure U_OpenObjects();
var
  lForm5:TForm5;
begin
 lForm5:=Tform5.create(application);
 lForm5.visible:=true;
 I_RefSpiObjs(lForm5.CheckListBox1);
end;

procedure TForm5.MenuItem1Click(Sender: TObject);
begin
  I_NewObj;
  I_RefSpiObjs(CheckListBox1);
end;
procedure TForm5.MenuItem2Click(Sender: TObject);
var f:Longint;
begin

  if CheckListBox1.itemindex<CheckListBox1.items.count then
  if CheckListBox1.itemindex>0 then begin
  i_DelObj(CheckListBox1.items.objects[CheckListBox1.itemindex]);
  I_RefSpiObjs(CheckListBox1);
  end;

end;
procedure TForm5.Panel1Click(Sender: TObject);
begin
  if Height=panel1.height then begin
  Height:=mHeight;
  end
  else begin
  MHeight:=Height;
  Height:=panel1.height;
  end;
end;
procedure TForm5.Panel1DblClick(Sender: TObject);
begin

end;
procedure TForm5.Timer1Timer(Sender: TObject);
begin
end;
procedure TForm5.CheckListBox1DblClick(Sender: TObject);
begin
  if CheckListBox1.itemindex<CheckListBox1.items.count then
  if CheckListBox1.itemindex>0 then
  U_OpenObject(CheckListBox1.items.objects[CheckListBox1.itemindex]);
end;
procedure TForm5.CheckListBox1SelectionChange(Sender: TObject; User: boolean);
var F:Longint;
begin
 for f:=1 to CheckListBox1.items.Count-1 do
 I_SetSel(CheckListBox1.items.objects[f],CheckListBox1.Selected[f])
end;
procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  form4.MenuItem5.Enabled:=true;
end;
procedure TForm5.FormCreate(Sender: TObject);
begin
  mHeight:=Height;
  left:=form3.left+form3.width-width-10;
  top :=form3.top+30;
end;
end.

