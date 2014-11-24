//
//  HTTableViewController.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/9/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTTableViewController.h"
#import "HTImageZoomViewController.h"

NSUInteger const kSectionCount = 1;
NSUInteger const kOpenPDFRow = 0;
NSUInteger const kOpenTouchTestIDRow = 1;
NSUInteger const kGridPreviewRow = 2;
NSUInteger const kImageZoomRow = 3;

NSString * const kTitleName = @"TestVacuum";
NSString * const kGeneralCellId = @"GeneralCell";
NSString * const kGridPreviewCellId = @"GridPreviewCell";
NSString * const kImageZoomCellId = @"ImageZoomCell";

@interface HTTableViewController ()

@property (nonatomic) NSMutableArray *cellActions;

- (void)initCellActions;
- (void)addCellAction:(NSString *)title withSelector:(SEL)action andTarget:(id)target atIndex:(NSUInteger)index;
- (void)openTouchTestID;
- (void)openInPDF;

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
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    self.title = kTitleName;
    
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
    return kSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.cellActions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    NSString *reuseId = [self getReuseID:indexPath.row];
    
    cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    
    // ONE SECTION ONLY
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    HTCellActionItem *cellActionItem = (HTCellActionItem *)[_cellActions objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cellActionItem.title;
    
    return cell;
}

- (NSString * const)getReuseID:(NSUInteger)row
{
    switch (row) {
        case kOpenPDFRow:
        case kOpenTouchTestIDRow:
        {
            return kGeneralCellId;
        }
        case kGridPreviewRow:
        {
            return kGridPreviewCellId;
            break;
        }
        case kImageZoomRow:
        {
            return kImageZoomCellId;
            break;
        }
        default:
        {
            NSAssert(NO, @"Row ID not defined");
            break;
        }
    }
    
    return nil;
}

#pragma mark TableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTCellActionItem *cellActionItem = (HTCellActionItem *)[_cellActions objectAtIndex:indexPath.row];
    
    [cellActionItem performAction];
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
    // This initializes the array of actions for the cells to take
    
    // TODO: Use NSLocalizedString for title information instead of hard coded
    self.cellActions = [NSMutableArray array];
    
    // Row indexes are defined at the top of this file to adjust easily
    [self addCellAction:@"Open PDF Document In..."
           withSelector:@selector(openInPDF)
              andTarget:self
                atIndex:kOpenPDFRow];
    
    [self addCellAction:@"Open TouchTestID app..."
           withSelector:@selector(openTouchTestID)
              andTarget:self
                atIndex:kOpenTouchTestIDRow];
    
    [self addCellAction:@"Grid CollectionView"
           withSelector:nil
              andTarget:nil
                atIndex:kGridPreviewRow];
    
    [self addCellAction:@"Zoom Image"
           withSelector:@selector(pushZoomController)
              andTarget:self
                atIndex:kImageZoomRow];
}

- (void)addCellAction:(NSString *)title withSelector:(SEL)action andTarget:(id)target atIndex:(NSUInteger)index
{
    HTCellActionItem *actionItem = [HTCellActionItem cellActionItem:title
                                                       withSelector:action
                                                          andTarget:target];
    [self.cellActions insertObject:actionItem atIndex:index];
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

- (void)pushZoomController
{
    HTImageZoomViewController *controller = [[HTImageZoomViewController alloc] initWithNibName:@"HTImageZoomViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
