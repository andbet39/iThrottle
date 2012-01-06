//
//  ConfigViewController.m
//  srcpThrottle
//
//  Created by Andrea on 30/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"


@implementation ConfigViewController
@synthesize Save;
@synthesize serverText;
@synthesize PortText;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (IBAction)doneButtonOnKeyboardPressed:(id)sender {
    [sender resignFirstResponder];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    lm =[LocomotiveManager sharedManager];
}

- (void)viewDidUnload
{
    [self setPortText:nil];
    [self setServerText:nil];
    [self setSave:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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

- (IBAction)Connect:(id)sender {
    
    sharedProtocol=[ProtocolManager sharedManager];
    sharedProtocol.protocol= (Protocol*)[[SRCPProtocol alloc]initWithServer:[serverText text] port:[PortText.text intValue]];
    
    [sharedProtocol.protocol Connect];
    

}
- (IBAction)Save:(id)sender {
    
    [lm saveToUserDefault];

}
@end
