###########cut command#######
#cut:-
It can be used to cut parts of a line by byte position, character and field.
Note:-
#Its unreasonable to enter every character position to extract, so cut accepts these notations as well as the comma-separated list:
N- From the Nth byte, character, or field, to the end of the line
N-M From the Nth to Mth (included) byte, character, or field
-M From the first to Mth (included) byte, character, or field
#We use the preceding notations to specify fields as a range of bytes, characters, or fields with the following options:
-b for bytes
-c for characters
-f for defining fields

$ cat state.txt
Andhra Pradesh
Arunachal Pradesh
Assam
Bihar
Chhattisgarh
#Options and their Description with examples:
1. -b(byte):
#List without rangesw
$ cut -b 1,2,3 state.txt
And
Aru
Ass
Bih
Chh

#List with ranges
$ cut -b 1-3,5-7 state.txt
Andra
Aruach
Assm
Bihr
Chhtti
2. -c (column): To cut by character use the -c option.
Syntax:
$cut -c [(k)-(n)/(k),(n)/(n)] filename
Here,k denotes the starting position of the character and n denotes the ending position of the character in each line, 
if k and n are separated by “-” otherwise they are only the position of character in each line from the file taken as an input.

#Below  cut command prints second, fifth and seventh character from each line of the file.
$ cut -c 2,5,7 state.txt
nr
rah
sm
ir
hti

$ cut -c 1-7 state.txt
Andhra
Arunach
Assam
Bihar
Chhatti
# Below  command prints starting from first character to end. Here in command only starting position is specified and the ending position is omitted.
$ cut -c 1- state.txt

Andhra Pradesh
Arunachal Pradesh
Assam
Bihar
Chhattisgarh

#Below  command prints starting position to the fifth character. Here the starting position is omitted and the ending position is specified.
$ cut -c -5 state.txt
Andhr
Aruna
Assam
Bihar
Chhat

3. -f (field): -c option is useful for fixed-length lines. 
Syntax:
$ cut -f FIELD_LIST filename
$cut -d "delimiter" -f (field number) file.txt
Like in the file state.txt fields are separated by space if -d option is not used then it prints whole line:

$ cut -f 1 state.txt
	or
$ cut -f 2,3 filename
Andhra Pradesh
Arunachal Pradesh
Assam
Bihar
Chhattisgarh

4. If -d option is used then it considered space as a field separator or delimiter:

$ cut -d " " -f 1 state.txt
Andhra
Arunachal
Assam
Bihar
Chhattisgarh
Command prints field from first to fourth of each line from the file.
Command:

$ cut -d " " -f 1-4 state.txt
Output:
Andhra Pradesh
Arunachal Pradesh
Assam
Bihar
Chhattisgarh
5. The  – complement option will display all the fields except those defined by -f.
This command displays all fields except 3:
This option can be used in the combination with other options either with -f or with -c.

$ cut --complement -d " " -f 3 state.txt
Pradesh
Pradesh
Assam
Bihar
Chhattisgarh

$ cut --complement -c 5 state.txt
Andha Pradesh
Arunchal Pradesh
Assa
Biha
Chhatisgarh
6. –output-delimiter: By default the output delimiter is same as input delimiter that we specify in the cut with -d option.
To change the output delimiter use the option –output-delimiter=”delimiter”.

$ cut -d " " -f1,2 state.txt --output-delimiter='%'
Andhra%Pradesh
Arunachal%Pradesh
Assam
Bihar
Chhattisgarh


7.The -d option will set the delimiter. The following command shows how to use
cut with a colon-separated list:
$ cat delimited_data.txt
 No;Name;Mark;Percent
 1;Sarath;45;90
 2;Alex;49;98
 3;Anu;45;90
 $ cut -f2 -d";" delimited_data.txt
 Name
 Sarath
 Alex
 Anu
 
Its unreasonable to enter every character position to extract, so cut accepts these notations as well as the comma-separated list:
N- From the Nth byte, character, or field, to the end of the line
N-M From the Nth to Mth (included) byte, character, or field
-M From the first to Mth (included) byte, character, or field
We use the preceding notations to specify fields as a range of bytes, characters, or fields
with the following options:
-b for bytes
-c for characters
-f for defining fields