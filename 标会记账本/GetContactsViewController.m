//
//  GetContactsViewController.m
//  标会记账本
//
//  Created by Sam on 15/10/5.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "GetContactsViewController.h"
#import "TKAddressBook.h"
#import "UIButton+Bootstrap.h"
#import <MessageUI/MessageUI.h>
#import "ChineseSorting/ChineseString.h"

@interface GetContactsViewController ()<MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) NSArray *myContactsArray; //联系人
@property (strong, nonatomic) NSMutableArray *mySectionIndexArray; //索引
@property (strong, nonatomic) NSMutableArray *mySelectContactsArray; //索引

@end

@implementation GetContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.hidesBottomBarWhenPushed = YES;
    self.title = @"联系人";
    
    //接口  判断是否为用户（菜单-联系人）：
    
    NSLog(@"contacts :%@",[UserMessage sharedUserMessage].addressBooks);
    self.myContactsArray =[NSArray arrayWithArray:[UserMessage sharedUserMessage].addressBooks];
    self.mySelectContactsArray =[[NSMutableArray alloc]init];
    

    self.myContactsArray =[ChineseString LetterSortArray:[UserMessage sharedUserMessage].addressBooks];
    self.mySectionIndexArray =[ChineseString IndexArray:[UserMessage sharedUserMessage].addressBooks];
    
}


-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


#pragma mark  MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *TableSampleIdentifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
    }
    cell.accessoryType  = UITableViewCellAccessoryNone;

    ChineseString *aChineseString =[[self.myContactsArray objectAtIndex:indexPath.section]  objectAtIndex:indexPath.row];
    TKAddressBook *aTKAddressBook  = aChineseString.addressBook;
    cell.textLabel.text = aTKAddressBook.name;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
    UIButton *aAccessoryButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [aAccessoryButton setTitle:@"邀请" forState:UIControlStateNormal];
    [aAccessoryButton setFrame:CGRectMake(0, 0, 60, 25)];
    [aAccessoryButton normalStyle];
    [aAccessoryButton addTarget:self action:@selector(selectAccessoryButton:) forControlEvents:UIControlEventTouchUpInside];
    aAccessoryButton.tag = indexPath.row;
    cell.accessoryView = aAccessoryButton;
    
    return cell;
    
}

#pragma mark -
#pragma mark Table View Data Source Methods
#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.mySectionIndexArray;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //点击索引，列表跳转到对应索引的行
    
    [tableView
     scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
     atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.mySectionIndexArray count];
}
#pragma mark -设置表格的行数为数组的元素个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.myContactsArray objectAtIndex:section] count];
}
//
#pragma mark -Section的Header的值
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.mySectionIndexArray objectAtIndex:section];
    return key;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 20;
//}

-(void)selectAccessoryButton:(id)sender{
    UIButton *aButton = (UIButton *)sender;
    NSLog(@"tag :%ld",(long)aButton.tag);
    ChineseString *aChineseStr =[self.myContactsArray objectAtIndex:aButton.tag];
    TKAddressBook *aAddressBook =aChineseStr.addressBook;
    
    //调用短信 数组可以群发
    [self showMessageView:[NSArray arrayWithObject:aAddressBook.telephone] title:@"标会" body:@"邀请好友"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
