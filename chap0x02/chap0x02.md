# Linux实验二

## 实验环境

-  **Ubuntu 18.04 server 64bit**

- **asciinema终端录屏工具**
  
## 实验要求

- **注册asciinema账号，并在本地安装配置**

-  **完成asciinema auth，并在asciinema成功关联本地账号和在线账号**

- **上传vimtutor操作全程录像**

- **vimtutor完成后的自查清单**

## 实验过程

- #### 安装asciinema,关联账号
  
  > sudo apt update
  > sudo apt install asciinema

  > asciinema auth
    
  
- #### vimtutor全程操作录像
   
  ##### Lesson1

    [![asciicast](https://asciinema.org/a/8a7gWlrkvLtVaCY3hNvup8lzH.svg)](https://asciinema.org/a/8a7gWlrkvLtVaCY3hNvup8lzH)

  ##### Lesson2

    [![asciicast](https://asciinema.org/a/EShyWFMRoZpyyPSKAlOgedUBv.svg)](https://asciinema.org/a/EShyWFMRoZpyyPSKAlOgedUBv)

  ##### Lesson3
  
    [![asciicast](https://asciinema.org/a/iSUexodeuS3c1m0lUNNwYAUlw.svg)](https://asciinema.org/a/iSUexodeuS3c1m0lUNNwYAUlw)

  ##### Lesson4
  
    [![asciicast](https://asciinema.org/a/L9NfF229LcnkJBW7oXjfq2J6O.svg)](https://asciinema.org/a/L9NfF229LcnkJBW7oXjfq2J6O)

  ##### Lesson5

    [![asciicast](https://asciinema.org/a/e7QNnJPC96huSLtsFvyy4b0Cv.svg)](https://asciinema.org/a/e7QNnJPC96huSLtsFvyy4b0Cv)

  ##### Lesson6

    [![asciicast](https://asciinema.org/a/hz0IWRTZpVViNoxdNU0fZ3cHU.svg)](https://asciinema.org/a/hz0IWRTZpVViNoxdNU0fZ3cHU)

  ##### Lesson7

    [![asciicast](https://asciinema.org/a/CLkSX9CQXSr88HcZJmIUK06VU.svg)](https://asciinema.org/a/CLkSX9CQXSr88HcZJmIUK06VU)

- #### 自查清单
  
    ##### 1、vim有哪几种工作模式

      - Normal mode 普通模式：vim启动后的默认模式，可移动光标，删除文本等等
      - Insert mode 插入模式：从普通模式通过i a A o s等进入，按'ESC'退出插入模式切换至普通模式
      - Command line mode 命令行模式：在命令行模式中可以输入会被解释成并执行的文本，如'：''/''?''!'命令执行后回到Nomal mode
      - Select mode 选择模式：在该模式中可以用鼠标或者光标键高亮选择文本
      - Vitual mode 可视模式：与普通模式类似，但移动命令会扩大高亮的文本区域。高亮区域可以是字符、行或者是一块文本。当执行一个非移动命令时，命令会被执行到这块高亮的区域上

    ##### 2、Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？

      - 一次向下移动10行: '10j'
      - 移至文件开始: 'gg'
      - 移至文件结束行: 'G'
      - 快速移至第N行: 'NG' 或 'Ngg'
    

    ##### 3、Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？

      - 删除单个字符: 'x'
      - 删除单个单词: 'dw'或'de'
      - 从当前光标删除到行尾: 'd$'
      - 删除单行: 'dd'
      - 删除当前行开始向下N行: 'Ndd'

    ##### 4、如何在vim中快速插入N个空行？如何在vim中快速输入80个-？

      - 插入N个空行: 'No'
      - 快速插入80个-: 普通模式下输入'80i-'然后'ESC' (按i后，会进入插入模式，然后只输入一个-字符，再按 Esc 键后vim会自动输入79个-字符，得到80个连续的-字符)

    ##### 5、如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？

      - 撤销最近一次操作: 'u'
      - 重做最后一次被撤销的操作: 'CTRL-R'

    ##### 6、vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？

      - 剪切粘贴单个字符: 'x'然后'p'
      - 单个单词: 'dw'然后'p'
      - 单行: 'dd'然后'p'
      - 相似的复制粘贴操作:  'v'进入可视模式，移动光标选择需要复制的内容，'y'复制文本，移动光标至指定位置'p'粘贴文本

    ##### 7、为了编辑一段文本你能想到哪几种操作方式（按键序列）？

      - 插入操作: 'i''I''a''A''o''O'
      - 删除操作: 'x''dw''d$''dd'
      - 复制粘贴: 'v''y''p'
      - 撤销与重做: 'u''CTRL-R'
      - 保存更改: ':w'
      - 退出: ':q!'':wq!'

    ##### 8、查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？

      - 'CTRL-g'

    ##### 9、在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？

      - 关键词搜索:
         - 从上往下(向后)找: \keyword
         - 从下往上(向前)找: ?keyword
         - 查找下一个: 'n' 找上一个: 'N'
      - 设置忽略大小写匹配搜索: set ic
      - 将匹配结果高亮显示: set hls is
      - 匹配到的关键词进行批量替换:
         - 替换当前行第一个字符: 's/old/new/'
         - 替换m行与n行之间所有字符: 'm,ns/old/new/g'
         - 全局替换: '%s/old/new/g'

    ##### 10、在文件中最近编辑过的位置来回快速跳转的方法？

      'ctrl-o' 'ctrl-i'

    ##### 11、如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }

       光标停至某半括号处，按'%'，即跳转到对应匹配的括号

    ##### 12、在不退出vim的情况下执行一个外部程序的方法？

       !command

    ##### 13、如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？
      
      - :help[快捷键名] + enter
      - 在两个不同分屏窗口移动光标: CTRL-W CTRL-W



