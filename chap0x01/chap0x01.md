# 无人值守Linux安装镜像制作实验

## 实验环境

·Windows 10

·Vitualbox

·Unbuntu 18.04 server 64bit

·双网卡 NAT+Host-only

## 实验要求

·如何配置无人值守安装iso并在Virtualbox中完成自动化安装.

·Virtualbox安装完Ubuntu之后新添加的网卡如何实现系统开机自动启用和自动获取IP?

·如何使用sftp在虚拟机和宿主机之间传输文件?

## 实现特性

· 定制一个普通用户名和默认密码

![定制用户密码](/images/定制用户名密码.PNG)

· 定制安装OpenSSH Server

![定制安装OpenSSH_Server](/images/定制安装OpenSSH_Server.PNG)

· 安装过程禁止自动联网更新软件包

![定制用户密码](/images/禁止自动联网更新.PNG)

## 实验过程

·网络配置,查看网卡状态

![获取IP：192.168.56.101](/images/获取IP.PNG)

·sudo /etc/init.d/ssh start  #启用ssh 

![启用ssh](/images/启用ssh.PNG)

·使用PUTTY连接虚拟机

![putty连接虚拟机](/images/putty.PNG)

·把用于ubuntu18.04.4镜像文件从Windows复制进虚拟机：

    sudo mkdir loopdir #创建一个用于挂载ISO文件的目录

    sudo mount -o loop ubuntu-18.04.4-server-amd64.iso loopdir #挂载iso镜像文件到该目录

    mkdir cd  #创建一个工作目录用于克隆光盘内容

    rsync -av loopdir/ cd #同步光盘内容到目标目录-

    sudo umount loopdir #卸载镜像

![镜像挂载成功](/images/成功挂载.PNG)


·进入目标工作目录,编辑Ubuntu安装引导界面增加一个新菜单项入口，强制保存退出(:wq!)，注意将内容置顶添加

![进入当前工作目录](/images/进入当前目录.PNG)

![修改引导界面文件](/images/修改引导界面文件.PNG)

·提前阅读并编辑定制Ubuntu官方提供的示例preseed.cfg，并将该文件保存到刚才创建的工作目录~/cd/preseed/ubuntu-server-autoinstall.seed
   通过psftp将下载保存的.seed文件先上传到虚拟机根目录下，再移动到~/cd/preseed/，注意移动指令在根目录下，需要切换目录

![传输.seed文件](/images/psftp传输preseed.PNG)

![移动.seed至工作目录](/images/移动至当前目录.PNG)

·在cd目录下修改isolinux/isolinux.cfg，增加内容timeout 10  指令:sudo vi isolinux/isolinux.cfg

![增加timeout10](/images/timeout10.PNG)

·重新生成md5sum.txt  
     
   由于一直拒绝访问，sudo su进入到root权限

![生成md5sum.txt](/images/md5sum文件生成.PNG)

·封闭改动后的目录到.iso   

  错误信息：无 mkisofs 命令(提示安装genisoimage)

![安装genisoimage](/images/安装genisoimage.PNG)

![封装目录到.iso](/images/封装成功.PNG)

·生成custom.iso，使用PSFTP传入宿主机,先将镜像文件移至虚拟机根目录下，通过ls查看到远程文件列表，lcd改变本地目录避免

unable to open问题 

![下载custom.iso出错](/images/下载出错.PNG)

![宿主机下载custom.iso](/images/psftp下载.PNG)

·在VirtualBox上完成自动安装


## 遇到的问题与解决方案

·问题一：iso镜像文件挂载失败

![iso挂载失败](/images/iso挂载失败.PNG)

·解决方法：加sudo在root权限下执行后续mkdir loopdair及mount挂载镜像命令

·问题二：编辑Ubuntu安装引导界面文件时，无编辑权限

![只读文件](/images/文件只读.PNG)

·解决方法：用chmod命令修改文件权限,或使用超级用户权限或使用sudo命令

·问题三：封装改动后的目录到.iso时 报错 无权限或无文件目录

![genisoimage报错](/images/genisoimage报错.PNG)

·解决方法：不要进入root权限，因为缺少 /root/cd 这个目录，用sudo运行解决该问题

![sudo运行封装命令](/images/sudo运行封装命令)

·问题四：开始安装时卡住，无法正常进行。如下图：

![安装出现异常](/images/error.PNG)

·解决方法：

## 参考资料

· https://blog.csdn.net/qq_31989521/article/details/58600426?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522158478436019724835830693%2522%252C%2522scm%2522%253A%252220140713.130056874..%2522%257D&request_id=158478436019724835830693&biz_id=0&utm_source=distribute.pc_search_result.none-task

· https://github.com/CUCCS/linux-2019-LeLeF/blob/chap0x01/chap0x01VirtualBox%20%E6%97%A0%E4%BA%BA%E5%80%BC%E5%AE%88%E5%AE%89%E8%A3%85Unbuntu%E7%B3%BB%E7%BB%9F%E5%AE%9E%E9%AA%8C/chap0x01%20VirtualBox%20%E6%97%A0%E4%BA%BA%E5%80%BC%E5%AE%88%E5%AE%89%E8%A3%85Unbuntu%E7%B3%BB%E7%BB%9F%E5%AE%9E%E9%AA%8C.md

· https://blog.csdn.net/slwhy/article/details/78876237

· https://github.com/CUCCS/2015-linux-public-yangyisama/blob/master/Exp1/Exp1.md

· https://blog.csdn.net/flowrush/article/details/79943387