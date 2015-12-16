//
//  FootDetailCreatBidViewController.m
//  标会记账本
//
//  Created by Siven on 15/10/8.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "FootDetailCreatBidViewController.h"
#import "DetailBidFootTableViewCell.h"
#import "CycleSettingBegainBidViewController.h"
#import "TKContact.h"

@interface FootDetailCreatBidViewController ()<ZHPickViewDelegate>
@property (strong, nonatomic) NSMutableArray *myDataArray; //数据
//@property (strong, nonatomic) NSArray *mySelectDataArray; //最后选中的人
@end

@implementation FootDetailCreatBidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myDataArray =[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    self.title = @"会脚详情";
//    self.mySelectDataArray =[[NSArray alloc] init];
    self.mytableView.separatorStyle =UITableViewCellSeparatorStyleNone;

    
    NSMutableDictionary *creatBidDic =[NSMutableDictionary dictionaryWithDictionary:[UserMessage sharedUserMessage].BegainHeaderBidDic];
    for (int y=0; y<self.myBidDetailData.count+1; y++) {
        NSMutableDictionary *aDic =[[NSMutableDictionary alloc] init];
        if (y==0) {
            [aDic setObject:[creatBidDic objectForKey:@"creator_name"] forKey:@"name"];
            [aDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phoneNumber"];
            [aDic setObject:@"1" forKey:@"allCount"];
            [aDic setObject:@"0" forKey:@"pastCount"];
            
        }else{
            
            TKContact *aTKAddressBook =[self.myBidDetailData objectAtIndex:y-1];
            [aDic setObject:aTKAddressBook.name forKey:@"name"];
            [aDic setObject:aTKAddressBook.tempPhone forKey:@"phoneNumber"];
            [aDic setObject:@"1" forKey:@"allCount"];
            [aDic setObject:@"0" forKey:@"pastCount"];
            
        }
        
        [self.myDataArray addObject:aDic];
    }
    [self.saveCycleBidButton normalStyle];
}

- (IBAction)clickSaveButtonAction:(id)sender {
    int allAccount = 0;
//    NSMutableArray *participantArray =[[NSMutableArray alloc]init];
//    for (int y = 0; y< self.myBidDetailData.count+1; y++) {
//        DetailBidFootTableViewCell *aCell  =(DetailBidFootTableViewCell *)[self.mytableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:y inSection:0]];
//        
//        NSMutableDictionary *aBidFoot =[[NSMutableDictionary alloc]initWithObjectsAndKeys:aCell.nameLabel.text, @"name",aCell.cellId,@"phoneNumber",aCell.allCountBidButton.titleLabel.text,@"allCount",aCell.moneyLabel.text,@"pastCount",nil];
//        [participantArray addObject:aBidFoot];
//        allAccount += [aCell.allCountBidButton.titleLabel.text intValue];
//    }
 [UserMessage sharedUserMessage].BegainHeaderBidFootDetail = self.myDataArray;
    
    for (int x=0; x<self.myDataArray.count; x++) {
        int countValue =[[[self.myDataArray objectAtIndex:x] objectForKey:@"allCount"] intValue];
        allAccount +=countValue;
    }
    
    CycleSettingBegainBidViewController *aCycleBegainBidVC =[[CycleSettingBegainBidViewController alloc] init];
    aCycleBegainBidVC.allCount  = allAccount;
    [self.navigationController pushViewController:aCycleBegainBidVC animated:YES];
    
    
}



#pragma mark ----UITableViewDelegate
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;  //在这里是几行
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
         return self.myHeaderTableView;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 80;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.myDataArray.count ; //添加会头
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TwoIdentifier = @"tableViewCell";
    
//    if(_indexChoosen == 1){
        DetailBidFootTableViewCell *cell = (DetailBidFootTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TwoIdentifier];
        
        if (cell == nil) {
            NSArray  *nibs =[[NSBundle mainBundle] loadNibNamed:@"DetailBidFootTableViewCell" owner:self options:nil];
            
            for (id oneObject in nibs) {
                if ([oneObject isKindOfClass:[DetailBidFootTableViewCell class]]) {
                    cell = (DetailBidFootTableViewCell *)oneObject;
                }
            }
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        myDataArray
//    NSMutableDictionary *creatBidDic =[NSMutableDictionary dictionaryWithDictionary:[UserMessage sharedUserMessage].BegainHeaderBidDic];
    if (indexPath.row == 0) {
//        cell.cellId = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone];
//        cell.nameLabel.text = [creatBidDic objectForKey:@"creator_name"];
//        [cell.allCountBidButton setTitle:@"1" forState:UIControlStateNormal];
        [cell.allCountBidButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
//        cell.moneyLabel.text = @"0";
        [cell.deleteOrNotButton setTitle:@"会头" forState:UIControlStateNormal];
        
    }else{
        

//        TKAddressBook *aTKAddressBook =[self.myBidDetailData objectAtIndex:indexPath.row];
//        cell.cellId = aTKAddressBook.telephone;
//        cell.nameLabel.text =aTKAddressBook.name;
//        [cell.allCountBidButton setTitle:@"1" forState:UIControlStateNormal];
//        cell.moneyLabel.text  = @"0";
        
        [cell.deleteOrNotButton setTitle:@"删除" forState:UIControlStateNormal];
        [cell.deleteOrNotButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
        [cell.allCountBidButton setTitleColor:MBPGreenColor forState:UIControlStateNormal];
        
        
        [cell.deleteOrNotButton addTarget:self action:@selector(deleteOrNotButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.deleteOrNotButton.tag = indexPath.row;
        
    }
    
    cell.nameLabel.text =[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    [cell.allCountBidButton setTitle:[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"allCount"] forState:UIControlStateNormal];
    cell.moneyLabel.text =[[self.myDataArray objectAtIndex:indexPath.row] objectForKey:@"pastCount"];
    
    [cell.allCountBidButton addTarget:self action:@selector(allCountBidButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.allCountBidButton.tag = indexPath.row;

        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section %ld and row:%ld",(long)indexPath.section,(long)indexPath.row);
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}

#pragma mark - 设置总名数
-(void)allCountBidButtonAction:(id)sender{
    UIButton *aButton =(UIButton *)sender;
    
    NSMutableArray *aPickArray =[[NSMutableArray alloc]init];
    for (int x =0; x <=300; x++) {
        NSString *numberString =[NSString stringWithFormat:@"%d",x];
        [aPickArray addObject:numberString];
    }
    
    ZHPickView *_pickview=[[ZHPickView alloc] initPickviewWithArray:aPickArray isHaveNavControler:NO];
    _pickview.tagVaule = aButton.tag;
    _pickview.delegate=self;
    [_pickview show];
    NSLog(@"array:%@ and tag:%d",aPickArray,aButton.tag);
}
#pragma mark --------ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    NSLog(@"result string :%@ and%d",resultString,pickView.tagVaule);
    
    NSIndexPath *indexPathcell =[NSIndexPath indexPathForRow:pickView.tagVaule inSection:0];
    DetailBidFootTableViewCell *aDetailBidVCell =(DetailBidFootTableViewCell *)[self.mytableView cellForRowAtIndexPath:indexPathcell];
    [aDetailBidVCell.allCountBidButton setTitle:resultString forState:UIControlStateNormal];

    [[self.myDataArray objectAtIndex:pickView.tagVaule] setObject:resultString forKey:@"allCount"];
    
}

#pragma mark - 删除会脚
-(void)deleteOrNotButtonAction:(id)sender{
    UIButton *aButton = (UIButton *)sender;
//    NSMutableArray *aNewData =[NSMutableArray arrayWithArray:self.myBidDetailData];
//    [aNewData removeObjectAtIndex:aButton.tag];
//    self.myDataArray = aNewData;
    [self.myDataArray removeObjectAtIndex:aButton.tag];
    [self.mytableView reloadData];
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
