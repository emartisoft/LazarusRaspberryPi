unit main;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, h2wiringpi;

{ TForm1 }

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Shape1: TShape;
    Shape10: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    function ReadPhotoCellValue(pin: integer): integer;
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  g: integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Enabled := true;
  Button1.Enabled := false;
  g:= 0;
  wiringPiSetup;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  pcValue, gh: integer;
begin
  // for wiringPi 7
  pcValue := ReadPhotoCellValue(7);
  Label1.Caption := 'Instant Readed PhotoCell Value: ' + IntToStr(pcValue);
  inc(g);
  gh:= 200 * pcValue div 10000;

  case g mod 10 of
  0: begin
  		Shape1.Height := gh;
      Shape1.Top := 205 - gh;
     end;
  1: begin Shape2.Height := gh; Shape2.Top := 205 - gh; end;
  2: begin Shape3.Height := gh; Shape3.Top := 205 - gh; end;
  3: begin Shape4.Height := gh; Shape4.Top := 205 - gh; end;
  4: begin Shape5.Height := gh; Shape5.Top := 205 - gh; end;
  5: begin Shape6.Height := gh; Shape6.Top := 205 - gh; end;
  6: begin Shape7.Height := gh; Shape7.Top := 205 - gh; end;
  7: begin Shape8.Height := gh; Shape8.Top := 205 - gh; end;
  8: begin Shape9.Height := gh; Shape9.Top := 205 - gh; end;
  9: begin Shape10.Height := gh; Shape10.Top := 205 - gh; end;
  end;
end;

function TForm1.ReadPhotoCellValue(pin: integer): integer;
var
  counter: integer;
begin
  counter := 0;
  pinMode(pin, OUTPUT);
  digitalWrite(pin, LOW);
  delay(100);
  pinMode(pin, INPUT);

  repeat
    inc(counter);
  until (digitalRead(pin) = HIGH);

  result:= counter;
end;

end.

