am kill com.android.chrome
am force-stop com.android.chrome
ps | grep chrome
am start com.android.chrome/com.google.android.apps.chrome.Main
am kill com.android chrom
tap 300 500
input tap 100 500
input tap 500 1000
input tap 360 900
input tap 382 857
input tap 254 663
input tap 353 1240
input tap 365 732
input text 12345678


###################################################################################################################################################
ADB命令连接逍遥模拟器
http://t.zoukankan.com/pu369-p-13184387.html

旧手机只升级到android 6.0， 一些APP显示不正常。准备用模拟器试试。

0、从官网下载逍遥模拟器，安装。我选了工作室版。

启动后提示没开VT   ，在BIOS中打开VT

重启，到逍遥市场下载安装了一个APP，正常运行了。

1、先进入逍遥模拟器安装目录（MEmu文件夹下），如：D:Program FilesMicrovirtMEmu

2、在CMD下输入：adb connect 127.0.0.1:21503  

我输入后提示：already connected to 127.0.0.1:21503

3、查看是否连接到模拟器，输入命令：adb devices

我输入后提示以下两行：

List of devices attached
127.0.0.1:21503 device

4、OK，连接成功

5.查询模拟器信息：adb devices -l

6..dumpsys:查看包名和activity

（1）启动要查看的程序
（2）命令行输入：adb shell dumpsys window w |findstr / |findstr name=

(3) 使用adb shell dumpsys window | findstr mCurrentFocus  命令查看当前运行的包名和Activity更清晰一些。

7、发现在没有  打开模拟器开发者模式 -》USB调试模式  的情况下，也可以正常运行adb命令。

8、想拿指针的坐标位置，但在【设置】 【开发者选项】里面打开【指针位置】后，不起作用。后来发现：

最新版本的逍遥模拟器版本7.0.2已经有个【显示坐标】的功能了！在【窗口设定】->【显示坐标】里面进行设置

 9、某APP检测到root开启就不运行。7.2.1版关闭root的位置在:右侧   【设置】-【引擎】-ROOT模式

10、模拟器和反模拟器是一对永存的矛盾，这篇可参考一下：https://blog.csdn.net/tianshuai4317618/article/details/78834683

补充：

11、运行adb没反应，原来是在win10环境变量中指向了以前安装的adb.exe;

可以用第2步的命令来连接;或修改环境变量指向逍遥模拟器安装目录下的adb.exe

###################################################################################################################################################
https://zhuanlan.zhihu.com/p/164504374


adb，即 Android Debug Bridge，它是 Android 开发/测试人员不可替代的强大工具，也是 Android 设备玩家的好玩具。

它是一种可以用来操作手机设备或模拟器的命令行工具。它存在于 sdk/platform-tools 目录下。虽然现在 Android Studio 已经将大部分 adb 命令以图形化的形式实现了，但是了解一下还是有必要的。



把常用的 adb 指令汇总了一下，如下：

adb devices # 显示当前连接的 adb 设备，会打印设备的序列号及其对应的状态

adb shell # 进入 Android 系统的 shell 模式

adb -s [系列号] shell # 指定机器进入它的 shell 模式，在 PC 连接多台 Android 设备时常会用到



adb root # 切换到 root 用户

adb remount # 重新挂载，需要在 root 后执行，执行后可写 system 分区



adb logcat -c # 清除 log 缓存

adb logcat # 打印机器 log 日志

adb logcat > [PC本地文件名] # 读取机器的 log 并将 log 保存到指定的 PC 文件中



adb install [APK路径]：

adb install -r [APK路径]：

adb uninstall [应用包名]：

adb pull [android端文件名] [PC本地路径]

adb push [PC端文件名] [android 端路径]



adb shell wm size # 查看屏幕分辨率

adb shell am start -n [包名]/[Activity名] # 启动指定的 Activity，这里 Activity名是包括包名在内的

adb shell am startservice [包名]/[Service名] # 启动指定的 Service，这里 Service也包括包名

adb shell am broadcast -a [广播action] # 发送指定 action 的广播

adb shell pm list packages # 显示设备里面所有应用的包名

adb shell service list # 显示当前运行的系统服务

adb shell dumpsys activity top # 显示当前最前端的 Activity

adb shell cat /proc/cpuinfo # 显示设备的CPU信息

adb shell cat /proc/meminfo # 显示设备的内存使用情况



adb shell screencap [文件名] # 屏幕截图并保存到对应的文件

adb shell screenrecord [文件名] # 屏幕录屏并保存到对应的文件



adb shell input text [字符串] # 将字符串输入到当前获取焦点的输入框

adb shell input tap [x坐标] [y坐标] # 模拟触摸屏幕指定坐标

adb shell input swipe [起始x坐标] [起始y坐标] [目标x坐标] [目标y坐标] [耗时] # 模拟滑动屏幕事件

adb shell input keyevent [keycode] # 模拟点击实体按键



大多数 Android 设备只有一个 USB 口，有时调试外设的时候，需要通过 USB 跟 Android 设备相连，此时就没有办法连接 PC 抓 log 了，这样会给调试带来很大的麻烦。

使用 wifi 的方式无线连接 adb，可以完美解决这个问题：

1、通过 adb shell netcfg 可查看设备 IP 地址（假设为 1.1.1.1）

2、PC 通过 ping 设备 IP 地址可查看是否在同一网段（ping 1.1.1.1）

3、执行连接：adb connect 1.1.1.1

4、如果提示失败，则用 adb tcpip 模式重启 adb：adb tcpip 5555

5、再重新连接设备 IP

然后，连接成功后就可以开始愉快地调试啦~




###################################################################################################################################################
https://blog.csdn.net/weixin_43927138/article/details/90477966


adb介绍：
Android Debug Bridge（安卓调试桥） tools。它就是一个命令行窗口，用于通过电脑端与模拟器或者是设备之间的交互。
ADB是一个C/S架构的应用程序，由三部分组成：
运行在pc端的adb client：
命令行程序”adb”用于从shell或脚本中运行adb命令。首先，“adb”程序尝试定位主机上的ADB服务器，如果找不到ADB服务器，“adb”程序自动启动一个ADB服务器。接下来，当设备的adbd和pc端的adb server建立连接后，adb client就可以向ADB servcer发送服务请求；
运行在pc端的adb server：
ADB Server是运行在主机上的一个后台进程。它的作用在于检测USB端口感知设备的连接和拔除，以及模拟器实例的启动或停止，ADB Server还需要将adb client的请求通过usb或者tcp的方式发送到对应的adbd上；
运行在设备端的常驻进程adb demon (adbd)：
程序“adbd”作为一个后台进程在Android设备或模拟器系统中运行。它的作用是连接ADB服务器，并且为运行在主机上的客户端提供一些服务。

adb下载及安装：
一共有两种方法：
首先第一种就是最简单的方法，只下载adb压缩包去解压即可：链接：https://pan.baidu.com/s/1SKu24yyShwg16lyIupO5VA 提取码：ih0i
（备注：如果下载放入到D盘去解压，打开dos窗口那么就要进入到D盘，然后再去执行adb命令，输入adb查看它是否安装成功）
第二种方法前提是已安装了Android Studio，它本身带有adb命令，如果配置好的Android Studio 一般都是可以直接调用adb命令的；如果不行，找到adb在SDK里的绝对路径，放入环境变量path中（绝对路径不带入adb.exe）

然后输入adb version 查看版本 可以看出是否安装成功，如下就已经成功了。

启动 adb server 命令：adb start-server
停止 adb server 命令：adb kill-server
查询已连接设备/模拟器：adb devices
该命令经常出现以下问题：
offline —— 表示设备未连接成功或无响应；
device —— 设备已连接；
no device —— 没有设备/模拟器连接；
List of devices attached 设备/模拟器未连接到 adb 或无响应
USB连接：
在手机“设置”-“关于手机”连续点击“版本号”7 次，可以进入到开发者模式；然后可以到“设置”-“开发者选项”-“调试”里打开USB调试以及允许ADB的一些权限；连接时手机会弹出“允许HiSuite通过HDB连接设备”点击允许/接受即可；
驱动也是必须安装的，可以用豌豆荚，或者是手机商家提供的手机助手，点进去驱动器安装即可（部分电脑双击无法直接进入到驱动器里，可以使用右键找到进入点击即可）

再次输入adb devices验证是否连接成功，连接成功即如下图：


也可以进行无线连接，其中非root权限也需借助USB线进行操作，完成后即可断开USB线；root用户可以进行无线连接，具体步骤可以参考网上资源。
**查看是否有root权限：**输入adb shell，然后输入su KaTeX parse error: Expected 'EOF', got '#' at position 5: 如果变为#̲则成功，如果仍为则未有root权限；恢复命令：adb unroot
查看应用列表：
查看所有应用列表：adb shell pm list packages
查看系统应用列表：adb shell pm list packages -s
查看第三方应用列表：adb shell pm list packages -3：

安装apk：adb install “-lrtsdg” “path_to_apk”
“-lrtsdg”：
-l：将应用安装到保护目录 /mnt/asec；
-r：允许覆盖安装；
-t：允许安装 AndroidManifest.xml 里 application 指定 android:testOnly=“true” 的应用；
-s：将应用安装到 sdcard；
-d：允许降级覆盖安装；
-g：授予所有运行时权限；
path_to_apk：apk的绝对路径。
示例安装淘宝apk：adb install -t C:data/local/tmp/taobao.apk

卸载apk：adb shell pm uninstall -k “packagename”
“packagename”：表示应用的包名，以下相同；
-k 参数可选，表示卸载应用但保留数据和缓存目录。
示例卸载 手机淘宝：adb uninstall com.taobao.taobao

清除应用数据与缓存命令：adb shell pm clear “packagename”
相当于在设置里的应用信息界面点击「清除缓存」和「清除数据」。
示例：adb shell pm clear com.taobao.taobao 表示清除 手机淘宝数据和缓存。

Android四大组件有Activity，Service服务，Content Provider内容提供，BroadcastReceiver广播接收器，具体不做多讲，常用的有以下：
查看前台 Activity命令：adb shell dumpsys activity activities | findstr “packagename”
查看正在运行的 Services命令：adb shell dumpsys activity services “packagename” 其中参数不是必须的，指定 “packagename” 表示查看与某个包名相关的 Services，不指定表示查看所有 Services。
查看应用详细信息命令：adb shell dumpsys package “packagename”
调起 Activity命令格式：adb shell am start [options]
例如：adb shell am start -n com.tencent.mm/.ui.LauncherUI表示调起微信主界面

调起 Service命令格式：adb shell am startservice [options]
例如：adb shell am startservice -n
com.tencent.mm/.plugin.accountsync.model.AccountAuthenticatorService 表示调起微信的某 Service。
强制停止应用命令：adb shell am force-stop “packagename”
例如强制停止淘宝：adb shell am force-stop com.taobao.taobao

模拟按键指令:adb shell input keyevent keycode 不同的 keycode有不同的功能：

keycode	含义
3	HOME 键
4	返回键
5	打开拨号应用
6	挂断电话
26	电源键
27	拍照（需要在相机应用里）
61	Tab键
64	打开浏览器
67	退格键
80	拍照对焦键
82	菜单键
85	播放/暂停
86	停止播放
92	向上翻页键
93	向下翻页键
111	ESC键
112	删除键
122	移动光标到行首或列表顶部
123	移动光标到行末或列表底部
124	插入键
164	静音
176	打开系统设置
207	打开联系人
208	打开日历
209	打开音乐
220	降低屏幕亮度
221	提高屏幕亮度
223	系统休眠
224	点亮屏幕
231	打开语音助手
276	如果没有 wakelock 则让系统休眠
滑动解锁：如果锁屏没有密码，是通过滑动手势解锁，那么可以通过 input swipe 来解锁。
命令:adb shell input swipe 300 1000 300 500
(其中参数 300 1000 300 500 分别表示起始点x坐标 起始点y坐标 结束点x坐标 结束点y坐标。)
点击内容
adb shell input tap
该命令是用于向设备发送一个点击操作的指令，参数是 坐标
adbshell input tap 100 100
输入文本:在焦点处于某文本框时，可以通过 input 命令来输入文本。
命令：adb shell input text *** (***即为输入内容)

打印日志：
Android 的日志分为如下几个优先级（priority）：
V —— Verbose（最低，输出得最多）
D —— Debug
I —— Info
W —— Warning
E —— Error
F—— Fatal
S —— Silent（最高，啥也不输出）
按某级别过滤日志则会将该级别及以上的日志输出。
比如，命令：adb logcat *:W 会将 Warning、Error、Fatal 和 Silent 日志输出。
（注： 在 macOS 下需要给 :W 这样以 作为 tag 的参数加双引号，如 adb logcat “:W”，不然会报错 no matches found: :W。）

adb logcat	打印当前设备上所有日志
adb logcat *:W	过滤打印严重级别W及以上的日志
adb logcat l findstr ***> F:\log.txt	把仅含***的日志保存到F盘的log.txt文件中
adb logcat -c	清除屏幕上的日志记录
adb logcat -c && adb logcat -s ActivityManager l grep "Displayed”	客户端程序启动时间获取日志
adb logcat > F:\log.txt	打印当前设备上所有日志保存到F盘的log.txt文件中
adb logcat l findstr ***	打印过滤仅含***的日志
adb logcat l findstr ***> F:\log.txt	把仅含***的日志保存到F盘的log.txt文件中
按 tag 和级别过滤日志：命令：adb logcat ActivityManager:I MyApp:D *:S
表示输出 tag ActivityManager 的 Info 以上级别日志，输出 tag MyApp 的 Debug 以上级别日志，及其它 tag 的 Silent 级别日志（即屏蔽其它 tag 日志）。
日志格式可以用：adb logcat -v 选项指定日志输出格式。
日志支持按以下几种 ：默认格式brief、process、tag、raw、time、long
指定格式可与上面的过滤同时使用。比如：adb logcat -v long ActivityManager:I *:S
清空日志：adb logcat -c
内核日志：adb shell dmesg

查看设备情况：
查看设备信息型号命令：adb shell getprop ro.product.model
电池状况命令：adb shell dumpsys battery
屏幕分辨率命令：adb shell wm size
如果使用命令修改过，那输出可能是：
Physical size: 1080x1920
Override size: 480x1024
表明设备的屏幕分辨率原本是 1080px * 1920px，当前被修改为 480px * 1024px。
屏幕密度命令：adb shell wm density
如果使用命令修改过，那输出可能是：
Physical density: 480
Override density: 160
表明设备的屏幕密度原来是 480dpi，当前被修改为 160dpi。
显示屏参数：adb shell dumpsys window displays
输出示例：
WINDOW MANAGER DISPLAY CONTENTS (dumpsys window displays)
Display: mDisplayId=0
init=1080x1920 420dpi cur=1080x1920 app=1080x1794 rng=1080x1017-1810x1731
deferred=false layoutNeeded=false
其中 mDisplayId 为 显示屏编号，init 是初始分辨率和屏幕密度，app 的高度比 init 里的要小，表示屏幕底部有虚拟按键，高度为 1920 - 1794 = 126px 合 42dp。
android_id查看命令：adb shell settings get secure android_id
查看Android 系统版本：adb shell getprop ro.build.version.release
查看设备ip地址：adb shell ifconfig | grep Mask或者adb shell netcfg
查看CPU 信息命令：adb shell cat /proc/cpuinfo
查看内存信息命令：adb shell cat /proc/meminfo
更多硬件与系统属性：
设备的更多硬件与系统属性可以通过如下命令查看：adb shell cat /system/build.prop
单独查看某一硬件或系统属性：adb shell getprop <属性名>

属性名	含义
ro.build.version.sdk	SDK 版本
ro.build.version.release	Android 系统版本
ro.product.model	型号
ro.product.brand	品牌
ro.product.name	设备名
ro.product.board	处理器型号
persist.sys.isUsbOtgEnabled	是否支持 OTG
dalvik.vm.heapsize	每个应用程序的内存上限
ro.sf.lcd_density	屏幕密度
rro.build.version.security_patch	Android 安全补丁程序级别
修改设置：
修改设置之后，运行恢复命令有可能显示仍然不太正常，可以运行 adb reboot 重启设备，或手动重启。
修改设置的原理主要是通过 settings 命令修改 /data/data/com.android.providers.settings/databases/settings.db 里存放的设置值。
修改分辨率命令：adb shell wm size 480x1024 恢复原分辨率命令：adb shell wm size reset
修改屏幕密度命令：adb shell wm density 160 表示将屏幕密度修改为 160dpi；恢复原屏幕密度命令：adb shell wm density reset
修改显示区域命令：adb shell wm overscan 0,0,0,200 四个数字分别表示距离左、上、右、下边缘的留白像素，以上命令表示将屏幕底部 200px 留白。恢复原显示区域命令：adb shell wm overscan reset
关闭 USB 调试模式命令：adb shell settings put global adb_enabled 0 需要手动恢复：「设置」-「开发者选项」-「Android 调试」

状态栏和导航栏的显示隐藏：adb shell settings put global policy_control
可由如下几种键及其对应的值组成，格式为 =:=。

key	含义
immersive.full	同时隐藏
immersive.status	隐藏状态栏
immersive.navigation	隐藏导航栏
immersive.preconfirms	?
这些键对应的值可则如下值用逗号组合：

value	含义
apps	所有应用
*	所有界面
packagename	指定应用
-packagename	排除指定应用
举例：adb shell settings put global policy_control immersive.full=* 表示设置在所有界面下都同时隐藏状态栏和导航栏。
举例：adb shell settings put global policy_control immersive.status=com.package1,com.package2:immersive.navigation=apps,-com.package3 表示设置在包名为 com.package1 和 com.package2 的应用里隐藏状态栏，在除了包名为 com.package3 的所有应用里隐藏导航栏。
恢复正常模式：adb shell settings put global policy_control null

实用功能：
截图保存到电脑：adb exec-out screencap -p > sc.png
然后将 png 文件导出到电脑：adb pull /sdcard/sc.png
录制屏幕：录制屏幕以 mp4 格式保存到 /sdcard：adb shell screenrecord /sdcard/filename.mp4 需要停止时按 Ctrl-C，默认录制时间和最长录制时间都是 180 秒。
如果需要导出到电脑：adb pull /sdcard/filename.mp4
挂载、查看连接过的 WiFi 密码、开启/关闭 WiFi、设置系统日期和时间都需要root权限，不做多说。

使用 Monkey 进行压力测试：Monkey 可以生成伪随机用户事件来模拟单击、触摸、手势等操作，可以对正在开发中的程序进行随机压力测试。
简单用法：adb shell monkey -p < packagename > -v 500 表示向 指定的应用程序发送 500 个伪随机事件。

查看进程：adb shell ps
查看实时资源占用情况：adb shell top
查看进程 UID：adb shell dumpsys package | grep userId=
————————————————
版权声明：本文为CSDN博主「Dongs丶」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/weixin_43927138/article/details/90477966