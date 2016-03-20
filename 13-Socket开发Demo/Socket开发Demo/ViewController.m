//
//  ViewController.m
//  Socket开发Demo
//
//  Created by 冯小宁 on 15/9/11.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

/**
 1.打开12345端口
 nc -lk 12345
 
 2.send方法是阻塞式的，在终端输入信息才能界面才能显示出来内容
 */


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *hostField;
@property (weak, nonatomic) IBOutlet UITextField *hostPortField;
@property (weak, nonatomic) IBOutlet UITextField *serverMsgField;
@property (weak, nonatomic) IBOutlet UITextField *clientMsgField;


/** clientSocket */
@property (nonatomic, assign) int clientSocket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self connect:nil];
}

- (void)createConnection:(NSString *)hostName port:(NSInteger)port
{
    // 1.创建 socket
    /**
     参数
     
     domain:    协议域，AF_INET->IPV4
     type:      Socket 类型，SOCK_STREAM(TCP)/SOCK_DGRAM(报文 UDP)
     protocol:  IPPROTO_TCP，如果传入0，会自动根据第个参数，选择合适的协议
     
     返回值
     socket > 0 就成功
     */
    self.clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    // 2.连接到服务器
    /**
     参数
     1> 客户端socket
     2> 服务器地址结构体指针
     3> 结构体数据长度
     返回值
     0 成功/其他 错误代号
     */
    struct sockaddr_in serveAddr;
    serveAddr.sin_family = AF_INET;
    // 端口
    serveAddr.sin_port = htons(port);
    // 地址
    serveAddr.sin_addr.s_addr = inet_addr(hostName.UTF8String);
    
    int connResult = connect(self.clientSocket, (const struct sockaddr*)&serveAddr, sizeof(serveAddr));
    if(connResult == 0) {
        NSLog(@"连接成功");
    } else {
        NSLog(@"连接失败");
        return;
    }
}

- (NSString *)sendAndRecvMsg:(NSString *)msg msgLen:(NSInteger)len
{
    // 3.发送数据到服务器
    /**
     参数
     1> 客户端socket
     2> 发送内容地址
     3> 发送内容长度
     4> 发送方式标志，一般为0
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
     */
    send(self.clientSocket, msg.UTF8String, strlen(msg.UTF8String), 0);

    // 4.从服务器接收数据
    /**
     参数
     1> socket
     2> 接收数据的缓冲区地址，需要提前准备
     3> 缓冲区长度
     4> 标记，0，阻塞式
     
     返回值
     如果成功，则返回接收到的字节数
     */
    uint8_t buffer[1024] = {0};
    ssize_t recvLen = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    
    // 将buffer中数据转换成NSString
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    NSString *serverMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", serverMsg);
    return serverMsg;
}

- (void)closeConnection
{
    // 5.关闭
    /**
     长连接：连上就一直聊！通常用于 QQ，即时通讯，效率高！
     短连接：通讯一次，马上断开，下一次再次建立连接，效率低
     */

    close(self.clientSocket);
}

- (IBAction)connect:(id)sender {
    NSString *hostName = self.hostField.text;
    int port = (int)[self.hostPortField.text integerValue];
    [self createConnection:hostName port:port];
}

- (IBAction)sendMsg:(id)sender {
    NSString *msg = [self.clientMsgField.text stringByAppendingString:@"\n"];
    self.serverMsgField.text = [self sendAndRecvMsg:msg msgLen:msg.length];
}
@end
