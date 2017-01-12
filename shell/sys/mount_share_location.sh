#!/usr/bin/bash
############################################################
##!  @brief	挂载 windows 共享目录
##!  
##!  
##!  @file	mount_share_location.sh
##!  @author	fstone.zh@foxmail.com
##!  @date	2017-01-12
##!  @version	0.1.0
############################################################

# 挂载点
mnt_point="$HOME/mnt"

function AdminRun()
{
	sudo $@
}

# 文件夹空/不存在
function Empty()
{
	if [ ! -d "$1" ];then
		return 0
	fi
	local fcnt=`ls -a "$1" | wc -l`
	if [ $fcnt -le 2 ];then
		return 0
	fi
	return 1
}

# 删除空文件夹
function RemoveEmptyDir()
{
	AdminRun rmdir --ignore-fail-on-non-empty $@
}

# 获取本机IP
function GetLocalIP()
{
	ifconfig | grep "\<inet\>" | awk 'NR==1{print $2}'
}

# 挂载外转内
outer_share='//10.236.254.10/public'	# 外网 
inner_share='//10.236.100.206/public'	# 研发网
local_ip=`GetLocalIP`
if [ "$local_ip" = "10.236.100.21" ];then
	share_location=$inner_share
	echo "inner read-only share: $share_location"
else
	share_location=$outer_share
	echo "outer read-write share: $share_location"
fi

# 共享位置、挂载点
out2in=("$share_location" "$mnt_point/out2in")

# 挂载点不存在 or 空: 执行挂载
if Empty "${out2in[1]}" ;then
	AdminRun mkdir -p "${out2in[1]}"
	AdminRun mount -t cifs -o username=””,password=”” "${out2in[0]}" "${out2in[1]}"
	echo mount complete.you can access ${out2in[1]} as the same of $share_location.
else	# 挂载点非空：执行移除挂载
	AdminRun umount "${out2in[1]}"
	RemoveEmptyDir "${out2in[1]}"
	echo umount complete!
fi

