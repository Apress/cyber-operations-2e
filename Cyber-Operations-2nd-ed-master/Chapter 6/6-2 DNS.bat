REM This is a script to read a text with data in the format
REM  101	Io 
REM  102	Europa 
REM  103	Ganymede 
REM  104	Callisto 
REM 
REM It uses dnscmd to create a Windows dns entry where the number is the last
REM   octet in the address 10.0.5.0/24.

@echo off

for /f "tokens=1,2" %%i in (dns_data.txt) do (
   dnscmd /RecordAdd ad.jupiter.test %%j /CreatePTR A 10.0.5.%%i
)
