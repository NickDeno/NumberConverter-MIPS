Project Guidelines:
Write a MIPS program to implement functions to convert a number from one number
system to another.
▪ Requirement:
1. Write a MIPS program to:
a. Convert binary number to decimal and hexadecimal number
b. Convert decimal number to binary and hexadecimal number
c. Convert hexadecimal number to binary and decimal number
2. The MIPS program repeatedly displays the following menu:
1. Binary to hexadecimal and decimal
2. Hexadecimal to binary and decimal
3. Decimal to binary and hexadecimal
4. Exit

User enters a number (1 to 3) to select one item from the meu to perform a
conversion: once a menu item is selected, user is prompt to enter a number (in
string) which is the source value. If this source is valid, it will be converted to
destination numbers. Display message: source number, destination-1 number,
destination-2 number. For example, if menu item 1 is select, the message will be:
Binary number: [binary-number]
Decimal number: [decimal-number]
Hexadecimal number: [hexadecimal-number]
After this message is displayed, the menu will be displayed again, so user can select
another item.
If menu item 4 is entered, the program will be terminated.
The program should validate the input string. For example, if menu item 1 is
selected, all characters in the string must be ‘0’ or ‘1’; if item 2 is selected, all
characters in the string must be hexadecimal characters ({‘0’, ‘1’, ‘2’, … ‘9’, ‘A’,
‘B’,…, ‘F’ }). The program will ask user to re-input if the string is invalid.

Submission:
A runnable MIPS program.
