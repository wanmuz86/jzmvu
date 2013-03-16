//
//  ShopViewAllViewController.m
//  myjam
//
//  Created by Azad Johari on 2/11/13.
//  Copyright (c) 2013 me-tech. All rights reserved.
//

#import "ShopViewAllViewController.h"
#define kTableCellHeight 140
@interface ShopViewAllViewController ()

@end

@implementation ShopViewAllViewController
@synthesize catAllArray;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"JAM-BU Shop";
    }
    return self;
}

- (void)viewDidLoad
{
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [tempImageView setFrame:self.tableView.frame];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 70, 0)];
    self.tableView.backgroundView = tempImageView;
    [tempImageView release];
    
//    CustomTableHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableHeader" owner:self options:nil]objectAtIndex:0];
//    headerView.catTitle.text = [[[catAllArray valueForKey:@"shop_list" ]objectAtIndex:0] valueForKey:@"shop_category"];
//    
//    CGSize expectedLabelSize  = [[[[catAllArray valueForKey:@"shop_list" ]objectAtIndex:0] valueForKey:@"shop_category"] sizeWithFont:[UIFont fontWithName:@"Verdana" size:12.0] constrainedToSize:CGSizeMake(150.0, headerView.catTitle.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
//    CGRect newFrame = headerView.catTitle.frame;
//    newFrame.size.width = expectedLabelSize.width;
// headerView.catTitle.text = [[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] valueForKey:@"shop_category"];
//    
//    headerView.catTitle.frame = newFrame;
//           headerView.middleLine.frame = CGRectMake(expectedLabelSize.width+50,headerView.middleLine.frame.origin.y,300-expectedLabelSize.width-50, 1);
//   
//    self.tableView.tableHeaderView = headerView;
// 
    [super viewDidLoad];

}

//- (void) addItemsToEndOfTableView{
//    //    [super addItemsToEndOfTableView];
//    [UIView animateWithDuration:0.3 animations:^{
//        if (self.pageCounter >= self.totalPage)
//        {
//            if (([self.catAllArray count] > kDisplayPerscreen)) {
//                [self.tableView setContentOffset:CGPointMake(0, (([self.catAllArray count]-kDisplayPerscreen)*kTableCellHeight)+kExtraCellHeight)];
//            }else{
//                
//                CGRect screenBounds = [[UIScreen mainScreen] bounds];
//                if (screenBounds.size.height != 568) {
//                    // code for 4-inch screen
//                    [self.tableView setContentOffset:CGPointMake(0, (([self.catAllArray count]-kDisplayPerscreen)*kTableCellHeight)+kExtraCellHeight)];
//                }
//            }
//            
//        }else if (self.pageCounter < self.totalPage){
//            self.pageCounter++;
//            [self loadMoreFromServer];
//            
//            /*  if ([list count] > 0) {
//             [self.purchasedHistoryArray addObjectsFromArray:list];
//             }*/
//            
//        }
//    }];
//}
//
//- (void)loadMoreFromServer
//{
//    
//    NSDictionary *resultsDictionary =  [[MJModel sharedInstance] getFullListOfShopsFor:[[[catAllArray valueForKey:@"shop_list" ]objectAtIndex:0] valueForKey:@"category_id"] andPage:[NSString stringWithFormat:@"%d",self.pageCounter+1]];
//    if([resultsDictionary count])
//    {
//        NSString *status = [resultsDictionary objectForKey:@"status"];
//        NSMutableArray* resultArray;
//     \
//        if ([status isEqualToString:@"ok"])
//        {
//            self.totalPage = [[resultsDictionary objectForKey:@"pagecount"] intValue];
//            
//            resultArray = [resultsDictionary objectForKey:@"list"];
//            
//            for (id row in resultArray)
//            {
//                [catAllArray addObject:row];
//                
//            }
//       
//            
//        }
//        if (![resultArray count] || self.totalPage == 0)
//        {
//            [self.activityIndicator setHidden:YES];
//            
//            NSString *aMsg = [resultsDictionary objectForKey:@"message"];
//            
//            if([aMsg length] < 1)
//            {
////                if (self.selectedCategories.length > 0)
////                {
////                    aMsg = @"No data matched.";
////                }
//            }
//            
//            
//            self.loadingLabel.text = [NSString stringWithFormat:@"%@",aMsg];
//            [self.loadingLabel setTextAlignment:NSTextAlignmentCenter];
//            self.loadingLabel.textColor = [UIColor grayColor];
//            
//        }
//        
//        NSLog(@"page now is %d",self.pageCounter);
//        NSLog(@"totpage %d",self.totalPage);
//        
//        // if data is less, then hide the loading view
//        if (([[resultsDictionary valueForKey:@"list"] count] > 0 && [[resultsDictionary valueForKey:@"list"] count] < kListPerpage)) {
//            NSLog(@"here xx");
//            [self.activityIndicatorView setHidden:YES];
//            
//        }
//        
//        if ([status isEqualToString:@"error"]) {
//            [self.activityIndicatorView setHidden:NO];
//            [self.activityIndicator setHidden:YES];
//            
//            NSString *errorMsg = [resultsDictionary objectForKey:@"message"];
//            
//            if([errorMsg length] < 1)
//                errorMsg = @"Failed to retrieve data.";
//            
//            self.loadingLabel.text = [NSString stringWithFormat:@"%@",errorMsg];
//            [self.loadingLabel setTextAlignment:NSTextAlignmentCenter];
//            self.loadingLabel.textColor = [UIColor grayColor];
//            
//        }
//        
//        if ([status isEqualToString:@"ok"] && self.totalPage == 0) {
//            NSLog(@"empty");
//            [self.activityIndicatorView setHidden:NO];
//            [self.activityIndicator setHidden:YES];
//            self.loadingLabel.text = [NSString stringWithFormat:@"No records. Pull to refresh"];
//            [self.loadingLabel setTextAlignment:NSTextAlignmentCenter];
//            self.loadingLabel.textColor = [UIColor grayColor];
//        }
//        
//        if ([status isEqualToString:@"ok"] && self.totalPage > 1 && ![[resultsDictionary objectForKey:@"list"] count]) {
//            NSLog(@"data empty");
//            [self.activityIndicatorView setHidden:YES];
//            //        [self.tableView setContentOffset:CGPointMake(0, (([self.tableData count]-kDisplayPerscreen)*kTableCellHeight)+kExtraCellHeight)];
//        }
//        
//        
//        
//    }
//    
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0){
        return 1;
    }
    else{
    if ( ([[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]count] % 3) == 0){
        return ([[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]count]/3);
    }
    else{
        return (([[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]count]/3) + 1);
    }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        static NSString *CellIdentifier = @"Cell";
        
        CustomTableHeaderCell *cell = (CustomTableHeaderCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomTableHeaderCell" owner:nil options:nil];
            cell = [nib objectAtIndex:0];
            cell.catTitle.text = [[[[catAllArray valueForKey:@"shop_list" ]objectAtIndex:0] objectAtIndex:0]valueForKey:@"shop_category"];
            
               CGSize expectedLabelSize  = [[[[[catAllArray valueForKey:@"shop_list" ]objectAtIndex:0]objectAtIndex:0] valueForKey:@"shop_category"] sizeWithFont:[UIFont fontWithName:@"Verdana" size:12.0] constrainedToSize:CGSizeMake(150.0, cell.catTitle.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
               CGRect newFrame = cell.catTitle.frame;
               newFrame.size.width = expectedLabelSize.width;
            cell.catTitle.text = [[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:0]valueForKey:@"shop_category"];
            
              cell.catTitle.frame = newFrame;
                     cell.middleLine.frame = CGRectMake(expectedLabelSize.width+50,cell.middleLine.frame.origin.y,300-expectedLabelSize.width-50, 1);
        }
        // Configure the cell...

        return cell;
    }
    if (indexPath.section ==1){
       
        static NSString *CellIdentifier = @"Cell";
        
        ShopTableViewCellwoCat *cell = (ShopTableViewCellwoCat*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ShopTableViewCellwoCat" owner:nil options:nil];
            cell = [nib objectAtIndex:0];
        }
        // Configure the cell...
        [self createCellForIndex:indexPath cell:cell];
        return cell;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{if (indexPath.section ==0){
    return 44;
}
   else return kTableCellHeight;
}
- (void)createCellForIndex:(NSIndexPath *)indexPath cell:(ShopTableViewCellwoCat *)cell
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    //  cell.topLabel1.text =
    cell.catLabel1.text = [[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]objectAtIndex:(3*indexPath.row+0)]  valueForKey:@"shop_name"];
    
    if([[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]objectAtIndex:(3*indexPath.row+0)]  valueForKey:@"shop_top_seller"] isEqual:@"Y"]){
        cell.topLabel1.hidden=NO;
    }
    cell.shopLabel1.text =[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:(3*indexPath.row+0)] valueForKey:@"shop_category"];
  
 
    cell.button1.tag = 3*indexPath.row+0;
 [cell.button1 setBackgroundImageWithURL:[NSURL URLWithString:[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:(3*indexPath.row+0)]  valueForKey:@"shop_logo"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_icon.png"]];
    
     [cell.button1 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    if(3*indexPath.row+1 < [[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] count])
    {
            cell.button2.tag = 3*indexPath.row+1;
        if([[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:(3*indexPath.row+1)] valueForKey:@"shop_top_seller"] isEqual:@"Y"]){
            cell.topLabel2.hidden=NO;
        }

        cell.catLabel2.text = [[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]  objectAtIndex:(3*indexPath.row+1)] valueForKey:@"shop_name"];
        cell.shopLabel2.text =[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:(3*indexPath.row+1)] valueForKey:@"shop_category"];
        
        [cell.button2 setBackgroundImageWithURL:[NSURL URLWithString:[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]objectAtIndex:(3*indexPath.row+1)]  valueForKey:@"shop_logo"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_icon.png"]];
        [cell.button2 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if(3*indexPath.row+2 < [[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] count])
    {
        cell.button3.tag = 3*indexPath.row+2;
        cell.catLabel3.text = [[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:(3*indexPath.row+2)] valueForKey:@"shop_name"];
        cell.shopLabel3.text =[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:(3*indexPath.row+2)] valueForKey:@"shop_category"];
        if([[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]  objectAtIndex:(3*indexPath.row+2)] valueForKey:@"shop_top_seller"] isEqual:@"Y"]){
            cell.topLabel3.hidden=NO;
        }
             [cell.button3 setBackgroundImageWithURL:[NSURL URLWithString:[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]objectAtIndex:(3*indexPath.row+2)]  valueForKey:@"shop_logo"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_icon.png"]];
            [cell.button3 addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];

    }
}
-(void)tapAction:(id)sender{
    ShopDetailListingViewController *detailViewController = [[ShopDetailListingViewController alloc] init];
   detailViewController.productArray = [[NSMutableArray alloc] initWithArray:[[MJModel sharedInstance] getTopListOfItemsFor:[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:[sender tag]]valueForKey:@"shop_id"]]];
    detailViewController.shopInfo = [[NSDictionary alloc] initWithObjectsAndKeys: [[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]objectAtIndex:[sender tag]]valueForKey:@"shop_id"],@"shop_id",[[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0] objectAtIndex:[sender tag]]valueForKey:@"shop_name"], @"shop_name", [[[[catAllArray valueForKey:@"shop_list" ] objectAtIndex:0]objectAtIndex:[sender tag]]valueForKey:@"shop_top_seller"],@"shop_top_seller", nil];
    AppDelegate *mydelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [mydelegate.shopNavController pushViewController:detailViewController animated:YES];
  //  [detailViewController release];
    NSLog(@"tapped: %d",[sender tag]);
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
     [detailViewController release];
     */
}

@end
