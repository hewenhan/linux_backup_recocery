read -p "from file (输入备份文件地址，留空默认本目录'backup.tgz'):"  fromFile
read -p "to dir (输入还原到目标目录的地址，留空默认根目录):"  toDir

if [[ $fromFile = '' ]]
then
    fromFile='./backup.tgz'
fi

if [[ $toDir = '' ]]
then
    toDir='/'
fi

exDirs=(
	'proc'
	'lost+found'
	'mnt'
	'sys'
	'media'
)
for((i=0;i<${#exDirs[*]};i++));
do
	ex=${exDirs[${i}]}
	cellCom='mkdir '${toDir}${ex}
	$cellCom > /dev/null 2>&1
done

com='tar xvpfz '${fromFile}' -C '${toDir}
echo $com
$com