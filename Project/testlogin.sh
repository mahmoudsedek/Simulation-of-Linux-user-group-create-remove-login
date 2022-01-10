#!/usr/bin/bash
function testLogin(){
clear
read -p "Enter Your Username: " varUser
checkUser=$(cat test99.txt | grep -w $varUser)
if [[ -n $checkUser ]]
then
read -p "Password for $varUser: " varPass
else
echo "User $varUser doesnt exist"
exit
fi
checkPass=$(cat test99.txt | grep -w $varUser | cut -d: -f2)
if [[ varPass -eq checkPass ]]
then
echo "Access Granted"
echo "Welcome $varUser"
else
echo "Authentication failed"
exit
fi
}
testLogin
