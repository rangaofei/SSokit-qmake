# SSokit

Now this support MacOS and Win system.

The win version download address:
[http://ssokit.rangaofei.cn/SSokit_1.1.2.7z](http://ssokit.rangaofei.cn/SSokit_1.1.2.7z)

Just download the zip file and unzip it, find SSokit.exe file,and double click then it will run ok;

The mac version download address:

[http://ssokit.rangaofei.cn/SSokit_1.1.2.dmg](http://ssokit.rangaofei.cn/SSokit_1.1.2.dmg)

Just download the dmg file and double click then it will run ok,also ,you can copy it to you `~/Application` dir.

It can used be as a Tcp/Udp server,the user interface is just like this :

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/1_en.png)

or it can be used as a TcpClient/UdpClient,the user interface is just like this :

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/2_en.png)

And now you can active the Checkbox under the bufData line,you can see an advance setting view.

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/3_en.png)

Then you can setting the headers format,here is a brief introduction

`Header` It is some byte will prepend at first of your buf

`Length` three styles,when `None` selected, the buf+tailer'length will not be added after the header;when `Short` selected,the buf+tailer'length will be added added after the header and its byte will be 2;when `Int` selected, the buf+tailer'length will be added after the header and its byte will be 4

`Endian` just as the littleEndian and bigEndian of the Length.

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/4_en.png)

Be happy with it.
**This app is a advanced qml project for sokit
[https://github.com/sinpolib/sokit](https://github.com/sinpolib/sokit)**

# SSokit

SSokit现在已经支持win系统和mac系统

Windows版本下载地址:
[hhttp://ssokit.rangaofei.cn/SSokit_1.1.2.7z](http://ssokit.rangaofei.cn/SSokit_1.1.2.7z)

下载后直接解压到一个文件夹，双击SSokit.exe即可使用

MacOS版本下载地址:

[http://ssokit.rangaofei.cn/SSokit_1.1.2.dmg](http://ssokit.rangaofei.cn/SSokit_1.1.2.dmg)

下载后直接双击dmg文件即可使用，为了方便使用你也可以将它复制到`Application`中

可以用作TCP/UDP服务端:

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/1_en.png)

也可以用作TCP/UDP客户端:

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/2_en.png)

你可以选中buf下的高级选项，会显示出header的设置view

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/3_en.png)

现在你可以定制你自己的header了

- `Header` 添加到发送信息的最开始，可以输入16进制或者asc码

- `Length` 选择`None`不会添加buf+tailer的长度到header之后；选择`Short`将会添加一个占2byte的短整型buf+tailer的长度到header之后，buf之前；选择`Int`将会添加一个占4byte的整型buf+header的长度到header之后，buf之前。

`Endian` 代表上边的length字节序采用的是大端模式还是小端模式

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/4_en.png)

欢迎issue或者询问

qq：876038559

**This app is a advanced qml project for sokit
[https://github.com/sinpolib/sokit](https://github.com/sinpolib/sokit)**

