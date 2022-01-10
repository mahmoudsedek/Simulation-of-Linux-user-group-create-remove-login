#add newuser
function adduser {
echo "please enter username";
read username;
echo "enter password";
read pass;
userexist $username;

if [[ $? -eq 0 ]]
then
echo $username":"$pass":"$username>>users.txt;
echo $username>>groups.txt
echo "done";
else
echo "this user is already exist";
fi

}

#check user is exist or not
function userexist {
user=$(grep -w ^$1 users.txt);
if [[ -z $user ]] #if result is null
then
return 0;
else
return 1;
fi 
}


#add newgroup
function addgroup {
echo "please enter groupname";
read groupname;

groupexist $groupname;

if [[ $? -eq 0 ]]
then
echo $groupname>>groups.txt;
echo "done";
else
echo "this group is already exist";
fi

}

#check group is exist or not
function groupexist {
group=$(grep -w ^$1 groups.txt);
if [[ -z $group ]] #if result is null
then
return 0;
else
return 1;
fi 
}

#main menu
PS3="select option: ";
select x in adduser addgroup removeuser removegroup changepassword login
do
echo main menu;
if [[ $x == "adduser" ]]
then
clear;
adduser;

elif [[ $x == "addgroup" ]]
then
clear;
addgroup;

elif [[ $x == "removuser" ]]
then
clear;
echo "okay remove user";

elif [[ $x == "removegroup" ]]
then
clear;
echo "okay remove group";

elif [[ $x == "changepassword" ]]
clear;
then
echo "please enter your current password";

elif [[ $x == "login" ]]
then
clear;
echo "enter user name and password";

fi
done
