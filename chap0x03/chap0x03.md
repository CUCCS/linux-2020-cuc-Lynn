# 实验三——动手实战systemd

## 实验环境

+ **Ubuntu 18.04 server 64bit**
+ **asciinema终端录屏工具**

## 实验要求

+ **学习systemd开机自启动管理机制**
+ **动手实战systemd并完成自查清单**

## 实验过程

##### **apache安装+系统管理**

 [![asciicast Part1](https://asciinema.org/a/kdFCkIM6Tw0hQHWeMEwjonEa2.svg)](https://asciinema.org/a/kdFCkIM6Tw0hQHWeMEwjonEa2)

##### **Unit状态及管理**

[![asciicast Part2](https://asciinema.org/a/wC0pD9HM5NL0ZFsjCyu0zC5w2.svg)](https://asciinema.org/a/wC0pD9HM5NL0ZFsjCyu0zC5w2)

##### **Unit的配置文件**

[![asciicast Part3](https://asciinema.org/a/wmBCzwlZQYAPyNrm2U4J9Kr0K.svg)](https://asciinema.org/a/wmBCzwlZQYAPyNrm2U4J9Kr0K)

##### **Target+日志管理**

[![asciicast Part4](https://asciinema.org/a/OAgCFuQ72xEYvSIsPOlKrcl0Z.svg)](https://asciinema.org/a/OAgCFuQ72xEYvSIsPOlKrcl0Z)

##### **实战篇**

[![asciicast Part5](https://asciinema.org/a/H07yZI6Hsa4XhMreEU58hgKac.svg)](https://asciinema.org/a/H07yZI6Hsa4XhMreEU58hgKac)

## 自查清单

- **1.如何添加一个用户并使其具备sudo执行程序的权限？**
```bash
- 添加新用户: `adduser username`  #创建时会生成家目录并要求设置密码

- 使其具备sudu执行权限: 
    方法一： `sudo usermod -a -G sudo username`  #修改用户附属组
    方法二： 修改`/etc/sudoers`文件，将用户名添加到sudo权限组
    
```
- **2.如何将一个用户添加到一个用户组？**
```bash
#一定要加-a 否则会用户离开其他用户组，仅仅做为这个用户组groupA的成员

sudo usermod -a -G groupA username
```

- **3.如何查看当前系统的分区表和文件系统详细信息？**
```bash
    df -h   #查看硬盘使用情况及文件系统的挂载位置
    sudo fdisk -l   #查看硬盘分区基本信息
    sudo fdisk filesystem #查看文件系统详细信息
```
- **4.如何实现开机自动挂载Virtualbox的共享目录分区？**
```bash
-VirtuakBox设置-共享文件夹-右侧添加-编辑共享文件夹路径及名称(为codes)

# 新建挂载目录
mkdir ~/shared

# 挂载文件夹
sudo mount -t vboxsf codes ~/shared

# 修改配置文件,将共享目录的信息写入到/etc/fstab文件
sudo gedit /etc/fstab
codes   ~/shared    vboxsf  rw,auto 0   0  #添加内容,第一个项目为共享文件夹名称，第二个项目为挂载目录
```
- **5.基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？**
```bash
#查看逻辑卷信息
lvdisplay 或 lvs

#逻辑卷扩容(/dev/app/app_lv为逻辑卷)
lvextend -L +1G /dev/app/app_lv

#缩减LV容量
lvreduce -L -1G /dev/app/app_lv
```
- **6.如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？**
```bash
- 修改systemd-networkd.service配置文件中的[Service]区块

ExecStartPost = x脚本   #网络连通时运行X脚本

ExecStopPost = y脚本    #断开时运行y脚本

- #重载修改过的配置文件
sudo systemctl daemon-reload

- #重新启动，让修改生效
sudo systemctl restart systemd-networkd.service
```


- **7.如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？**
```bash
#修改配置文件
sudo systemctl vi + service类型脚本文件

将[Service]区块中的`Restart`字段设为`always`

#重载修改过的配置文件
sudo systemctl daemon-reload

#重新启动，让修改生效
sudo systemctl restart .service文件
```

## 参考资料

+ [Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

+ [Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)

+ [开机自动挂载共享目录](https://www.jb51.net/article/170330.htm)

+ [逻辑卷增加与扩容](https://blog.csdn.net/j_ychen/article/details/79404197?depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-3&utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-3)

+ [systemd-networkd](https://www.freedesktop.org/software/systemd/man/systemd-networkd.service.html)