//
//  ViewController.m
//  02-获取通讯录(AdressBook)
//
//  Created by 冯小宁 on 15/8/21.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import <AddressBook/AddressBook.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取授权状态
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    // 2.如果用户已经授权
    if(status != kABAuthorizationStatusAuthorized)  return;
    
    // 3.创建通讯录对象
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // 4.从通讯录对象中,将所有的联系人拷贝出来
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    // 5.遍历所有的联系人(每个联系人都是一条记录)
    CFIndex peopleCount = CFArrayGetCount(peopleArray);
    for(CFIndex i=0; i<peopleCount; ++i) {
        // 6.获取联系人
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        
        // 7.获取姓名
        NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSLog(@"%@ %@", lastName, firstName);
    }
    
    // 8.释放不再使用的对象
    CFRelease(peopleArray);
    CFRelease(addressBook);
}

@end
