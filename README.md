# SSokit

Now this support MacOS and Win system.

The win version download address:
[https://coding.net/s/1565b4e8-f11f-4517-b14c-4c5c17614130](https://coding.net/s/1565b4e8-f11f-4517-b14c-4c5c17614130)

Just download the zip file and unzip it, find SSokit.exe file,and double click then it will run ok;

The mac version download address:

[https://coding.net/s/6257256e-9369-44e0-8a6e-d9b56db18dfa](https://coding.net/s/6257256e-9369-44e0-8a6e-d9b56db18dfa)

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
