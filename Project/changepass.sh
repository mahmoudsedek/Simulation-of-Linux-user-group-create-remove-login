#!/usr/bin/bash
function changePass(){
clear
read -p "Enter the username that you want to change password for: " varUser
checkUser=$(cat test99.txt | grep -w $varUser)
if [[ -n $checkUser ]]
then
read -p "Enter Old Password for $varUser: " varOldPass
else
echo "User $varUser doesnt exist"
exit;
fi
checkPass=$(cat test99.txt | grep -w $varUser | cut -d: -f2)
if [[ $varOldPass -eq $checkPass ]]
then
read -p "Enter New Password for $varUser: " varNewPass
varOld=$varUser:$varOldPass
varNew=$varUser:$varNewPass
sed -i -e "s/$varOld/$varNew/" test99.txt
echo "Password Successfully Changed!"
else
echo "Authentication Failed"
exit
fi
}
changePass
