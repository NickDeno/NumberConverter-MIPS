
# Number Converter Project

Written in MIPS Assembly using Mars IDE. A user will enter a number (1 to 3) to select one item from the menu to perform conversion. Once a menu item is selected, the user is prompt to enter a number (in string) which is the source value. If this source is valid, it will be converted to destination numbers. For example, if menu item 1 is select, the message will be:
```bash
Binary number: [binary-number]
Decimal number: [decimal-number]
Hexadecimal number: [hexadecimal-number]
```
After this message is displayed, the menu will be displayed again, so user can select
another item. If menu item 4 is entered, the program will be terminated.


## Project Requirements

1.  Write a MIPS Assembly Program to:
    * Convert binary number to decimal and hexadecimal number
    * Convert decimal number to binary and hexadecimal number
    * Convert hexadecimal number to binary and decimal number
2.  The MIPS Assembly program will repeatedly display the following menu:
    * Binary to hexadecimal and decimal
    * Hexadecimal to binary and decimal
    * Decimal to binary and hexadecimal
    * Exit
3. The display message should be in the form:
```bash
Source number: [source number]
Destination-1 number: [destination1-number]
Destination-2 number: [destination2-number]
```
4. The program should validate the input string. For example, if menu item 1 is
selected, all characters in the string must be ‘0’ or ‘1’. If item 2 is selected, all
characters in the string must be hexadecimal characters ({‘0’, ‘1’, ‘2’, … ‘9’, ‘A’,
‘B’,…, ‘F’ }). The program will ask user to re-input if the string is invalid.

5. Submission: A runnable MIPS Assembly program