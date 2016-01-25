//
//  OrdersViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 9/26/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrdersCell.h"
#import "OrderInfo.h"
#import "RequestTask.h"
#import "GlobalContext.h"
#import "DetailsViewController.h"
#import "ShopInOrdersViewController.h"

@interface OrdersViewController ()

@end

@implementation OrdersViewController

@synthesize list, store;

NSMutableArray* details;

UIView* head;

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
    
    head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1032, 20)];
    
    UIButton* packagecnt = [[UIButton alloc] initWithFrame:CGRectMake(2, 2, 70, 20)];
    packagecnt.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [packagecnt.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [packagecnt setTitle:@"箱数" forState:(UIControlStateNormal)];
    [packagecnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [packagecnt addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* s_num = [[UIButton alloc] initWithFrame:CGRectMake(74, 2, 100, 20)];
    s_num.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [s_num.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [s_num setTitle:@"发货数量" forState:UIControlStateNormal];
    [s_num setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [s_num addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* satisfied = [[UIButton alloc] initWithFrame:CGRectMake(176, 2, 80, 20)];
    satisfied.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [satisfied.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [satisfied setTitle:@"满足率" forState:UIControlStateNormal];
    [satisfied setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [satisfied addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* o_num = [[UIButton alloc] initWithFrame:CGRectMake(258, 2, 100, 20)];
    o_num.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [o_num.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [o_num setTitle:@"订货数量" forState:UIControlStateNormal];
    [o_num setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [o_num addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* s_store = [[UIButton alloc] initWithFrame:CGRectMake(360, 2, 140, 20)];
    s_store.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [s_store.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [s_store setTitle:@"发货门店" forState:UIControlStateNormal];
    [s_store setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [s_store addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* billno = [[UIButton alloc] initWithFrame:CGRectMake(502, 2, 120, 20)];
    billno.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [billno.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [billno setTitle:@"单据号" forState:UIControlStateNormal];
    [billno setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [billno addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* s_date = [[UIButton alloc] initWithFrame:CGRectMake(624, 2, 100, 20)];
    s_date.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [s_date.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [s_date setTitle:@"发货时间" forState:UIControlStateNormal];
    [s_date setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [s_date addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* a_num = [[UIButton alloc] initWithFrame:CGRectMake(726, 2, 100, 20)];
    a_num.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [a_num.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [a_num setTitle:@"审核数量" forState:UIControlStateNormal];
    [a_num setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [a_num addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* skucount = [[UIButton alloc] initWithFrame:CGRectMake(828, 2, 80, 20)];
    skucount.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [skucount.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [skucount setTitle:@"SKU数" forState:UIControlStateNormal];
    [skucount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [skucount addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* remark = [[UIButton alloc] initWithFrame:CGRectMake(910, 2, 120, 20)];
    remark.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [remark.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [remark setTitle:@"备注" forState:UIControlStateNormal];
    [remark setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [remark addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [head addSubview:packagecnt];
    [head addSubview:s_num];
    [head addSubview:satisfied];
    [head addSubview:o_num];
    [head addSubview:s_store];
    [head addSubview:billno];
    [head addSubview:s_date];
    [head addSubview:a_num];
    [head addSubview:skucount];
    [head addSubview:remark];
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
    OrdersCell *cell = (OrdersCell *)[tableView dequeueReusableCellWithIdentifier:@"OrdersCell"];
    UIView* selectionView = [[UIView alloc] initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, cell.bounds.size.width, cell.bounds.size.height)];
    
    [selectionView setBackgroundColor:[UIColor blueColor]];
    
    [cell setSelectedBackgroundView:selectionView];
    
    OrderInfo* orderInfo = [list objectAtIndex:indexPath.row];
    
    cell.billno.text = orderInfo.billno;
    cell.s_store.text = orderInfo.s_store;
    cell.satisfied.text = [NSString stringWithFormat:@"%.2f%%", ([orderInfo.s_num floatValue]/[orderInfo.o_num floatValue])*100];
    cell.s_date.text = orderInfo.s_date;
    cell.packagecnt.text = orderInfo.packagecnt;
    cell.o_num.text = orderInfo.o_num;
    cell.a_num.text = orderInfo.a_num;
    cell.s_num.text = orderInfo.s_num;
    cell.skucount.text = orderInfo.skucount;
    cell.remark.text = orderInfo.remark;
    
    [cell.billno setHighlightedTextColor:[UIColor whiteColor]];
    [cell.s_store setHighlightedTextColor:[UIColor whiteColor]];
    [cell.satisfied setHighlightedTextColor:[UIColor whiteColor]];
    [cell.s_date setHighlightedTextColor:[UIColor whiteColor]];
    [cell.packagecnt setHighlightedTextColor:[UIColor whiteColor]];
    [cell.o_num setHighlightedTextColor:[UIColor whiteColor]];
    [cell.a_num setHighlightedTextColor:[UIColor whiteColor]];
    [cell.s_num setHighlightedTextColor:[UIColor whiteColor]];
    [cell.skucount setHighlightedTextColor:[UIColor whiteColor]];
    [cell.remark setHighlightedTextColor:[UIColor whiteColor]];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return head;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:@"操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"查看明细",@"确认收货", nil];
    [action showInView:self.view.window];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    OrderInfo* order = [list objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    
    if(buttonIndex == 0)
    {
        details = [RequestTask getBillDetail:[GlobalContext GetUserInfo].sid store:store bill:order];
        if (details != nil)
        {
            [self performSegueWithIdentifier:@"ShowDetails" sender:nil];
        }
    }else if (buttonIndex == 1)
    {
        bool result = [RequestTask dealBillByStr:[GlobalContext GetUserInfo].sid dealType:1 store:store bill:order];
        if (result)
        {
            [self refresh:nil];
            int index = [self.navigationController.viewControllers indexOfObject:self.navigationController.topViewController];
            id previousViewController = [self.navigationController.viewControllers objectAtIndex:index - 1];
            
            ShopInOrdersViewController* shopViewController = (ShopInOrdersViewController*)previousViewController;
            
            shopViewController.needToRefresh = true;
        }
    }
}

-(void)refresh:(id)sender
{
    list = [RequestTask getBill:[GlobalContext GetUserInfo].sid store:store];
    [self.tableView reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailsViewController* destination = [segue destinationViewController];
    destination.list = details;
    OrderInfo* order = [list objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    destination.store = store;
    destination.order = order;
    destination.title = order.billno;
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

-(void)sort:(UIButton*)sender
{
    if ([sender.titleLabel.text rangeOfString:@"箱数"].location != -1)
    {
        [list sortUsingComparator:^NSComparisonResult(OrderInfo* obj1, OrderInfo* obj2) {
            if ([obj1.packagecnt intValue] > [obj2.packagecnt intValue])
            {
                return sender.tag == 0?NSOrderedDescending:NSOrderedAscending;
            }else if ([obj1.packagecnt intValue] < [obj2.packagecnt intValue])
            {
                return sender.tag == 0?NSOrderedAscending:NSOrderedDescending;
            }else
            {
                return NSOrderedSame;
            }
            
        }];
        
        [self.tableView reloadData];
        
        if (sender.tag == 0)
        {
            sender.tag = 1;
        }else{
            sender.tag = 0;
        }
    }
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
