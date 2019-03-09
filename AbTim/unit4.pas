unit Unit4;{$mode objfpc}{$H+}interface uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  CheckLst, StdCtrls, Menus,UNit5,unit3, Types;
type { TForm4 } TForm4 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox4: TCheckBox;
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
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
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    Splitter8: TSplitter;
    Splitter9: TSplitter;
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure Edit10DblClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit1MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Edit6Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit7DblClick(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem30Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public
  Act:Pointer;// Активный элемент в данный момент времени в редакторе
  end;
var Form4: TForm4;
implementation{$R *.lfm}{ TForm4 }
procedure TForm4.MenuItem5Click(Sender: TObject);
begin
   U_OpenObjects();
   MenuItem5.Enabled:=false;
end;
procedure TForm4.MenuItem6Click(Sender: TObject);
begin
  MenuItem6.Checked:=not MenuItem6.Checked;
end;
procedure TForm4.MenuItem8Click(Sender: TObject);
begin
  MenuItem8.Checked:=not MenuItem8.Checked;
end;
procedure TForm4.MenuItem9Click(Sender: TObject);
begin
  MenuItem9.Checked:=not MenuItem9.Checked;
end;
procedure TForm4.FormCreate(Sender: TObject);
begin
  Act:=nil;
  //left:=0;//form3.Left+form3.width-width-30;
  //top:=0;//form3.top+form3.height-height-10;
end;
procedure TForm4.MenuItem10Click(Sender: TObject);
begin
 MenuItem10.Checked:=not MenuItem10.Checked;
end;
procedure TForm4.MenuItem12Click(Sender: TObject);
begin
   MenuItem12.Checked:=not MenuItem12.Checked;
end;
procedure TForm4.MenuItem13Click(Sender: TObject);
begin
   MenuItem13.Checked:=not MenuItem13.Checked;
end;
procedure TForm4.MenuItem14Click(Sender: TObject);
begin
   MenuItem14.Checked:=not MenuItem14.Checked;
end;
procedure TForm4.MenuItem16Click(Sender: TObject);
begin
  MenuItem16.Checked:=not MenuItem16.Checked;
end;
procedure TForm4.MenuItem17Click(Sender: TObject);// Новый проект
var lOtv:TModalResult;
begin
 if G_Change then begin   // если есть изменения в сцене
 lOtv:=MessageDlg('Создать новый проект ?', 'Сохраняить текущию сцену',
               mtConfirmation,[mbYes, mbNo, mbCancel],0);
 if lOtv = mrNo  then begin I_ClearScena;G_Change:=false; end else
 if lOtv = mrYes then begin
 MenuItem19Click(sender);
 I_ClearScena ;
 G_Change:=false;
 end
 end else I_ClearScena;// если изменения все сохранены
end;
procedure TForm4.MenuItem18Click(Sender: TObject);// Открыть сцену
var lOtv:TModalResult;
begin
 if G_Change then begin   // если есть изменения в сцене
 lOtv:=MessageDlg('Открыть новую сцену', 'Сохраняить текущию сцену ?',
 mtConfirmation,[mbYes, mbNo, mbCancel],0);
   if lOtv = mrNo  then begin
                      if OpenDialog1.Execute then begin
                      G_FileName:=OpenDialog1.FileName;
                      I_LoadScena(G_FileName);
                      end;
   end;
   if lOtv = mrYes then begin
                      MenuItem19Click(sender);// Сохранение проекта
                      if G_Change=false then
                      if OpenDialog1.Execute then begin
                      G_FileName:=OpenDialog1.FileName;
                      I_LoadScena(G_FileName);
                      end;
    // Отмена действия
   end end
   else begin
                      if OpenDialog1.Execute then begin
                      G_FileName:=OpenDialog1.FileName;
                      I_LoadScena(G_FileName);
                      end;
 end;
// Выход -----------------------------------------------------------------------
end;
procedure TForm4.MenuItem19Click(Sender: TObject);// Сохраняет сцену
begin
  if G_FileName<>'' Then I_SaveScena(G_FileName) else
  if SaveDialog1.Execute then begin
     G_FileName:=SaveDialog1.FileName;
     I_SaveScena(G_FileName);
  end;
end;
procedure TForm4.MenuItem20Click(Sender: TObject);// Сохранить как
begin
  if SaveDialog1.Execute then begin
     G_FileName:=SaveDialog1.FileName;
     I_SaveScena(G_FileName);
     G_Change:=false;
  end;
end;
procedure TForm4.MenuItem21Click(Sender: TObject);// Выход из программы
var
  lOtv:TModalResult;
begin
 if G_Change then begin   // если есть изменения в сцене
 lOtv:=MessageDlg('Закрытие программы', 'Сохраняить текущию сцену',
               mtConfirmation,[mbYes, mbNo, mbCancel],0);
 if lOtv = mrNo  then I_ClearScena else
 if lOtv = mrYes then begin
 MenuItem19Click(sender);
 Halt ;
 end
 end else Halt;// если изменения все сохранены
end;
procedure TForm4.MenuItem22Click(Sender: TObject);
begin
  MenuItem22.Checked:=not MenuItem22.Checked;
end;
procedure TForm4.MenuItem23Click(Sender: TObject);
begin
  I_AddVerCOp(Act);
end;
procedure TForm4.MenuItem24Click(Sender: TObject);
begin
   I_AddVerSYX(Act);
end;
procedure TForm4.MenuItem25Click(Sender: TObject);
begin
   I_AddVerSYZ(Act);
end;
procedure TForm4.MenuItem26Click(Sender: TObject);
begin
  I_AddVer150(Act);
end;
procedure TForm4.MenuItem27Click(Sender: TObject);
begin
  I_AddVni150(Act);
end;
procedure TForm4.MenuItem28Click(Sender: TObject);
begin
  I_AddVerMar(Act);
end;
procedure TForm4.MenuItem29Click(Sender: TObject);
begin
  I_DelNotUseVer;
end;
procedure TForm4.MenuItem30Click(Sender: TObject);
begin
 I_AddVerLan(Act) ;
end;
procedure TForm4.MenuItem31Click(Sender: TObject);
begin
   MenuItem31.Checked:=not MenuItem31.Checked;
end;
procedure TForm4.Edit1Change(Sender: TObject);
begin
  I_SetX(Act,Edit1);
end;
procedure TForm4.CheckBox1Change(Sender: TObject);
begin
 I_Set_MBUT(CheckBox1.Checked);
end;
procedure TForm4.CheckBox4Change(Sender: TObject);
begin
 if CheckBox4.Checked
 then begin
 MenuItem6.Checked:=false;
 MenuItem8.Checked:=false;
 MenuItem9.Checked:=false;
 MenuItem10.Checked:=true;
 MenuItem12.Checked:=true;
 MenuItem13.Checked:=true;
 MenuItem22.Checked:=true;
 MenuItem14.Checked:=true;
 MenuItem31.Checked:=true;
 MenuItem16.Checked:=true;
 end
 else begin
 MenuItem6.Checked:=true;
 MenuItem8.Checked:=true;
 MenuItem9.Checked:=true;
 MenuItem10.Checked:=false;
 MenuItem12.Checked:=false;
 MenuItem13.Checked:=false;
 MenuItem22.Checked:=false;
 MenuItem14.Checked:=false;
 MenuItem31.Checked:=false;
 MenuItem16.Checked:=false;
 end;
end;
procedure TForm4.Edit10DblClick(Sender: TObject);
begin
  if edit10.TExt='0' then edit10.TExt:='-1' else edit10.TExt:='0';
  I_SETM(Act,edit10);
end;
procedure TForm4.Edit1MouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   if isFloat(TEdit(Sender).text) then
   TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)-GStep);
end;
procedure TForm4.Edit1MouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   if isFloat(TEdit(Sender).text) then
   TEdit(Sender).text:= InString(inFloat(TEdit(Sender).Text)+GStep);
end;
procedure TForm4.Edit2Change(Sender: TObject);
begin
 I_SetY(Act,Edit2);
end;
procedure TForm4.Edit3Change(Sender: TObject);
begin
 I_SetZ(Act,Edit3);
end;
procedure TForm4.Edit4Change(Sender: TObject);
begin
 I_SeUX(Act,Edit4);
end;
procedure TForm4.Edit5Change(Sender: TObject);
begin
 I_SeUY(Act,Edit5);
end;
procedure TForm4.Edit6Change(Sender: TObject);
begin
 I_SeUZ(Act,Edit6);
end;
procedure TForm4.Edit7Change(Sender: TObject);
begin
 I_SetC(Act,Edit7);
end;
procedure TForm4.Edit7DblClick(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  edit7.Color:=ColorDialog1.Color;
  edit7.Text:=intToStr(ColorDialog1.Color);
  end;
end;
procedure TForm4.Edit8Change(Sender: TObject);
begin
 I_SetA(Act,Edit8);
end;
procedure TForm4.Edit9Change(Sender: TObject);
begin
 I_SetN(Act,Edit9);
end;

end.




