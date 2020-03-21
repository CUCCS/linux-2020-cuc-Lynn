# 无人值守Linux安装镜像制作实验

## 实验环境

·Windows

·Vitualbox

·Unbuntu 18.04 server 64bit

## 实验要求

·配置无人值守安装ios并在Vitualbox完成自动化安装

·安装完ubuntu后配置双网卡

·使用sftp在宿主机与虚拟机之间传输文件

## 实验过程

1、把用于ubuntu18.04.4镜像文件从Windows复制进虚拟机(忘截图了)

sudo mkdir loopdir #创建一个用于挂载ISO文件的目录------sudo mount -o loop ubuntu-18.04.4-server-amd64.iso loopdir

挂载iso镜像文件到该目录------ mkdir cd # 创建一个工作目录用于克隆光盘内容------rsync -av loopdir/ cd #同步光盘内容
 
 到目标目录------sudo umount loopdir #卸载镜像

![镜像挂载成功](/images/Duplicate_iso.PNG)

2、进入目标工作目录,编辑Ubuntu安装引导界面增加一个新菜单项入口，强制保存退出(:wq!)

![修改引导界面文件](/images/Modify_BOOT_interface_file.PNG)

3、

4、

5、

## 遇到的问题与解决方案
·问题一：iso镜像文件挂载失败

![iso挂载失败](/images/Filed_to_mount.PNG)

·解决方法：加sudo在root权限下执行后续mkdir loopdair及mount挂载镜像命令

·问题二：编辑Ubuntu安装引导界面文件时，无编辑权限
![只读文件](/images/Warning_readonly.PNG)

·解决方法：用chmod命令修改文件权限,或使用超级用户权限

·问题三：

·解决方法：

## 参考资料

· https://blog.csdn.net/qq_31989521/article/details/58600426?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522158478436019724835830693%2522%252C%2522scm%2522%253A%252220140713.130056874..%2522%257D&request_id=158478436019724835830693&biz_id=0&utm_source=distribute.pc_search_result.none-task

· https://blog.csdn.net/slwhy/article/details/78876237

· https://blog.csdn.net/flowrush/article/details/79943387