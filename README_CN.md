# SSokit

SSokit现在已经支持win系统和mac系统

Windows版本下载地址:
[https://coding.net/s/1565b4e8-f11f-4517-b14c-4c5c17614130](https://coding.net/s/1565b4e8-f11f-4517-b14c-4c5c17614130)

下载后直接解压到一个文件夹，双击SSokit.exe即可使用

MacOS版本下载地址:

[https://coding.net/s/6257256e-9369-44e0-8a6e-d9b56db18dfa](https://coding.net/s/6257256e-9369-44e0-8a6e-d9b56db18dfa)

下载后直接双击dmg文件即可使用，为了方便使用你也可以将它复制到`Application`中

可以用作TCP/UDP服务端:

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/1_en.png)

也可以用作TCP/UDP客户端:

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/2_en.png)

你可以选中buf下的高级选项，会显示出header的设置view

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/3_en.png)

现在你可以定制你自己的header了

- `Header` 添加到发送信息的最开始，可以输入16进制或者asc码

- `Length` 选择`None`不会添加buf+header的长度到header之后；选择`Short`将会添加一个占2byte的短整型buf+header的长度到header之后，buf之前；选择`Int`将会添加一个占4byte的整型buf+header的长度到header之后，buf之前。

`Endian` 代表上边的length字节序采用的是大端模式还是小端模式

![](https://github.com/rangaofei/SSokit-qmake/blob/master/img/4_en.png)

欢迎issue或者询问

qq：876038559

**This app is a advanced qml project for sokit
[https://github.com/sinpolib/sokit](https://github.com/sinpolib/sokit)**
