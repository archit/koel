//
//  ABKSongListViewController.m
//  Koel
//
//  Created by Archit Baweja on 7/20/13.
//  Copyright (c) 2013 Archit Baweja. All rights reserved.
//

#import "ABKSongListViewController.h"
#import "ABKWarbleResource.h"

@interface ABKSongListViewController ()

@end

@implementation ABKSongListViewController

@synthesize pullToRefresh = _pullToRefresh;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.pullToRefresh = [[SSPullToRefreshView alloc] initWithScrollView:(UIScrollView *)self.view delegate:(id)self];

    [ABKWarbleResource getQueueWithSuccess:^(AFHTTPRequestOperation *operation, id JSON) {
        [(UITableView *)self.view reloadData];
    } failure:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
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
    return [ABKWarbleResource getQueueLength];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"songRowView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    UIImageView *playTypeImage = (UIImageView *)[cell viewWithTag:2];
    NSDictionary *play = [[ABKWarbleResource songQueue] objectAtIndex:[indexPath row]];
    cellLabel.text =  [play valueForKeyPath:@"song.title"];
    [playTypeImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [play valueForKeyPath:@"song.source"]]]];
    
    return cell;
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - SSPullToRefresh delegate

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view
{
    [ABKWarbleResource getQueueWithSuccess:^(AFHTTPRequestOperation *operation, id JSON) {
        [(UITableView *)self.view reloadData];
        [view finishLoading];
    } failure:nil];
}
    
- (void)showSongPicker:(id)sender
{
    NSLog(@"BLARGH!");
}
@end
