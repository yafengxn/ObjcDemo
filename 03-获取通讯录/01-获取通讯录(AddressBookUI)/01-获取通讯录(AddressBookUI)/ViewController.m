//
//  ViewController.m
//  01-获取通讯录(AddressBookUI)
//
//  Created by 冯小宁 on 15/8/21.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "ViewController.h"
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController () <ABPeoplePickerNavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.创建选择联系人的界面
    ABPeoplePickerNavigationController *ppnc = [[ABPeoplePickerNavigationController alloc] init];
    
    // 2.设置代理
    ppnc.peoplePickerDelegate = self;
    
    // 3.弹出选择联系人界面
    [self presentViewController:ppnc animated:YES completion:nil];
}

#pragma mark - 实现ABPeoplePickerNavigationControllerDelegate的代理方法
// 选中某一个联系人的时候,会执行该代理方法
// 如果实现了该方法,那么就不会进入联系人的详细界面
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    // 1.获取选中联系人的姓名
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName  = ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSLog(@"%@ %@", firstName, lastName);
    
    // 2.获取联系人的电话号码
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex count = ABMultiValueGetCount(phones);
    for(CFIndex i=0; i<count; ++i) {
        NSString *phoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
        NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
        NSLog(@"label:%@ value:%@", phoneLabel, phoneValue);
    }
    
    // 3.释放不在使用对象
    CFRelease(phones);
}

// 选择某一个联系人的某一个属性时,会执行该方法
// property选中的属性
// identifier : 每一个属性都由一个对应的标示
// 如果实现了该方法,那么选中一个联系人的属性时,就会退出控制器,不会进入下一个页面
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    NSLog(@"选中了某一个联系人的某一个属性");
}

// 点击了取消按钮会执行该方法
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    NSLog(@"peoplePickerNavigationControllerDidCancel");
}

@end
