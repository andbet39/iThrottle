//
//  LocoListViewController.m
//  srcpThrottle
//
//  Created by Andrea on 19/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocoListViewController.h"

#import "LocoTableCell.h"


@implementation LocoListViewController

@synthesize activeLocosArray;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)DetailPressed:(id)sender{

    
  }

- (IBAction)editPress:(id)sender {
    
    if(isEditable==FALSE){
        isEditable=TRUE;
        [editButton setStyle:UIBarButtonItemStyleDone];
        [editButton setTitle:@"Done"];

        
    }
    else{
        isEditable=FALSE;
    [editButton setTitle:@"Edit"];
        [editButton setStyle:UIBarButtonItemStyleBordered];
        [editButton setTitle:@"Edit"];
        

    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"addLoco"])
	{
		UINavigationController *navigationController = 
        segue.destinationViewController;
		LocomotiveNewViewController 
        *locomotiveNewViewController = 
        [[navigationController viewControllers] 
         objectAtIndex:0];
		locomotiveNewViewController.delegate = self;
	}
    
    
    if ([segue.identifier isEqualToString:@"controlLoco"])
    {
        LocoControllerViewController *locoController = (LocoControllerViewController *)[segue destinationViewController];
        
        locoController.controlledLoco=selectedLoco;        
        
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    selectedLoco = [self.activeLocosArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"controlLoco" sender:self];

    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    sharedProtocol = [ProtocolManager sharedManager];
    isEditable=FALSE;
     lm =[LocomotiveManager sharedManager];
    activeLocosArray=[[NSMutableArray alloc]initWithArray:[lm.locomotivesArray allValues]];
    
    
    if(sharedProtocol.isBidirection){
        locosUpdateTime = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updLocos) userInfo:nil repeats:YES];
    }
}


-(void)updLocos{

    for(Locomotiva * l in activeLocosArray){
        
        [sharedProtocol.protocol getInfoLoco:l];
    
    }

}

- (void)viewDidUnload
{
    editButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    locosUpdateTime = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updLocos) userInfo:nil repeats:YES];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [locosUpdateTime invalidate];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - LocomotiveNewViewControllerDelegate

- (void)locomotiveNewViewControllerDidCancel:(LocomotiveNewViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}



- (void)locomotiveNewViewControllerDidSave:(LocomotiveNewViewController *)controller didAddLoco: (Locomotiva *)l
{
	
    //Aggiunge la locomotiva al manager
    [lm addNewLoco:l];
    //rigenera array delle locomotive attive
    
    [activeLocosArray removeAllObjects];
    [activeLocosArray addObjectsFromArray: [lm.locomotivesArray allValues]];

    
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.activeLocosArray indexOfObject:l] inSection:0];
	[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return [activeLocosArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LocoCell";
    
    LocoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    [cell initzializewithloc:[activeLocosArray objectAtIndex:indexPath.row]];

    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return isEditable;
}
 
 
 
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Locomotiva *rm = [activeLocosArray objectAtIndex:indexPath.row];
        [lm removeLoco:rm];
        
        [activeLocosArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }   
    
}


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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

  
}

@end
