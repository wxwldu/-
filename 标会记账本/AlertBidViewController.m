//
//  AlertBidViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "AlertBidViewController.h"
#import "AlertBiddingTableViewCell.h"
#import "ResultViewController.h"

@interface AlertBidViewController ()
@property (nonatomic, strong) NSMutableArray *myDateArray;

@end

@implementation AlertBidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"标会记帐本";
    // Do any additional setup after loading the view from its nib.
    [self setBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.myDateArray = [UserMessage sharedUserMessage].alertBiddingArray;
    
}

#pragma mark ----UITableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.myDateArray.count;  //在这里是几行
//}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.myDateArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
            static NSString *TableSampleIdentifier = @"Identifier";
            
        AlertBiddingTableViewCell *cell = (AlertBiddingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];

        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"AlertBiddingTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[AlertBiddingTableViewCell class]]) {
                    cell = (AlertBiddingTableViewCell *)oneObject;
                }
            }

            
        }


        cell.nameBidLabel.text = [[self.myDateArray objectAtIndex:indexPath.section] objectForKey:@"creatorName"];
        cell.amountBidLabel.text = [[self.myDateArray objectAtIndex:indexPath.section] objectForKey:@"baselineMoney"];
    cell.amountBidLabel.text = [[self.myDateArray objectAtIndex:indexPath.section] objectForKey:@"startTime"];

        NSString *firstDateString = [[self.myDateArray objectAtIndex:indexPath.section] objectForKey:@"firstDate"];
        if ([firstDateString isEqualToString:@"0"]) {
            cell.dateBidLabel.text = [NSString stringWithFormat:@"农历%@",firstDateString];
        } else {
            cell.dateBidLabel.text = [NSString stringWithFormat:@"阳历%@",firstDateString];
        }

        //        cell.backgroundColor =[UIColor greenColor];
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section %d and row:%d",indexPath.section,indexPath.row);
    //    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    ResultViewController *aResultVC =[[ResultViewController alloc]init];
    aResultVC.indexFrom = 0;
    aResultVC.detailBidData =[self.myDateArray  objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:aResultVC animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100.f;
    }
    else {
        return 250.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
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
