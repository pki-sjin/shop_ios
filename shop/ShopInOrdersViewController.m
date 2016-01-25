//
//  ShopInOrdersViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 9/20/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "ShopInOrdersViewController.h"
#import "ShopInOrdersCell.h"
#import "StoreInfo.h"
#import "RequestTask.h"
#import "GlobalContext.h"
#import "OrdersViewController.h"

@interface ShopInOrdersViewController ()

@end

@implementation ShopInOrdersViewController

@synthesize list, needToRefresh;

NSMutableArray* orders;

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

-(void)viewDidAppear:(BOOL)animated
{
    if (needToRefresh)
    {
        [self refresh: nil];
        needToRefresh = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopInOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopInOrdersCell" forIndexPath:indexPath];
    
    
    UIView* selectionView = [[UIView alloc] initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, cell.bounds.size.width, cell.bounds.size.height)];
    
    [selectionView setBackgroundColor:[UIColor blueColor]];
    
    [cell setSelectedBackgroundView:selectionView];
    
    StoreInfo* info = [list objectAtIndex:[indexPath row]];
    
    cell.shopName.text = info.strname;
    cell.num.text = info.billcount;
    
    [cell.shopName setHighlightedTextColor:[UIColor whiteColor]];
    [cell.num setHighlightedTextColor:[UIColor whiteColor]];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 22)];
    
    UILabel* shopTitle = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 231, 20)];
    shopTitle.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [shopTitle setTextAlignment:NSTextAlignmentCenter];
    shopTitle.text = @"店铺名";
    
    UILabel* numTitle = [[UILabel alloc] initWithFrame:CGRectMake(235, 2, 83, 20)];
    numTitle.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [numTitle setTextAlignment:NSTextAlignmentCenter];
    numTitle.text = @"订单数";
    
    [head addSubview:shopTitle];
    [head addSubview:numTitle];
    
    return head;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreInfo* info = [list objectAtIndex:[indexPath row]];
    orders = nil;
    orders = [RequestTask getBill:[GlobalContext GetUserInfo].sid store:info];
    if (orders != nil)
    {
        [self performSegueWithIdentifier:@"ShowOrders" sender:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    OrdersViewController* destination = [segue destinationViewController];
    destination.store = [list objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    destination.list = orders;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)refresh:(id)sender
{
    list = [RequestTask getStore:[GlobalContext GetUserInfo].sid userno:[GlobalContext GetUserInfo].userno];
    [self.tableView reloadData];
}

@end
