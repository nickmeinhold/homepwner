//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Nick Meinhold on 29/03/2014.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

-(IBAction)addNewItem:(id)sender
{
    
    // make a new index path for the 0th section, last row
    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // insert this new row into the table
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

-(IBAction)togglleEditMode:(id)sender
{
    
    // if you are currently in editng mode
    if(self.isEditing)
    {
        // change the text of the button to inform the user of the state
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        
        // turn off edting mode
        [self setEditing:NO animated:YES];
    }
    else
    {
        // change the text of the button to inform the user of the state
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        
        // enter edting mode
        [self setEditing:YES animated:YES];
    }
    
}

-(UIView*)headerView
{
    // if you have not loaded the header view yet
    if(!_headerView)
    {
        // load headerview.xib
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
    }
    
    return _headerView;
    
}

-(instancetype)init
{
    // call the super class's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if(self)
    {
        for(int i = 0; i < 5; i++)
        {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init]; 
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    UIView *header = self.headerView;
    [self.tableView setTableHeaderView:header];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get a new or reused cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the tableview
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    return cell;
    
}

@end
