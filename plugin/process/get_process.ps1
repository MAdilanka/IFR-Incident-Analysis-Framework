function get_process{
get-process -IncludeUserName | select ProcessName,ID,UserName,Path
}

get_process