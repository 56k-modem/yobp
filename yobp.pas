program YOBP_N51;

{*** Y3 01I)E I30oTuP pR0GgYe I3Y UI\ICI<I_3pHOoCI<Z0r Pr0I)(_)(ty0I/Iz ***}
{VERSION 1.51}

uses crt,dos;

var D_FileName:text;
    InChar,SpecParm,OutChar,CtrlChar:char;
    DelayAmount,GGenLines,AltGGenLines,PauseAmount,G_LDone,G_BlockDone,G_MiscDone,
    D_GBlockCount,D_GBlockLength,D_GBlockSpacing,D_GDelay,D_AGBlockCount,D_AGBlockLength,
    D_AGBlockSpacing,D_AGDelay,D_GCharLimit_Low,D_GCharLimit_High,PauseChange,
    DelayChange,C_GenLines,C_GBlockCount,C_GBlockLength,C_GBlockSpacing,C_GDelay:integer;

    PauseCount: longint;
    ValidityChkStr:string;
    GG_Charmode, GL_LimitReached, AL_LimitReached: boolean;

{DelayAmount counted in 10's - 1 DelayAmount = 10 msec delay}
{PauseAmount counted in 100 K increments - 40 PauseAmount = 40 M cycles}
{D_GDelay,D_AGDelay: msecs}

label D_NotValid, EndR, ParmErrTrap, GnrlReturn, FunctW, Engine, HelpR,BadParm, GarbageGen, CycleBrk,
      G_LnTooLong, Prg_Resume ;

begin

if (ParamStr(1)='-boot') then goto Engine;
if (ParamStr(1)='-help') or (ParamStr(1)='-?') then goto HelpR;

{goto BadParm;}


{****************************************************************************};
Engine:
TextBackground(Black);
TextColor(Green);
clrscr;
randomize;
GL_LimitReached:=False;
AL_LimitReached:=False;


if ParamStr(2)<>'' then begin
assign(D_FileName,ParamStr(2));
end

else begin
assign(D_FileName,'C:\YOBP-N\YOBP-N.DAT');
end;

reset(D_FileName);
read(D_FileName,ValidityChkStr);

if ValidityChkStr<>'*** Ye Olde Boot-Up Proggye Data by UncklePhoockzor Productionz' then goto D_NotValid;
read(D_FileName,DelayAmount,DelayChange);
read(D_FileName,PauseAmount,PauseChange);
read(D_FileName,GGenLines,AltGGenLines);
read(D_FileName,D_GBlockCount,D_GBlockLength,D_GBlockSpacing,D_GDelay);
read(D_FileName,D_AGBlockCount,D_AGBlockLength,D_AGBlockSpacing,D_AGDelay);
read(D_FileName,D_GCharLimit_Low,D_GCharLimit_High);

if GGenLines          <=0 then GGenLines         :=1;
if AltGGenLines       <=0 then AltGGenLines      :=1;
if D_GBlockCount      <=0 then D_GBlockCount     :=1;
if D_GBlockLength     <=0 then D_GBlockLength    :=1;
if D_GBlockSpacing    <=0 then D_GBlockSpacing   :=1;
if D_GDelay           <0 then  D_GDelay          :=0;
if D_AGBlockCount     <=0 then D_AGBlockCount    :=1;
if D_AGBlockLength    <=0 then D_AGBlockLength   :=1;
if D_AGBlockSpacing   <=0 then D_AGBlockSpacing  :=1;
if D_AGDelay          <0 then  D_AGDelay         :=0;
if D_GCharLimit_Low   <=32 then D_GCharLimit_Low  :=32;
if D_GCharLimit_High  >=256 then D_GCharLimit_High :=255;
if PauseChange        <=0 then PauseChange         :=1;
if DelayChange          <=0 then DelayChange         :=1;

if (D_GBlockLength*D_GBlockCount)+((D_GBlockSpacing-1)*D_GBlockCount) >= 80 then GL_LimitReached:=True;
if (D_GBlockLength*D_AGBlockCount)+((D_AGBlockSpacing-1)*D_AGBlockCount) >= 80 then AL_LimitReached:=True;

if (D_GBlockLength*D_GBlockCount)+((D_GBlockSpacing-1)*D_GBlockCount) > 80 then goto G_LnTooLong;
if (D_GBlockLength*D_AGBlockCount)+((D_AGBlockSpacing-1)*D_AGBlockCount) > 80 then goto G_LnTooLong;

Prg_Resume:

while not eof(D_FileName) do
begin

if DelayAmount<0 then DelayAmount:=0;
if PauseAmount<=1 then PauseAmount:=40;


read(D_FileName,InChar);

if InChar='$' then

          begin
               read(D_FileName,SpecParm);

                          case SpecParm of
                                   '$': OutChar:='$';
                                   'l': DelayAmount:=DelayAmount+DelayChange;
                                   'L': if (DelayAmount-DelayChange)>=1 then DelayAmount:=DelayAmount-DelayChange;
                                   'p': PauseAmount:=PauseAmount+PauseChange;
                                   'P': if (PauseAmount-PauseChange)>=1 then PauseAmount:=PauseAmount-PauseChange;
                                   'W': goto FunctW;
                                   '1': TextColor(Blue);
                                   '2': TextColor(Green);
                                   '3': TextColor(Cyan);
                                   '4': TextColor(Red);
                                   '5': TextColor(Magenta);
                                   '6': TextColor(Brown);
                                   '7': TextColor(LightGray);
                                   '8': TextColor(DarkGray);
                                   '9': TextColor(LightBlue);
                                   'A': TextColor(LightGreen);
                                   'B': TextColor(LightCyan);
                                   'C': TextColor(LightRed);
                                   'D': TextColor(LightMagenta);
                                   'E': TextColor(Yellow);
                                   'F': TextColor(White);
                                   'T': TextAttr:=Random(15)+1;
                                   '0': ClrScr;
                                   'S': goto EndR {Ye Fast-Stoppe Functyon'};
                                   'X': begin
                                        C_GenLines:=AltGGenlines;
                                        C_GBlockCount:=D_AGBlockCount ;
                                        C_GBlockLength:=D_AGBlockLength;
                                        C_GDelay:=D_AGDelay;
                                        C_GBlockSpacing:=D_AGBlockSpacing;
                                        GG_Charmode:=True;
                                        goto GarbageGen;
                                        end;
                                   'x': begin
                                        C_GenLines:=AltGGenlines;
                                        C_GBlockCount:=D_AGBlockCount ;
                                        C_GBlockLength:=D_AGBlockLength;
                                        C_GDelay:=D_AGDelay;
                                        C_GBlockSpacing:=D_AGBlockSpacing;
                                        GG_Charmode:=False;
                                        goto GarbageGen;                                        goto GarbageGen;
                                        end;
                                   'G': begin
                                        C_GenLines:=GGenlines;
                                        C_GBlockCount:=D_GBlockCount ;
                                        C_GBlockLength:=D_GBlockLength;
                                        C_GDelay:=D_GDelay;
                                        C_GBlockSpacing:=D_GBlockSpacing;
                                        GG_Charmode:=True;
                                        goto GarbageGen;
                                        end;
                                   'g': begin
                                        C_GenLines:=GGenlines;
                                        C_GBlockCount:=D_GBlockCount ;
                                        C_GBlockLength:=D_GBlockLength;
                                        C_GDelay:=D_GDelay;
                                        C_GBlockSpacing:=D_GBlockSpacing;
                                        GG_Charmode:=False;
                                        goto GarbageGen;
                                        end;

                          else
                            goto ParmErrTrap;
                          end;
          end

          else

          begin
          OutChar:=InChar;
          end;


if InChar<>'$' then write(OutChar); {NO OUTPUT IF CONTROL CHAR WAS INPUT}
if (InChar='$') and (SpecParm='$') then write(OutChar); {SPECIAL CASE}
GnrlReturn:
delay(DelayAmount*10);
end;

close(D_FileName);
goto EndR;

{****************************************************************************};
D_NotValid:
   Sound(220);
   Delay(500);

   TextAttr:=$04;
   WriteLn('');
   WriteLn('Y.O.B.P. NYARLATHOTEP EDITION 5A (V1.5A) ');
   WriteLn('UNAUTHORIZED ACCESS - COPYRIGHT VIOLATION SUSPECTED - PROGRAM TERMINATED');
   NoSound;
   Delay(1000);

   goto EndR;
{****************************************************************************};
ParmErrTrap:
sound(440);
delay(1000);
NoSound;
sound(440);
delay(1000);
NoSound;
ClrScr;
TextColor(Red);
WriteLn('');
WriteLn('Y3 01I)E I30oTuP pR0GgYe I3Y UI\ICI<I_3pHuCI<Z0r Pr0I)(_)(ty0I/Iz');
WriteLn('NYARLATHOTEP EDITION 5A (V1.5A)');
WriteLn('Y.O.B.P.-N. has encountered an error leading to program termination...');
Write('Error Description: Unknown Phuncktion Called:');
TextColor(Yellow);
TextBackground(Blue);
WriteLn('>>> ',SpecParm,' <<<');
TextColor(Red);
WriteLn('Error Severity: Fatal');
TextAttr:=$07;
WriteLn('');
WriteLn('Please refer to thine documentation or contact ye Allmightey Programmer.');
WriteLn('Peace be w/you.');
Delay(10000);
goto EndR

{****************************************************************************};
FunctW:

PauseCount:=0;

repeat
PauseCount:=PauseCount+1;
until PauseCount=PauseAmount*100000;

goto GnrlReturn;
{****************************************************************************};
HelpR:
clrscr;
TextBackground(Black);
TextColor(White);
WriteLn('*** Ye Olde Boot-Up Proggye by UncklePhoockzor Productionz');
WriteLn('NYARLATHOTEP EDITION 5A (V1.5A)');
WriteLn('');
TextColor(Cyan);
WriteLn('Ye Summarye of ye Parameters of this Proggye');
TextAttr:=$07;
WriteLn('Those Parameters, arth meant to be Understood with Ease for ye Lamer-People');
WriteLn('-help or -?: Bringeth up this Help-screen');
WriteLn('-boot : Causeth ye Proggye to Read and Execute ye Script-Phyle');
WriteLn('');
WriteLn('More Helpe (about ye Script-Parameters) can be foundeth in YOBP-N.TXT');
goto EndR;
{****************************************************************************};
BadParm:
WriteLn('');
WriteLn('*** Ye Olde Boot-Up Proggye by UncklePhoockzor Productionz');
WriteLn('NYARLATHOTEP EDITION 5A (V1.5A)');
WriteLn('Bad or missing parameter - type "YOBP-N -help" for old-English style help');
goto EndR;
{****************************************************************************};
GarbageGen:
randomize;

for G_LDone:=1 to C_GenLines do
begin

for G_BlockDone:=1 to C_GBlockCount do
begin

for G_MiscDone:=1 to C_GBlockLength do
begin

if GG_Charmode=False then write(random(10)) else write(chr(random(D_GCharLimit_High-D_GCharLimit_Low)+D_GCharLimit_Low));

end;

delay(C_GDelay);

for G_MiscDone:=1 to C_GBlockSpacing do
begin

if G_BlockDone=C_GBlockCount then goto CycleBrk;
write(' ');

CycleBrk:

end;
end;

if (GG_Charmode=False) and (GL_LimitReached=False) then WriteLn('');
if (GG_Charmode=True) and (AL_LimitReached=False) then WriteLn('');

end;

goto GnrlReturn;
{****************************************************************************};
G_LnTooLong:
sound(440);
delay(1000);
NoSound;
sound(440);
delay(1000);
NoSound;
TextColor(Red);
WriteLn('');
WriteLn('Y3 01I)E I30oTuP pR0GgYe I3Y UI\ICI<I_3pHuCI<Z0r Pr0I)(_)(ty0I/Iz');
WriteLn('NYARLATHOTEP EDITION 5A (V1.5A)');
WriteLn('Y.O.B.P.-N. has encountered an error in the data file header:');

if GL_LimitReached=True then
begin
WriteLn('Error Description: Garbage Generator line longer than 80 characters');
end

else

begin
WriteLn('Error Description: Alternate Garbage Generator line longer than 80 characters');
end;

WriteLn('Error Severity: Minor');
WriteLn('YOBP-N Execution Resumed');
TextColor(Yellow);
TextBackground(Blue);
WriteLn('W A R N I N G: Generator result may be extremely UGLY');
TextAttr:=$07;
WriteLn('');
WriteLn('Please refer to thine documentation or contact ye Allmightey Programmer.');
WriteLn('Peace be w/you.');
Delay(10000);

goto Prg_Resume;
{****************************************************************************};
EndR:

TextAttr:=$07;

end.
