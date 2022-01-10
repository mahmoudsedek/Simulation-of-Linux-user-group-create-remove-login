#!/usr/bin/bash
function removeUser(){
clear
read -p "Enter Username That You Want To Remove: " varUser
checkUser=$(cat test99.txt | grep -w $varUser)
if [[ -n $checkUser ]]
then
read -p "Are You Sure You Want to Delete User $varUser? [y/n]" varAnswer
	if [[ $varAnswer=="y" ]]
	then
	sed -i -e "/$checkUser/d" test99.txt;
	echo "User Deleted"
	else
	exit
	fi
else
echo "User $varUser doesnt exist"
exit
fi

}
removeUser
