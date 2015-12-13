//
//  MenuSettingViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "MenuSettingViewController.h"
#import "MyAccountViewController.h"
#import "FeedbackViewController.h"
#import "CXAlertView.h"
#import "InviteContactsViewController.h"
#import "TKContactsMultiPickerController.h"
#import "LoginViewController.h"
#import "ServiceAgreementViewController.h"
#import "GetContactsViewController.h"

#import "TKContactsMultiPickerController.h"

@interface MenuSettingViewController ()<TKContactsMultiPickerControllerDelegate>
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation MenuSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"标会记帐本";
    // Do any additional setup after loading the view from its nib.
//    self.hidesBottomBarWhenPushed = YES;
    
    self.myMenuTableView.delegate = self;
    self.myMenuTableView.dataSource = self;
    self.dataArray = @[@"我的账号", @[@"邀请好友",@"联系人"],@[@"操作规则",@"常见问题"],@[@"意见反馈",@"注销"]];
    // 我的账号 邀请好友 联系人    3操作规则 常见问题 4意见反馈 检查更新 注销

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section ) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 2;
            break;
            
        default:
            break;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *TableSampleIdentifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
    }else {
        while ([cell.contentView.subviews lastObject ]!=nil) {
            [(UIView*)[cell.contentView.subviews lastObject]removeFromSuperview];
        }
    }

    //    填充行的详细内容
//    cell.detailTextLabel.text = @"详细内容";
    //    把数组中的值赋给单元格显示出来
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.section];
        }
            break;
        case 1:
        {
            cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }
            break;
        case 2:
        {
            cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }
            break;
        case 3:
        {
            cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }
            break;
            
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    //    表视图单元提供的UILabel属性，设置字体大小
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:40.0f];
//    cell.textLabel.backgroundColor=[UIColor clearColor];
//    //    正常情况下现实的图片
//    UIImage *image = [UIImage imageNamed:@"2.png"];
//    cell.imageView.image=image;
//    cell.imageView.highlightedImage = highLightImage;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


#pragma mark  UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            MyAccountViewController *aMyAccountVC =[[MyAccountViewController alloc]initWithNibName:@"MyAccountViewController" bundle:nil];
            aMyAccountVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aMyAccountVC animated:YES];
            
            
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
// 邀请好友
                
//                InviteContactsViewController *aContactsVC =[[InviteContactsViewController alloc]initWithNibName:@"InviteContactsViewController" bundle:nil];
//                aContactsVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:aContactsVC animated:YES];
                
                TKContactsMultiPickerController *controller = [[TKContactsMultiPickerController alloc] initWithGroup:nil];
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            
                
//                TKPeoplePickerController *controller = [[TKPeoplePickerController alloc] initPeoplePicker];
//                controller.actionDelegate = self;
//                controller.modalPresentationStyle = UIModalPresentationFullScreen;
//                [self presentViewController:controller animated:YES completion:nil];
                
                
            }else{
               
                
                GetContactsViewController *getContactsVC =[[GetContactsViewController alloc]init];
                getContactsVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:getContactsVC animated:YES];
                
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
//                CXAlertView *aCXAlertView =[[CXAlertView alloc]initWithTitle:@"操作规则" message:@"操作规则内容" cancelButtonTitle:@"了解"];
////                [aCXAlertView addButtonWithTitle:@"确定" type:CXAlertViewButtonTypeDefault handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
////                    
////                    // 操作规则
////                    
////                }];
//                
//                [aCXAlertView show];
                
                ServiceAgreementViewController *aRulesVC =[[ServiceAgreementViewController alloc]init];
                aRulesVC.indexValue = 1;
                aRulesVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:aRulesVC animated:YES];
                
            } else {
//                CXAlertView *aCXAlertView =[[CXAlertView alloc]initWithTitle:@"常见问题" message:@"常见问题" cancelButtonTitle:@"了解"];
////                [aCXAlertView addButtonWithTitle:@"确定" type:CXAlertViewButtonTypeDefault handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
////                    
////                    // 常见问题
////                    
////                }];
//                
//                [aCXAlertView show];
//            }
                
                ServiceAgreementViewController *aRulesVC =[[ServiceAgreementViewController alloc]init];
                aRulesVC.indexValue = 2;
                aRulesVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:aRulesVC animated:YES];
            }
            
        }
            break;
        case 3:
        {
            if (indexPath.row == 0) {
                FeedbackViewController *aFeedBackVC=[[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
                aFeedBackVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:aFeedBackVC animated:YES];
                
            }else if (indexPath.row == 1) {
                
                CXAlertView *aCXAlertView =[[CXAlertView alloc]initWithTitle:@"注销" message:@"您确定注销吗？" cancelButtonTitle:@"取消"];
                [aCXAlertView addButtonWithTitle:@"确定" type:CXAlertViewButtonTypeDefault handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
                    NSLog(@"退出登录");;
                    [alertView dismiss];
                    
                    //清空密码
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUserPassword];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUserPhone];
                    
                    // 退出登录
                    LoginViewController *aLoginVC =[[LoginViewController alloc]init];
                    [self presentViewController:aLoginVC animated:YES completion:nil];
                    
//                    [self.navigationController presentViewController:aLoginVC animated:YES completion:^{
//                        
//                    }];
                    
                    
                }];
                
                [aCXAlertView show];
            }

        }
            break;
        
            
        default:
            break;
    }
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    
    [self dismissViewControllerAnimated:YES completion:^{
//        self.textField.text = (__bridge NSString*)value;
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
