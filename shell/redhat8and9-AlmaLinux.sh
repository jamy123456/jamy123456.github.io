#!/bin/bash
#
#***************************************************************************************************
#该脚本适用于redhat8、9，almalinux8、9,Rocky linux8、9
#***************************************************************************************************
COLOR="echo -e \\033[01;31m"
END='\033[0m'

os(){
    flag=true;
    while "${flag}";do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)Rocky Linux发行版
2)Almalinux发行版
3)退出
EOF
        echo -e '\E[0m'

        read -p "请输入Linux发行版(1-3): " REL_VERSION
        case ${REL_VERSION} in
        1)
            OS_ID='Rocky'
			flag=false
            ;;
        2)
            OS_ID='Almalinux'
			flag=false
            ;;
        3)  
            exit;;		
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-3)!"${END}
            ;;
        esac
    done
    #OS_ID='Rocky'
	#OS_ID='Almalinux'
    OS_NAME='Linux'
    OS_RELEASE=`sed -rn '/^VERSION_ID=/s@.*="?([0-9.]+)"?@\1@p' /etc/os-release`
    OS_RELEASE_VERSION=`sed -rn '/^VERSION_ID=/s@.*="?([0-9]+)\.?.*"?@\1@p' /etc/os-release`
}


#阿里云镜像源
aliyun(){
    MIRROR=mirrors.aliyun.com
}

#华为镜像源
huawei(){
    MIRROR=repo.huaweicloud.com
}

#腾讯镜像源
tencent(){
    MIRROR=mirrors.tencent.com
}

#清华大学镜像源
tuna(){
    MIRROR=mirrors.tuna.tsinghua.edu.cn
}

#网易镜像源
netease(){
    MIRROR=mirrors.163.com
}

#搜狐镜像源
sohu(){
    MIRROR=mirrors.sohu.com
}

#南京大学镜像源
nju(){
    MIRROR=mirrors.nju.edu.cn
}

#中国科学技术大学镜像源
ustc(){
    MIRROR=mirrors.ustc.edu.cn
}

#上海交通大学镜像源
sjtu(){
    MIRROR=mirrors.sjtug.sjtu.edu.cn
}

#北京大学镜像源
pku(){
    MIRROR=mirrors.pku.edu.cn
}

#西安交通大学镜像源
xjtu(){
    MIRROR=mirrors.xjtu.edu.cn
}

#浙江大学镜像源
zju(){
    MIRROR=mirrors.zju.edu.cn
}

#大连东软信息学院镜像源
neusoft(){
    MIRROR=mirrors.neusoft.edu.cn
}

#ISCAS 开源镜像源
iscas(){
    MIRROR=mirror.iscas.ac.cn
}

#重庆邮电大学镜像源
cqupt(){
    MIRROR=mirrors.cqupt.edu.cn
}


#兰州大学镜像源
lzu(){
    MIRROR=mirror.lzu.edu.cn
}

#南阳理工学院镜像源
nyist(){
    MIRROR=mirror.nyist.edu.cn
}

#江西理工大学镜像源
jxust(){
    MIRROR=mirrors.jxust.edu.cn
}

#Siwoo镜像源
siwoo(){
    MIRROR=mirror.siwoo.org
}

#Ossplanet镜像源
ossplanet(){
    MIRROR=mirror.ossplanet.net
}

#elice镜像源
elice(){
    MIRROR=mirror.elice.io
}

set_yum_rocky9(){
    [ -d /etc/yum.repos.d/backup ] || { mkdir /etc/yum.repos.d/backup; mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup; }
    MIRROR_MIRROR=`echo ${MIRROR} | awk -F"." '{print $2}'`
    if [ ${MIRROR_MIRROR} == "aliyun" -o ${MIRROR_MIRROR} == "xjtu" ];then
        cat > /etc/yum.repos.d/base.repo <<-EOF
[BaseOS]
name=BaseOS
baseurl=https://${MIRROR}/rockylinux/\$releasever/BaseOS/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-\$releasever

[AppStream]
name=AppStream
baseurl=https://${MIRROR}/rockylinux/\$releasever/AppStream/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-\$releasever

[extras]
name=extras
baseurl=https://${MIRROR}/rockylinux/\$releasever/extras/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-\$releasever
EOF
    else
        cat > /etc/yum.repos.d/base.repo <<-EOF
[BaseOS]
name=BaseOS
baseurl=https://${MIRROR}/rocky/\$releasever/BaseOS/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-\$releasever

[AppStream]
name=AppStream
baseurl=https://${MIRROR}/rocky/\$releasever/AppStream/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-\$releasever

[extras]
name=extras
baseurl=https://${MIRROR}/rocky/\$releasever/extras/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-\$releasever
EOF
    fi
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} YUM源设置完成!"${END}
}

set_yum_almalinux9(){
    [ -d /etc/yum.repos.d/backup ] || { mkdir /etc/yum.repos.d/backup; mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup; }
    MIRROR_MIRROR=`echo ${MIRROR} | awk -F"." '{print $2}'`    
        cat > /etc/yum.repos.d/base.repo <<-EOF
[BaseOS]
name=BaseOS
baseurl=https://${MIRROR}/almalinux/\$releasever/BaseOS/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-\$releasever

[AppStream]
name=AppStream
baseurl=https://${MIRROR}/almalinux/\$releasever/AppStream/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-\$releasever

[extras]
name=extras
baseurl=https://${MIRROR}/almalinux/\$releasever/extras/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-\$releasever
EOF
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} YUM源设置完成!"${END}
}

rocky9_base_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)网易镜像源
3)搜狐镜像源
4)南京大学镜像源
5)中科大镜像源
6)上海交通大学镜像源
7)北京大学镜像源
8)西安交通大学镜像源
9)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-9): " NUM
        case ${NUM} in
        1)
            aliyun
            set_yum_rocky9
            ;;
        2)
            netease
            set_yum_rocky9
            ;;
        3)
            sohu
            set_yum_rocky9
            ;;
        4)
            nju
            set_yum_rocky9
            ;;
        5)
            ustc
            set_yum_rocky9
            ;;
        6)
            sjtu
            set_yum_rocky9
            ;;
        7)
            pku
            set_yum_rocky9
            ;;
        8)
            xjtu
            set_yum_rocky9
            ;;
        9)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}

almalinux9_base_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)浙江大学镜像源
3)大连东软信息学院镜像源
4)南京大学镜像源
5)ISCAS开源镜像站
6)重庆邮电大学镜像源
7)兰州大学镜像源
8)南阳理工学院镜像源
9)江西理工大学镜像源
10)Siwoo镜像源
11)Ossplanet镜像源
12)elice镜像源
13)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-13): " NUM
        case ${NUM} in
        1)
            aliyun
            set_yum_almalinux9
            ;;
        2)  
		    zju
            set_yum_almalinux9
            ;;	
        3)  
		    neusoft
            set_yum_almalinux9
            ;;			
        4)  
            nju
            set_yum_almalinux9
            ;;
        5)  
		    iscas
            set_yum_almalinux9
            ;; 						
        6)
            cqupt
            set_yum_almalinux9
            ;;
        7)
            lzu
            set_yum_almalinux9
            ;;
        8)
            nyist
            set_yum_almalinux9
            ;;
		9) 
            jxust
            set_yum_almalinux9
            ;;
       10)
            siwoo 
            set_yum_almalinux9
            ;;
       11) 
            ossplanet
            set_yum_almalinux9
            ;;
       12)
            elice 
            set_yum_almalinux9
            ;; 
       13)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}

set_devel_rocky9(){
    MIRROR_MIRROR=`echo ${MIRROR} | awk -F"." '{print $2}'`
    if [ ${MIRROR_MIRROR} == "aliyun" -o ${MIRROR_MIRROR} == "xjtu" ];then
        cat > /etc/yum.repos.d/devel.repo <<-EOF
[devel]
name=devel
baseurl=https://${MIRROR}/rockylinux/\$releasever/devel/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-\$releasever
EOF
    else
        cat > /etc/yum.repos.d/devel.repo <<-EOF
[devel]
name=devel
baseurl=https://${MIRROR}/rocky/\$releasever/devel/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-Rocky-\$releasever
EOF
    fi
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} devel源设置完成!"${END}
}

rocky9_devel_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)网易镜像源
3)搜狐镜像源
4)南京大学镜像源
5)中科大镜像源
6)上海交通大学镜像源
7)北京大学镜像源
8)西安交通大学镜像源
9)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-9): " NUM
        case ${NUM} in
        1)
            aliyun
            set_devel_rocky9
            ;;
        2)
            netease
            set_devel_rocky9
            ;;
        3)
            sohu
            set_devel_rocky9
            ;;
        4)
            nju
            set_devel_rocky9
            ;;
        5)
            ustc
            set_devel_rocky9
            ;;
        6)
            sjtu
            set_devel_rocky9
            ;;
        7)
            pku
            set_devel_rocky9
            ;;
        8)
            xjtu
            set_devel_rocky9
            ;;
        9)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}

set_devel_almalinux9(){
    MIRROR_MIRROR=`echo ${MIRROR} | awk -F"." '{print $2}'`
        cat > /etc/yum.repos.d/devel.repo <<-EOF
[devel]
name=devel
baseurl=https://${MIRROR}/almalinux/\$releasever/devel/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-\$releasever
EOF
    
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} devel源设置完成!"${END}
}

almalinux9_devel_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)浙江大学镜像源
3)大连东软信息学院镜像源
4)南京大学镜像源
5)ISCAS开源镜像站
6)重庆邮电大学镜像源
7)兰州大学镜像源
8)南阳理工学院镜像源
9)江西理工大学镜像源
10)Siwoo镜像源
11)Ossplanet镜像源
12)elice镜像源
13)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-13): " NUM
        case ${NUM} in
        1)
            aliyun
            set_devel_almalinux9
            ;;
        2)  
		    zju
            set_devel_almalinux9
            ;;	
        3)  
		    neusoft
            set_devel_almalinux9
            ;;			
        4)  
            nju
            set_devel_almalinux9
            ;;
        5)  
		    iscas
            set_devel_almalinux9
            ;; 						
        6)
            cqupt
            set_devel_almalinux9
            ;;
        7)
            lzu
            set_devel_almalinux9
            ;;
        8)
            nyist
            set_devel_almalinux9
            ;;
		9) 
            jxust
            set_devel_almalinux9
            ;;
       10)
            siwoo 
            set_devel_almalinux9
            ;;
       11) 
            ossplanet
            set_devel_almalinux9
            ;;
       12)
            elice 
            set_devel_almalinux9
            ;;
        13)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}

set_yum_rocky8(){
    [ -d /etc/yum.repos.d/backup ] || { mkdir /etc/yum.repos.d/backup; mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup; }
    MIRROR_MIRROR=`echo ${MIRROR} | awk -F"." '{print $2}'`
    if [ ${MIRROR_MIRROR} == "aliyun" -o ${MIRROR_MIRROR} == "xjtu" ];then
        cat > /etc/yum.repos.d/base.repo <<-EOF
[BaseOS]
name=BaseOS
baseurl=https://${MIRROR}/rockylinux/\$releasever/BaseOS/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial

[AppStream]
name=AppStream
baseurl=https://${MIRROR}/rockylinux/\$releasever/AppStream/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial

[extras]
name=extras
baseurl=https://${MIRROR}/rockylinux/\$releasever/extras/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial
EOF
    else
        cat > /etc/yum.repos.d/base.repo <<-EOF
[BaseOS]
name=BaseOS
baseurl=https://${MIRROR}/rocky/\$releasever/BaseOS/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial

[AppStream]
name=AppStream
baseurl=https://${MIRROR}/rocky/\$releasever/AppStream/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial

[extras]
name=extras
baseurl=https://${MIRROR}/rocky/\$releasever/extras/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial
EOF
    fi
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} YUM源设置完成!"${END}
}

rocky8_base_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)网易镜像源
3)搜狐镜像源
4)南京大学镜像源
5)中科大镜像源
6)上海交通大学镜像源
7)北京大学镜像源
8)西安交通大学镜像源
9)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-9): " NUM
        case ${NUM} in
        1)
            aliyun
            set_yum_rocky8
            ;;
        2)
            netease
            set_yum_rocky8
            ;;
        3)
            sohu
            set_yum_rocky8
            ;;
        4)
            nju
            set_yum_rocky8
            ;;
        5)
            ustc
            set_yum_rocky8
            ;;
        6)
            sjtu
            set_yum_rocky8
            ;;
        7)
            pku
            set_yum_rocky8_9
            ;;
        8)
            xjtu
            set_yum_rocky8_9
            ;;
        9)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}


set_yum_almalinux8(){
    [ -d /etc/yum.repos.d/backup ] || { mkdir /etc/yum.repos.d/backup; mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup; }
    MIRROR_MIRROR=`echo ${MIRROR} | awk -F"." '{print $2}'`    
        cat > /etc/yum.repos.d/base.repo <<-EOF
[BaseOS]
name=BaseOS
baseurl=https://${MIRROR}/almalinux/\$releasever/BaseOS/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-\$releasever

[AppStream]
name=AppStream
baseurl=https://${MIRROR}/almalinux/\$releasever/AppStream/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-\$releasever

[extras]
name=extras
baseurl=https://${MIRROR}/almalinux/\$releasever/extras/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-\$releasever
EOF
       
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} YUM源设置完成!"${END}
}

almalinux8_base_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)浙江大学镜像源
3)大连东软信息学院镜像源
4)南京大学镜像源
5)ISCAS开源镜像站
6)重庆邮电大学镜像源
7)兰州大学镜像源
8)南阳理工学院镜像源
9)江西理工大学镜像源
10)Siwoo镜像源
11)Ossplanet镜像源
12)elice镜像源
13)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-13): " NUM
        case ${NUM} in
        1)
            aliyun
            set_yum_almalinux8
            ;;
        2)  
		    zju
            set_yum_almalinux8
            ;;	
        3)  
		    neusoft
            set_yum_almalinux8
            ;;			
        4)  
            nju
            set_yum_almalinux8
            ;;
        5)  
		    iscas
            set_yum_almalinux8
            ;; 						
        6)
            cqupt
            set_yum_almalinux8
            ;;
        7)
            lzu
            set_yum_almalinux8
            ;;
        8)
            nyist
            set_yum_almalinux8
            ;;
		9) 
            jxust
            set_yum_almalinux8
            ;;
       10)
            siwoo 
            set_yum_almalinux8
            ;;
       11) 
            ossplanet
            set_yum_almalinux8
            ;;
       12)
            elice 
            set_yum_almalinux8
            ;;
       13)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}

set_powertools_rocky8(){
    MIRROR_MIRROR=`echo ${MIRROR} | awk -F"." '{print $2}'`
    if [ ${MIRROR_MIRROR} == "aliyun" -o ${MIRROR_MIRROR} == "xjtu" ];then
        cat > /etc/yum.repos.d/powertools.repo <<-EOF
[PowerTools]
name=PowerTools
baseurl=https://${MIRROR}/rockylinux/\$releasever/PowerTools/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial
EOF
    else
        cat > /etc/yum.repos.d/powertools.repo <<-EOF
[PowerTools]
name=PowerTools
baseurl=https://${MIRROR}/rocky/\$releasever/PowerTools/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rockyofficial
EOF
    fi
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} PowerTools源设置完成!"${END}
}

rocky8_powertools_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)网易镜像源
3)搜狐镜像源
4)南京大学镜像源
5)中科大镜像源
6)上海交通大学镜像源
7)北京大学镜像源
8)西安交通大学镜像源
9)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-9): " NUM
        case ${NUM} in
        1)
            aliyun
            set_powertools_rocky8
            ;;
        2)
            netease
            set_powertools_rocky8
            ;;
        3)
            sohu
            set_powertools_rocky8
            ;;
        4)
            nju
            set_powertools_rocky8
            ;;
        5)
            ustc
            set_powertools_rocky8
            ;;
        6)
            sjtu
            set_powertools_rocky8
            ;;
        7)
            pku
            set_powertools_rocky8
            ;;
        8)
            xjtu
            set_powertools_rocky8
            ;;
        9)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}

set_powertools_almalinux8(){
    MIRROR_MIRROR=`echo ${MIRROR} | awk -F"." '{print $2}'`
        cat > /etc/yum.repos.d/powertools.repo <<-EOF
[PowerTools]
name=PowerTools
baseurl=https://${MIRROR}/almalinux/\$releasever/PowerTools/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-AlmaLinux-\$releasever
EOF
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} PowerTools源设置完成!"${END}
}

almalinux8_powertools_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)浙江大学镜像源
3)大连东软信息学院镜像源
4)南京大学镜像源
5)ISCAS开源镜像站
6)重庆邮电大学镜像源
7)兰州大学镜像源
8)南阳理工学院镜像源
9)江西理工大学镜像源
10)Siwoo镜像源
11)Ossplanet镜像源
12)elice镜像源
13)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-13): " NUM
        case ${NUM} in
        1)
            aliyun
            set_powertools_almalinux8
            ;;
        2)  
		    zju
            set_powertools_almalinux8
            ;;	
        3)  
		    neusoft
            set_powertools_almalinux8
            ;;			
        4)  
            nju
            set_powertools_almalinux8
            ;;
        5)  
		    iscas
            set_powertools_almalinux8
            ;; 						
        6)
            cqupt
            set_powertools_almalinux8
            ;;
        7)
            lzu
            set_powertools_almalinux8
            ;;
        8)
            nyist
            set_powertools_almalinux8
            ;;
		9) 
            jxust
            set_powertools_almalinux8
            ;;
       10)
            siwoo 
            set_powertools_almalinux8
            ;;
       11) 
            ossplanet
            set_powertools_almalinux8
            ;;
       12)
            elice 
            set_powertools_almalinux8
            ;;
       13)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}

set_yum_centos_stream9(){
    [ -d /etc/yum.repos.d/backup ] || { mkdir /etc/yum.repos.d/backup; mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup; }
    cat > /etc/yum.repos.d/base.repo <<-EOF
[BaseOS]
name=BaseOS
baseurl=https://${MIRROR}/centos-stream/\$stream/BaseOS/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[AppStream]
name=AppStream
baseurl=https://${MIRROR}/centos-stream/\$stream/AppStream/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[extras-common]
name=extras-common
baseurl=https://${MIRROR}/centos-stream/SIGs/\$stream/extras/\$basearch/extras-common/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} YUM源设置完成!"${END}
}

centos_stream9_base_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)华为镜像源
3)腾讯镜像源
4)清华镜像源
5)网易镜像源
6)南京大学镜像源
7)中科大镜像源
8)北京大学镜像源
9)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-9): " NUM
        case ${NUM} in
        1)
            aliyun
            set_yum_centos_stream9
            ;;
        2)
            huawei
            set_yum_centos_stream9
            ;;
        3)
            tencent
            set_yum_centos_stream9
            ;;
        4)
            tuna
            set_yum_centos_stream9
            ;;
        5)
            netease
            set_yum_centos_stream9
            ;;
        6)
            nju
            set_yum_centos_stream9
            ;;
        7)
            ustc
            set_yum_centos_stream9
            ;;
        8)
            pku
            set_yum_centos_stream9
            ;;
        9)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-9)!"${END}
            ;;
        esac
    done
}

set_yum_centos_stream8(){
    [ -d /etc/yum.repos.d/backup ] || { mkdir /etc/yum.repos.d/backup; mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup; }
    cat > /etc/yum.repos.d/base.repo <<-EOF
[BaseOS]
name=BaseOS
baseurl=https://${MIRROR}/centos/\$stream/BaseOS/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[AppStream]
name=AppStream
baseurl=https://${MIRROR}/centos/\$stream/AppStream/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

[extras]
name=extras
baseurl=https://${MIRROR}/centos/\$stream/extras/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} YUM源设置完成!"${END}
}

centos_stream8_base_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)华为镜像源
3)腾讯镜像源
4)清华镜像源
5)网易镜像源
6)南京大学镜像源
7)中科大镜像源
8)北京大学镜像源
9)西安交通大学镜像源
10)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-10): " NUM
        case ${NUM} in
        1)
            aliyun
            set_yum_centos_stream8
            ;;
        2)
            huawei
            set_yum_centos_stream8
            ;;
        3)
            tencent
            set_yum_centos_stream8
            ;;
        4)
            tuna
            set_yum_centos_stream8
            ;;
        5)
            netease
            set_yum_centos_stream8
            ;;
        6)
            nju
            set_yum_centos_stream8
            ;;
        7)
            ustc
            set_yum_centos_stream8
            ;;
        8)
            pku
            set_yum_centos_stream8
            ;;
        9)
            xjtu
            set_yum_centos_stream8
            ;;
        10)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-10)!"${END}
            ;;
        esac
    done
}

set_powertools_centos_stream8(){
    cat > /etc/yum.repos.d/powertools.repo <<-EOF
[PowerTools]
name=PowerTools
baseurl=https://${MIRROR}/centos/\$stream/PowerTools/\$basearch/os/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial
EOF
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} PowerTools源设置完成!"${END}
}

centos_stream8_powertools_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)华为镜像源
3)腾讯镜像源
4)清华镜像源
5)网易镜像源
6)南京大学镜像源
7)中科大镜像源
8)北京大学镜像源
9)西安交通大学镜像源
10)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-10): " NUM
        case ${NUM} in
        1)
            aliyun
            set_powertools_centos_stream8
            ;;
        2)
            huawei
            set_powertools_centos_stream8
            ;;
        3)
            tencent
            set_powertools_centos_stream8
            ;;
        4)
            tuna
            set_powertools_centos_stream8
            ;;
        5)
            netease
            set_powertools_centos_stream8
            ;;
        6)
            nju
            set_powertools_centos_stream8
            ;;
        7)
            ustc
            set_powertools_centos_stream8
            ;;
        8)
            pku
            set_powertools_centos_stream8
            ;;
        9)
            xjtu
            set_powertools_centos_stream8
            ;;
        10)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-10)!"${END}
            ;;
        esac
    done
}

set_epel_rocky_centos8_9(){
    MIRROR_URL=`echo ${MIRROR} | awk -F"." '{print $2}'`
    if [ ${MIRROR_URL} == "sohu" ];then
        cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://${MIRROR}/fedora-epel/\$releasever/Everything/\$basearch/
gpgcheck=0
gpgkey=https://${MIRROR}/fedora-epel/RPM-GPG-KEY-EPEL-\$releasever
EOF
    elif [ ${MIRROR_URL} == "sjtu" ];then
        cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://${MIRROR}/fedora/epel/\$releasever/Everything/\$basearch/
gpgcheck=0
gpgkey=https://${MIRROR}/fedora/epel/RPM-GPG-KEY-EPEL-\$releasever
EOF
    else
        cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://${MIRROR}/epel/\$releasever/Everything/\$basearch/
gpgcheck=0
gpgkey=https://${MIRROR}/epel/RPM-GPG-KEY-EPEL-\$releasever
EOF
    fi
    ${COLOR}"更新镜像源中,请稍等..."${END}
    dnf clean all &> /dev/null
    dnf makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} EPEL源设置完成!"${END}
}

rocky_centos8_9_epel_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)华为镜像源
3)腾讯镜像源
4)清华镜像源
5)搜狐镜像源
6)南京大学镜像源
7)中科大镜像源
8)上海交通大学镜像源
9)北京大学镜像源
10)西安交通大学镜像源
11)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-11): " NUM
        case ${NUM} in
        1)
            aliyun
            set_epel_rocky_centos8_9
            ;;
        2)
            huawei
            set_epel_rocky_centos8_9
            ;;
        3)
            tencent
            set_epel_rocky_centos8_9
            ;;
        4)
            tuna
            set_epel_rocky_centos8_9
            ;;
        5)
            sohu
            set_epel_rocky_centos8_9
            ;;
        6)
            nju
            set_epel_rocky_centos8_9
            ;;
        7)
            ustc
            set_epel_rocky_centos8_9
            ;;
        8)
            sjtu
            set_epel_rocky_centos8_9
            ;;
        9)
            pku
            set_epel_rocky_centos8_9
            ;;
        10)
            xjtu
            set_epel_rocky_centos8_9
            ;;
        11)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-11)!"${END}
            ;;
        esac
    done
}

set_yum_centos7(){    
    [ -d /etc/yum.repos.d/backup ] || { mkdir /etc/yum.repos.d/backup; mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup; }
    cat > /etc/yum.repos.d/base.repo <<-EOF
[base]
name=base
baseurl=https://${MIRROR}/centos/\$releasever/os/\$basearch/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever

[extras]
name=extras
baseurl=https://${MIRROR}/centos/\$releasever/extras/\$basearch/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever

[updates]
name=updates
baseurl=https://${MIRROR}/centos/\$releasever/updates/\$basearch/
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever
EOF
    ${COLOR}"更新镜像源中,请稍等..."${END}
    yum clean all &> /dev/null
    yum makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} YUM源设置完成!"${END}
}

centos7_base_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)华为镜像源
3)腾讯镜像源
4)清华镜像源
5)网易镜像源
6)南京大学镜像源
7)中科大镜像源
8)北京大学镜像源
9)西安交通大学镜像源
10)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-10): " NUM
        case ${NUM} in
        1)
            aliyun
            set_yum_centos7
            ;;
        2)
            huawei
            set_yum_centos7
            ;;
        3)
            tencent
            set_yum_centos7
            ;;
        4)
            tuna
            set_yum_centos7
            ;;
        5)
            netease
            set_yum_centos7
            ;;
        6)
            nju
            set_yum_centos7
            ;;
        7)
            ustc
            set_yum_centos7
            ;;
        8)
            pku
            set_yum_centos7
            ;;
        9)
            xjtu
            set_yum_centos7
            ;;
        10)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-10)!"${END}
            ;;
        esac
    done
}

set_epel_centos7(){
    MIRROR_URL=`echo ${MIRROR} | awk -F"." '{print $2}'`
    if [ ${MIRROR_URL} == "sohu" ];then
        cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://${MIRROR}/fedora-epel/\$releasever/\$basearch/
gpgcheck=0
gpgkey=https://${MIRROR}/fedora-epel/RPM-GPG-KEY-EPEL-\$releasever
EOF
    elif [ ${MIRROR_URL} == "sjtu" ];then
        cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://${MIRROR}/fedora/epel/\$releasever/\$basearch/
gpgcheck=0
gpgkey=https://${MIRROR}/fedora/epel/RPM-GPG-KEY-EPEL-\$releasever
EOF
    else
        cat > /etc/yum.repos.d/epel.repo <<-EOF
[epel]
name=epel
baseurl=https://${MIRROR}/epel/\$releasever/\$basearch/
gpgcheck=0
gpgkey=https://${MIRROR}/epel/RPM-GPG-KEY-EPEL-\$releasever
EOF
    fi
    ${COLOR}"更新镜像源中,请稍等..."${END}
    yum clean all &> /dev/null
    yum makecache &> /dev/null
    ${COLOR}"${OS_ID} ${OS_RELEASE} EPEL源设置完成!"${END}
}

centos7_epel_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)阿里镜像源
2)华为镜像源
3)腾讯镜像源
4)清华镜像源
5)搜狐镜像源
6)南京大学镜像源
7)中科大镜像源
8)上海交通大学镜像源
9)北京大学镜像源
10)西安交通大学镜像源
11)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-11): " NUM
        case ${NUM} in
        1)
            aliyun
            set_epel_centos7
            ;;
        2)
            huawei
            set_epel_centos7
            ;;
        3)
            tencent
            set_epel_centos7
            ;;
        4)
            tuna
            set_epel_centos7
            ;;
        5)
            sohu
            set_epel_centos7
            ;;
        6)
            nju
            set_epel_centos7
            ;;
        7)
            ustc
            set_epel_centos7
            ;;
        8)
            sjtu
            set_epel_centos7
            ;;
        9)
            pku
            set_epel_centos7
            ;;
        10)
            xjtu
            set_epel_centos7
            ;;
        11)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-11)!"${END}
            ;;
        esac
    done
}

rocky_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)base仓库
2)epel仓库
3)Rocky 9 devel仓库
4)Rocky 8 PowerTools仓库
5)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-5): " NUM
        case ${NUM} in
        1)
            if [ ${OS_RELEASE_VERSION} == "8" ];then
                rocky8_base_menu
            else
                rocky9_base_menu
            fi
            ;;
        2)
            rocky_centos8_9_epel_menu
            ;;
        3)
            if [ ${OS_RELEASE_VERSION} == "9" ];then
                rocky9_devel_menu
            fi
            ;;
        4)
            if [ ${OS_RELEASE_VERSION} == "8" ];then
                rocky8_powertools_menu
            fi
            ;;
        5)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-5)!"${END}
            ;;
        esac
    done
}

almalinux_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)base仓库
2)epel仓库
3)Almalinux 9 devel仓库
4)Almalinux 8 PowerTools仓库
5)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-5): " NUM
        case ${NUM} in
        1)
            if [ ${OS_RELEASE_VERSION} == "8" ];then
                almalinux8_base_menu
            else
                almalinux9_base_menu
            fi
            ;;
        2)
            rocky_centos8_9_epel_menu
            ;;
        3)
            if [ ${OS_RELEASE_VERSION} == "9" ];then
                almalinux9_devel_menu
            fi
            ;;
        4)
            if [ ${OS_RELEASE_VERSION} == "8" ];then
                almalinux8_powertools_menu
            fi
            ;;
        5)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-5)!"${END}
            ;;
        esac
    done
}

centos_menu(){
    while true;do
        echo -e "\E[$[RANDOM%7+31];1m"
        cat <<-EOF
1)base仓库
2)epel仓库
3)CentOS Stream 8 PowerTools仓库
4)退出
EOF
        echo -e '\E[0m'

        read -p "请输入镜像源编号(1-4): " NUM
        case ${NUM} in
        1)
            if [ ${OS_NAME} == "Stream" ];then
                if [ ${OS_RELEASE_VERSION} == "8" ];then
                    centos_stream8_base_menu
                else
                    centos_stream9_base_menu
                fi
            else
                centos7_base_menu
            fi
            ;;
        2)
            if [ ${OS_RELEASE_VERSION} == "7" ];then
                centos7_epel_menu
            else
                rocky_centos8_9_epel_menu
            fi
            ;;
        3)
            if [ ${OS_RELEASE_VERSION} == "8" ];then
                centos_stream8_powertools_menu
            fi
            ;;
        4)
            break
            ;;
        *)
            ${COLOR}"输入错误,请输入正确的数字(1-4)!"${END}
            ;;
        esac
    done
}


set_mirror_repository(){
    if [ ${OS_ID} == "CentOS" ];then
        centos_menu
    elif [ ${OS_ID} == "Rocky" ];then
        rocky_menu
    elif [ ${OS_ID} == "Almalinux" ];then
        almalinux_menu
	else
        almalinux_menu
    fi
}

main(){
    os
    set_mirror_repository
}

main
