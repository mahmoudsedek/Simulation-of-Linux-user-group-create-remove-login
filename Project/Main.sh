#!/usr/bin/bash


##Add User
function AddUser {

read -p "Please Enter User Name : " VarUser

CheckUser=$(grep -w ^$VarUser project.txt)

if [[ -z $CheckUser ]]
        then
        read -p "Please Enter Your Password : " VarPass
UserID=$(tail -1 project.txt | cut -d: -f3)

if [[ -z $UserID  ]]
        then
        x=1000
        echo $VarUser":"$VarPass":"$x >> project.txt
	exit
else
        x=$(($UserID+1))
        echo $VarUser":"$VarPass":"$x >> project.txt
	AddGroup
	exit
fi
else
        echo "This user already exist"
        echo "Please enter Another User Name"
        echo " "
fi

}

##Add Group
function AddGroup {

read -p "Please Enter Group Name : " VarGroup

CheckGroup=$(grep -w ^$VarGroup group.txt)

if [[ -z $CheckGroup ]]
        then
GroupID=$(tail -1 group.txt | cut -d: -f2)

if [[ -z $GroupID  ]]
        then
        x=1000
        echo $VarGroup":"$x >> group.txt
else
        x=$(($GroupID+1))
        echo $VarGroup":"$x >> group.txt
fi
exit
else
        echo "This Group already exist"
        echo "Please enter Another Group Name"
        echo " "
fi

}

##Check Password

function changePass(){
clear
read -p "Enter the username that you want to change password for: " varUser
checkUser=$(cat project.txt | grep -w $varUser)
if [[ -n $checkUser ]]
then
read -p "Enter Old Password for $varUser: " varOldPass
else
echo "User $varUser doesnt exist"
exit;
fi
checkPass=$(cat project.txt | grep -w $varUser | cut -d: -f2)
if [[ $varOldPass -eq $checkPass ]]
then
read -p "Enter New Password for $varUser: " varNewPass
varOld=$varUser:$varOldPass
varNew=$varUser:$varNewPass
sed -i -e "s/$varOld/$varNew/" project.txt
echo "Password Successfully Changed!"
else
echo "Authentication Failed"
exit
fi
}

##Test Login
function testLogin(){
clear
read -p "Enter Your Username: " varUser
checkUser=$(cat project.txt | grep -w $varUser)
if [[ -n $checkUser ]]
then
read -p "Password for $varUser: " varPass
else
echo "User $varUser doesnt exist"
exit
fi
checkPass=$(cat project.txt | grep -w $varUser | cut -d: -f2)
if [[ varPass -eq checkPass ]]
then
echo "Access Granted"
echo "Welcome $varUser"
else
echo "Authentication failed"
exit
fi
}


## Remove User

function removeUser(){
clear
read -p "Enter Username That You Want To Remove: " varUser
checkUser=$(cat project.txt | grep -w $varUser)
if [[ -n $checkUser ]]
then
read -p "Are You Sure You Want to Delete User $varUser? [y/n]" varAnswer
	if [[ $varAnswer  ==  "y" ]]
	then
	sed -i -e "/$checkUser/d" project.txt;
	echo "User Deleted"
	else
	Main
	fi
else
echo "User $varUser doesnt exist"

fi

}

##Remove Group

function removeGroup(){
clear
read -p "Enter Group name That You Want To Remove: " varGroup
checkGroup=$(cat group.txt | grep -w $varGroup)
if [[ -n $checkGroup ]]
then
read -p "Are You Sure You Want to Delete Group $varGroup? [y/n]" varAnswer
	if [[ $varAnswer  ==  "y" ]]
	then
	sed -i -e "/$checkGroup/d" group.txt;
	echo "Group Deleted"	
	exit
	else
	Main
	fi
else
echo "Group $varGroup doesnt exist"

fi

}

##Main Function
function Main {

select x in AddUser AddGroup RemoveUser RemoveGroup ChangePassword Login
do
        if [[ $x == AddUser ]]
                then
		      clear
                      AddUser;
    
	 elif [[ $x == AddGroup  ]]
                then
		      clear
		      AddGroup;

        elif [[ $x == RemoveUser  ]]
                then
                        removeUser

        elif [[ $x == RemoveGroup  ]]
                then
                       removeGroup

        elif [[ $x == ChangePassword  ]]
                then
                       changePass

        elif [[ $x == Login  ]]
                then
                       testLogin
        else
                echo "please choose right option"

        fi
done
}
Main
