//
//  HTTableViewController.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/9/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTTableViewController.h"
#import "HTGridCollectionViewController.h"

@interface HTTableViewController ()

@property (nonatomic) NSMutableArray *cellActions;

- (void)initCellActions;

@property (nonatomic, retain) UIDocumentInteractionController *documentController;

@end

@implementation HTTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self initCellActions];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.title = @"TestVacuum";
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initCellActions];
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
    return [self.cellActions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseId = @"GeneralCell";
    
    UITableViewCell *cell = nil;
    
    if (indexPath.row == 2) {
        reuseId = @"GridPreviewCell";
    }
   
    cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    
    // ONE SECTION ONLY
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    HTCellActionItem *cellActionItem = (HTCellActionItem *)[_cellActions objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellActionItem.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTCellActionItem *cellActionItem = (HTCellActionItem *)[_cellActions objectAtIndex:indexPath.row];
    
    [cellActionItem performAction];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark - UIDocumentInteractionControllerDelegate

// All optional

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    NSLog(@"TEST %@", NSStringFromSelector(_cmd));
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application
{
    NSLog(@"TEST2 %@ - %@", NSStringFromSelector(_cmd), application);
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    NSLog(@"TEST3 %@ - %@", NSStringFromSelector(_cmd), application);
}

#pragma mark - Private Helpers

- (void)initCellActions
{
    self.cellActions = [NSMutableArray array];
    
    [self.cellActions addObject:[HTCellActionItem cellActionItem:@"Open PDF Document In..."
                                                withSelector:@selector(openInPDF)
                                                   andTarget:self]];
    [self.cellActions addObject:[HTCellActionItem cellActionItem:@"Open TouchTestID app..."
                                                    withSelector:@selector(openTouchTestID)
                                                       andTarget:self]];
    [self.cellActions addObject:[HTCellActionItem cellActionItem:@"Grid CollectionView"
                                                    withSelector:nil
                                                       andTarget:nil]];
}

- (void)openTouchTestID
{
    NSURL *url = [NSURL URLWithString:@"touchtest-cedb2ab1-fd54-4dde-9e7d-feb2505c9d62://"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        NSLog(@"Can send to applications");
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        NSLog(@"Cannot find the right app");
    }
    
}

- (void)openInPDF
{
    NSString *fileName = @"Git Cheat Sheet.pdf";
    NSString *pathToPDF = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    if (pathToPDF) {
        NSURL *urlToPDF = [NSURL fileURLWithPath:pathToPDF];
        self.documentController = [UIDocumentInteractionController interactionControllerWithURL:urlToPDF];
        self.documentController.delegate = self;
        if ([self.documentController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES])
        {
            NSLog(@"Can send to applications");
        }
    }
}

@end
