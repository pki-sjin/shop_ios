//
//  DetailsViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 10/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailInfo.h"
#import "DetailsCell.h"
#import "RequestTask.h"
#import "GlobalContext.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize list, store, order;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView.frame = CGRectMake(self.tableView.frame.origin.x, tableView.frame.origin.y, 1032, self.tableView.frame.size.height);
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait)
    {
        [tableView setContentInset:UIEdgeInsetsMake(tableView.contentInset.top, tableView.contentInset.left, tableView.contentInset.bottom, 1032 - self.view.window.frame.size.width)];
    }else
    {
        [tableView setContentInset:UIEdgeInsetsMake(tableView.contentInset.top, tableView.contentInset.left, tableView.contentInset.bottom, 1032 - self.view.window.frame.size.height)];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsCell *cell = (DetailsCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailsCell"];
    UIView* selectionView = [[UIView alloc] initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, cell.bounds.size.width, cell.bounds.size.height)];
    
    [selectionView setBackgroundColor:[UIColor blueColor]];
    
    [cell setSelectedBackgroundView:selectionView];
    
    DetailInfo* orderInfo = [list objectAtIndex:indexPath.row];
    
    cell.plu_no.text = orderInfo.plu_no;
    cell.plu_name.text = orderInfo.plu_name;
    cell.Mainbarcode.text = orderInfo.Mainbarcode;
    cell.plu_style.text = orderInfo.plu_style;
    cell.unit.text = orderInfo.unit;
    cell.stan_pack.text = orderInfo.stan_pack;
    cell.o_num.text = orderInfo.o_num;
    cell.a_num.text = orderInfo.a_num;
    cell.s_num.text = orderInfo.s_num;
    cell.wh_num.text = orderInfo.wh_num;
    
    [cell.plu_no setHighlightedTextColor:[UIColor whiteColor]];
    [cell.plu_name setHighlightedTextColor:[UIColor whiteColor]];
    [cell.Mainbarcode setHighlightedTextColor:[UIColor whiteColor]];
    [cell.plu_style setHighlightedTextColor:[UIColor whiteColor]];
    [cell.unit setHighlightedTextColor:[UIColor whiteColor]];
    [cell.stan_pack setHighlightedTextColor:[UIColor whiteColor]];
    [cell.o_num setHighlightedTextColor:[UIColor whiteColor]];
    [cell.a_num setHighlightedTextColor:[UIColor whiteColor]];
    [cell.s_num setHighlightedTextColor:[UIColor whiteColor]];
    [cell.wh_num setHighlightedTextColor:[UIColor whiteColor]];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1032, 20)];
    
    UIButton* Mainbarcode = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, 140, 20)];
    Mainbarcode.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [Mainbarcode.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [Mainbarcode setTitle:@"主条码" forState:UIControlStateNormal];
    [Mainbarcode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Mainbarcode addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* plu_name = [[UIButton alloc] initWithFrame:CGRectMake(144, 2, 140, 20)];
    plu_name.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [plu_name.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [plu_name setTitle:@"商品名称" forState:UIControlStateNormal];
    [plu_name setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plu_name addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* s_num = [[UIButton alloc] initWithFrame:CGRectMake(286, 2, 100, 20)];
    s_num.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [s_num.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [s_num setTitle:@"发货数量" forState:UIControlStateNormal];
    [s_num setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [s_num addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* o_num = [[UIButton alloc] initWithFrame:CGRectMake(388, 2, 100, 20)];
    o_num.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [o_num.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [o_num setTitle:@"订货数量" forState:UIControlStateNormal];
    [o_num setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [o_num addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* wh_num = [[UIButton alloc] initWithFrame:CGRectMake(490, 2, 100, 20)];
    wh_num.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [wh_num.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [wh_num setTitle:@"当前可配" forState:UIControlStateNormal];
    [wh_num setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [wh_num addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* plu_no = [[UIButton alloc] initWithFrame:CGRectMake(592, 2, 120, 20)];
    plu_no.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [plu_no.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [plu_no setTitle:@"商品编码" forState:UIControlStateNormal];
    [plu_no setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plu_no addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* plu_style = [[UIButton alloc] initWithFrame:CGRectMake(714, 2, 70, 20)];
    plu_style.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [plu_style.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [plu_style setTitle:@"规格型" forState:UIControlStateNormal];
    [plu_style setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plu_style addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* unit = [[UIButton alloc] initWithFrame:CGRectMake(786, 2, 70, 20)];
    unit.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [unit.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [unit setTitle:@"单位" forState:UIControlStateNormal];
    [unit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [unit addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* stan_pack = [[UIButton alloc] initWithFrame:CGRectMake(858, 2, 70, 20)];
    stan_pack.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [stan_pack.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [stan_pack setTitle:@"内核数" forState:UIControlStateNormal];
    [stan_pack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stan_pack addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* a_num = [[UIButton alloc] initWithFrame:CGRectMake(930, 2, 100, 20)];
    a_num.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [a_num.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [a_num setTitle:@"审核数量" forState:UIControlStateNormal];
    [a_num setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [a_num addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [head addSubview:Mainbarcode];
    [head addSubview:plu_name];
    [head addSubview:s_num];
    [head addSubview:o_num];
    [head addSubview:wh_num];
    [head addSubview:plu_no];
    [head addSubview:plu_style];
    [head addSubview:unit];
    [head addSubview:stan_pack];
    [head addSubview:a_num];
    
    return head;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        [self.tableView setContentInset:UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, self.tableView.contentInset.bottom, 1032 - self.view.window.frame.size.height)];
    }else
    {
        [self.tableView setContentInset:UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, self.tableView.contentInset.bottom, 1032 - self.view.window.frame.size.width)];
    }
}

-(void)refresh:(id)sender
{
    list = [RequestTask getBillDetail:[GlobalContext GetUserInfo].sid store:store bill:order];
    [self.tableView reloadData];
}

-(void)sort:(UIButton*)sender
{
    NSLog(@"%@",sender.titleLabel.text);
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
