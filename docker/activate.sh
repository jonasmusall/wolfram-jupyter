#! /bin/sh

echo 'Please enter "Quit" after logging in using your Wolfram ID and password.'
echo ''
wolframscript
wolframscript -c 'WriteString["/root/mathpass", ReadString[$PasswordFile]]' > /dev/null 2> /dev/null
