unit ScanPort;
{
  Port Scan Module

  Added SercanTEK
  03.09.2018
  DelphiCan Team
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    ScanPortList: TStringGrid;
    FindPortEdit: TEdit;
    Label1: TLabel;
    FindButton: TButton;
    DetailCheck: TCheckBox;
    protocolCount: TPanel;
    procedure FindButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FindPortEditKeyPress(Sender: TObject; var Key: Char);
    procedure FindPortEditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FindPortEditExit(Sender: TObject);
    procedure FindPortEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListOptions(var List:TStringgrid);
    procedure ListAdd(var List:TStringgrid;App,AppPid,IPprotocol,Sport,DPort:string);
    procedure ListReSize(var List:Tstringgrid);
    function  ListPIDDoList(List:TStringGrid;AppPid,IPProtocol,SPort,DPort:string):boolean;
    function  ListProtoColCount(List:TStringGrid;IPProtocol:string):integer;
  end;

var
  Form2: TForm2;

const

  APPNAME     = 0;
  APPPPID     = 1;
  PROTOCOL    = 2;
  SOURCE      = 3;
  DESTINATION = 4;

  PORTSTRING  = 'TCP/UDP : 1 .. 65535';

implementation
          uses main;
{$R *.dfm}

procedure EditStyleitalic(var PEdit : TEdit);
begin
   PEdit.Font.Style:=(PEdit.Font.Style + [fsitalic]);
   PEdit.Font.Color:= clgray;
end;

procedure EditStyleStandart(var PEdit : TEdit);
begin
   PEdit.Font.Style:=(PEdit.Font.Style - [fsitalic]);
   PEdit.Font.Color:= clDefault;
end;

function TForm2.ListPIDDoList(List:TStringGrid;AppPid,IPProtocol,SPort,DPort:string):boolean;
var
 _Row:integer;
Begin
 if Trim(AppPid) <> '' then
   begin
     For _Row:= 1 To List.RowCount-1 Do
      Begin
       if (Trim(List.Cells[APPPPID,_Row])  = Trim(AppPid)) and (Trim(List.Cells[PROTOCOL,_Row]) = Trim(IPProtocol)) and
          ((Trim(List.Cells[SOURCE,_Row]) = Trim(SPort)) or (Trim(List.Cells[DESTINATION,_Row]) = Trim(DPort)))  then
       begin
         result := true;
         exit;
       end;
      End;
      result := false;
   end;
end;

function TForm2.ListProtoColCount(List:TStringGrid;IPProtocol:string):integer;
var
 _Row:integer;
 _Count : integer;
Begin
 if Trim(IPProtocol) <> '' then
   begin
   _Count := 0 ;
     For _Row:= 1 To List.RowCount-1 Do
      Begin
       if (Trim(List.Cells[PROTOCOL,_Row]) = Trim(IPProtocol)) then
       begin
         _Count := _Count + 1 ;
       end;
      End;
    result := _Count;
   end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
ListOptions(ScanPortList);
end;

procedure TForm2.FormResize(Sender: TObject);
begin
ListReSize(ScanPortList);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
FindPortEdit.Text:='';
FindPortEdit.Text:=PORTSTRING;
EditStyleitalic(FindPortEdit);
ListOptions(ScanPortList);
end;

procedure TForm2.ListReSize(var List:Tstringgrid);
begin
  List.ColWidths[APPPPID]      := 80;
  List.ColWidths[PROTOCOL]     := 60;
  List.ColWidths[SOURCE]       := 75;
  List.ColWidths[DESTINATION]  := 100;

  List.ColWidths[APPNAME]  := List.Width - (  List.ColWidths[APPPPID] +
                                              List.ColWidths[PROTOCOL] +
                                              List.ColWidths[SOURCE] +
                                              List.ColWidths[DESTINATION]+10);
end;

procedure TForm2.FindPortEditChange(Sender: TObject);
begin
 EditStyleStandart(FindPortEdit);
end;

procedure TForm2.FindPortEditExit(Sender: TObject);
begin
 if FindPortEdit.Text = '' then
   begin
     FindPortEdit.Text:=PORTSTRING;
     EditStyleitalic(FindPortEdit);
   end;
end;

procedure TForm2.FindPortEditKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #13 then // Enter Key.
     FindButtonClick(self)
  else
   if not (key in ['0'..'9',#8]) then // Number Only !!
     begin
       Key:=#0;
       Beep;
     end;

end;

procedure TForm2.FindPortEditMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if FindPortEdit.Text = PORTSTRING then FindPortEdit.Text:='';
end;

procedure TForm2.ListOptions(var List:TStringgrid);
begin

 List.RowCount := 1;
 List.ColCount := 5;

 List.FixedCols := 0;
 List.FixedRows := 0;

 List.Cells[APPNAME,0]     := 'Process Name';
 List.Cells[APPPPID,0]     := 'Process PID';
 List.Cells[PROTOCOL,0]    := 'Protocol';
 List.Cells[SOURCE,0]      := 'Source Port';
 List.Cells[DESTINATION,0] := 'Destination Port';

 ListReSize(List);

end;

procedure TForm2.ListAdd(var List:TStringgrid;App,AppPid,IPprotocol,Sport,DPort:string);
var
 ListRowAdd : integer;
begin
   if trim(App) <> '' then
   begin
     if DetailCheck.Checked then // Detail List
       begin
        ListRowAdd    := List.RowCount;
        List.RowCount := List.RowCount + 1;
        List.Cells[APPNAME, ListRowAdd]     := App;
        List.Cells[APPPPID, ListRowAdd]     := AppPid;
        List.Cells[PROTOCOL, ListRowAdd]    := IPprotocol;
        List.Cells[SOURCE, ListRowAdd]      := Sport;
        List.Cells[DESTINATION, ListRowAdd] := DPort;
       end
        else
       begin
        if not ListPIDDoList(List,AppPid,IPprotocol,Sport,Dport) then
          begin
           ListRowAdd    := List.RowCount;
           List.RowCount := List.RowCount + 1;
           List.Cells[APPNAME, ListRowAdd]     := App;
           List.Cells[APPPPID, ListRowAdd]     := AppPid;
           List.Cells[PROTOCOL, ListRowAdd]    := IPprotocol;

           if Sport = FindPortEdit.Text then
              List.Cells[SOURCE, ListRowAdd]      := Sport
              else
              List.Cells[SOURCE, ListRowAdd]      := '-';

           if Dport = FindPortEdit.Text then
              List.Cells[DESTINATION, ListRowAdd] := DPort
              else
              List.Cells[DESTINATION, ListRowAdd] := '-';


          end;
       end;
   end;

end;

procedure TForm2.FindButtonClick(Sender: TObject);
begin

 if (FindPortEdit.Text <> '') and (FindPortEdit.Text<>PORTSTRING) then
 begin
   ListOptions(ScanPortList);
   Form1.TCPPortFind(FindPortEdit.Text,ScanPortList);
   Form1.UDPPortFind(FindPortEdit.Text,ScanPortList);

   ProtocolCount.Caption := '   TCP : '+inttostr(ListProtoColCount(ScanPortList,'TCP'))+
                            ' - UDP : '+inttostr(ListProtoColCount(ScanPortList,'UDP'));
 end
 else
 begin
    Beep;
    FindPortEdit.SetFocus;
 end;

end;

end.
