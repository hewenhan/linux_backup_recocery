#!/bin/bash
read -p "from dir (输入备份源目录地址，留空默认跟目录):"  fromDir
read -p "to dir (输入备份到目标目录的地址，留空默认本目录):"  toDir

if [[ $fromDir = '' ]]
then
    fromDir='/'
fi

if [[ $toDir = '' ]]
then
    toDir='./'
fi

len=${#fromDir}-1
lastStr=${fromDir:$len:1}

if [ $lastStr != '/' ]
then
    fromDir+='/'
fi

len=${#toDir}-1
lastStr=${toDir:$len:1}

if [ $lastStr != '/' ]
then
    toDir+='/'
fi

exclude='--exclude='
exDirs=(
	'proc'
	'lost+found'
	'backup.tgz'
	'mnt'
	'sys'
	'media'
)

excom=''
for((i=0;i<${#exDirs[*]};i++));
do
	ex=${exDirs[${i}]}
	cell=${exclude}${fromDir}${ex}' '
	excom+=${cell}
done
com='tar cvpzf '${toDir}'backup.tgz '${excom}${fromDir}

echo $com
$com