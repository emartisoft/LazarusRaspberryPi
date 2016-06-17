unit main;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, h2wiringpi;

{ TForm1 }

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Shape1: TShape;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Enabled := false;

  wiringPiSetup;
  pinMode(8, INPUT);
  pinMode(7, OUTPUT);

  pullUpDnControl(8, PUD_DOWN); // wiringPi 8 Pull Down

  digitalWrite(7, LOW); // led is off

  label3.Caption := 'Device Info: ' + piboardtostr(); // device info
  Timer1.Enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  pinvalue:longint;
begin
  pinvalue:= digitalRead(8);
  if pinvalue = LOW then
    begin
  	label1.Caption := 'Button pressed and LED is ON and wiringPi8 Pin is '+ IntToStr(pinvalue);
    digitalWrite(7, HIGH);

    Shape1.Brush.Color:= clLime;
    end
  else
  	begin
    label1.Caption:= 'Button not pressed and LED is OFF and wiringPi8 Pin is '+ IntToStr(pinvalue);
    digitalWrite(7, LOW);
    Shape1.Brush.Color:= clGray;
    end;

end;

end.

