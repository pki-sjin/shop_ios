//
//  ShopWithGeoViewController.m
//  shop
//
//  Created by SHDEVAPPLE001 on 11/1/14.
//  Copyright (c) 2014 1510. All rights reserved.
//

#import "ShopWithGeoViewController.h"
#import "ShopWithGeoCell.h"
#import "StoreInfo.h"
#import "RequestTask.h"
#import "LocationViewController.h"

@interface ShopWithGeoViewController ()

@end

@implementation ShopWithGeoViewController

@synthesize list, needToRefresh, oringalType;

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopWithGeoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopWithGeoCell" forIndexPath:indexPath];
    
    UIView* selectionView = [[UIView alloc] initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, cell.bounds.size.width, cell.bounds.size.height)];
    
    [selectionView setBackgroundColor:[UIColor blueColor]];
    
    [cell setSelectedBackgroundView:selectionView];
    
    StoreInfo* info = [list objectAtIndex:[indexPath row]];
    
    cell.shopName.text = info.strname;
    
    [cell.shopName setHighlightedTextColor:[UIColor whiteColor]];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 22)];
    
    UILabel* shopTitle = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, self.tableView.bounds.size.width, 20)];
    shopTitle.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:255];
    [shopTitle setTextAlignment:NSTextAlignmentCenter];
    shopTitle.text = @"店铺名";
    
    [head addSubview:shopTitle];
    
    return head;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)refresh:(id)sender
{
    list = [RequestTask getStoreWithGeo:[GlobalContext GetUserInfo].sid userno:[GlobalContext GetUserInfo].userno];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowLocation" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    StoreInfo* info = [list objectAtIndex:[self.tableView.indexPathForSelectedRow row]];
    
    LocationViewController* destination = [segue destinationViewController];
    
    destination.storeInfo = info;
    
    destination.requestType = oringalType;
}


@end
