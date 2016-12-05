#!/bin/bash

`finclude $0 mount_share_location.sh`

# 挂载硬盘分区
e_drive=('/dev/sda3' "$mnt_point/e")
if Empty "${e_drive[1]}" ;then
	AdminRun mkdir -p "${e_drive[1]}"
	AdminRun mount "${e_drive[0]}" "${e_drive[1]}"
else
	AdminRun umount "${e_drive[1]}"
	RemoveEmptyDir "${e_drive[1]}"
fi

# 外转内快捷方式
share2in=("${out2in[1]}/!_0.外转内-文件中转/fstone-zhangshilei" "$HOME/share2in")
if Empty "${out2in[1]}" ; then
	AdminRun rm ${share2in[1]}
else
	AdminRun ln -sf "${share2in[0]}" "${share2in[1]}"

fi

RemoveEmptyDir "$mnt_point"
