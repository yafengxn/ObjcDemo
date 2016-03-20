//
//  XNTableViewController.m
//  AutoCalcHeight
//
//  Created by 冯小宁 on 15/9/18.
//  Copyright (c) 2015年 yafengxn. All rights reserved.
//

#import "XNTableViewController.h"
#import "XNTableViewCell.h"
@implementation XNTableViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(indexPath.row == 0) {
        cell.contentLabel.text = @"第十六届北京航展于9月16日在国际会议中心开幕，在中航工业的一份宣传页中，出现了翼龙II无人机的设计方案效果图。据资料介绍，翼龙II无人机系统是在翼龙I无人机基础上研制的一款中空、长航时、侦察/打击一体化多用途无人机，可以执行侦察、监视和对地打击任务，适合于军事任务、反恐维稳、边境巡逻和民事用途，该系统由翼龙II无人机、地面站、任务载荷和地面保障系统组成。宣传页上这架翼龙II无人机，6个翼下挂架采用复合挂架的方式挂载了12枚导弹。　据悉，翼龙II无人机系统具有全自主水平轮式起降和巡航飞行能力、空地协同能力、地面接力控制能力，相对翼龙I";
    } else if (indexPath.row == 1) {
        cell.contentLabel.text = @"第十六届北京航展于9月16日在国际会议中心开幕，在中航工业的一份宣传页中，出现了翼龙II无人机的设计方案效果图。";
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell ---- %zd", indexPath.row);
    // 0.cell中label需要设置preferredWidth（label中排多少字开始换行）
    
    XNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    // 1.设置cell内容
    if(indexPath.row == 0) {
        cell.contentLabel.text = @"第十六届北京航展于9月16日在国际会议中心开幕，在中航工业的一份宣传页中，出现了翼龙II无人机的设计方案效果图。据资料介绍，翼龙II无人机系统是在翼龙I无人机基础上研制的一款中空、长航时、侦察/打击一体化多用途无人机，可以执行侦察、监视和对地打击任务，适合于军事任务、反恐维稳、边境巡逻和民事用途，该系统由翼龙II无人机、地面站、任务载荷和地面保障系统组成。宣传页上这架翼龙II无人机，6个翼下挂架采用复合挂架的方式挂载了12枚导弹。　据悉，翼龙II无人机系统具有全自主水平轮式起降和巡航飞行能力、空地协同能力、地面接力控制能力，相对翼龙I";
    } else if (indexPath.row == 1) {
        cell.contentLabel.text = @"第十六届北京航展于9月16日在国际会议中心开幕，在中航工业的一份宣传页中，出现了翼龙II无人机的设计方案效果图。";
    }
    // 2.通知cell更新布局，取得cell的准确高度
    [cell layoutIfNeeded];
    
    // 3.自动布局之后取得 label的包裹文字后的尺寸
    CGSize labelSize = [cell.contentLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    // 4.返回cell 的高度
    return cell.contentLabel.frame.origin.y + labelSize.height + 10;
}

// 技巧：设置estimatedHeightForRowAtIndexPath方法可以减少heightForRowAtIndexPath的调用次数
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
