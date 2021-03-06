yobp
====

Ye Olde Boot-Up Proggye written by UncklePhoocker Productions

Script Parm & Phile Phormat Help

Script: EVERY script has the format of $?, where $ is a fuckin' dollar sign,
        and ? is one of the following characters:

CHR* EFFECT
**********************************************************
'$'* Prints a $ sign  
'l'* Increases TYPING DELAY  
'L'* Decreases TYPING DELAY  
'p'* Increases the PAUSE AMOUNT  
'P'* Decreases the PAUSE AMOUNT  
'W'* Pauses execution with current pause amount  
'1'* Sets text color to Blue  
'2'* Sets text color to Green  
'3'* Sets text color to Cyan  
'4'* Sets text color to Red  
'5'* Sets text color to Magenta  
'6'* Sets text color to Brown  
'7'* Sets text color to Light Gray  
'8'* Sets text color to Dark Gray  
'9'* Sets text color to Light Blue  
'A'* Sets text color to Light Green  
'B'* Sets text color to Light Cyan  
'C'* Sets text color to Light Red  
'D'* Sets text color to Light Magenta  
'E'* Sets text color to Yellow  
'F'* Sets text color to White  
'T'* Sets RANDOM text color (one from the list above)  
'0'* Clears Screen  
'S'* Stops script execution  
'G'* Starts ALPHANUMERIC garbage generator, MODE 1  
'g'* Starts NUMERIC garbage generator, MODE 1  
'X'* Starts ALPHANUMERIC garbage generator, MODE 2  
'x'* Starts NUMERIC garbage generator, MODE 2  
  
Every YOBP and YOBP-N data file  
1. contains what you want to see on yer display, w/some script things (see above)  
2. AND MUST BEGIN WITH SOME CONFIGURATON LINES, LIKE THESE:  
---- example begins ----  
*** Ye Olde Boot-Up Proggye Data by UncklePhoockzor Productionz  
4 2  
20 10  
500 10  
8 4 4 25  
2 20 5 50  
33 125  
---- example ends ----  
  
Explained:  
  
*** Ye Olde Boot-Up Proggye Data by UncklePhoockzor Productionz  
> Data file header. Just try to run the proggie WITHOUT it...  
  
4  
2  
> 40 msec typing delay (number is multiplied w/10)  
> $l and $L changes this w/20 msecs  
  
20  
10  
> 10 000 000 cycles in a PAUSE routine (multiplied w/100000)  
> $p and $P changes this value with 10 000 000 (multiplied w/100000)  
  
500 10  
> 500: Garbage generator MODE 1 line count  
> 10: Garbage generator MODE 2 line count  
  
8 4 3 25  
> Garbage generator MODE 1 (8) block count,  
>                          (4) block length,  
>                          (3) block spacing &  
>                          (25) type delay (25 MSECS)(NO MULTIPLYING)  
  
2 20 5 50 >  
> Garbage generator MODE 2 (2) block count,  
>                          (20) block length,  
>                          (5) block spacing &  
>                          (50) type delay (50 MSECS)(NO MULTIPLYING)  
  
33 125  
> alphanumeric g.g. characters lower & upper limit  
> yobp allows lower limit of 32 (space char)  
> upper limit of 255 (ascii chart ends here)  
> if you wanna change, here are some domains:  
> thingyes: 32-47  
> numbers 48-57  
> capital letters 65-90  
> lower case letters 92-122  
> country-specific chars 127-170  
> box drawing chars 176-223  
> mathematical, greek & stuff 224-254  
> stoopid char: 255  
  
Enjoy !  
[EOF]  
  
P.S. Runtime errors: 003 Path not found  
                     002 File not found (no readonly !!)  
                     106 Invalid numeric format - check file header
