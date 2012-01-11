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
@synthesize ConnectButton;
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
    
    connectingTime=0;
    
    //Load the server data if it's already saved
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSString * savedServer =    [currentDefaults stringForKey:@"lastServer"];
    NSString * savedPort =    [currentDefaults stringForKey:@"lastPort"];
    
    if (savedPort==nil) {
        savedPort=@"4303";
    }
    if (savedServer==nil) {
        savedServer=@"localhost";
    }
    
    [PortText setText:savedPort];
    [serverText setText:savedServer];
    
}

- (void)viewDidUnload
{
    [self setPortText:nil];
    [self setServerText:nil];
    [self setSave:nil];
    ConnectButton = nil;
    [self setConnectButton:nil];
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
    
    connecTimer  = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updConnectionTimer) userInfo:nil repeats:YES];


}

-(void)updConnectionTimer{
    if (sharedProtocol.protocol.isConnecting) {
        NSLog(@"Connecting..."); 
        [ConnectButton setTitle:@"Connecting..." forState:UIControlStateNormal];
        connectingTime+=0.2;
        if(connectingTime>10){
            [connecTimer invalidate];
            [ConnectButton setTitle:@"Connection Erro" forState:UIControlStateNormal];
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Timeout" message:@"Cannot connect to the server" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];    
        }

    }
    if (sharedProtocol.protocol.isConnect) {
        NSLog(@"Server connected");
        [connecTimer invalidate];
        [ConnectButton setTitle:@"Connected" forState:UIControlStateNormal];
    }

}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [ConnectButton setTitle:@"Connect" forState:UIControlStateNormal];
        connectingTime=0;
        
    }
}

- (IBAction)Save:(id)sender {
    
    [lm saveToUserDefault];
    NSString *serverSave=[serverText text];
    NSString *portSave=[PortText text];
    
    [[NSUserDefaults standardUserDefaults]setValue:portSave forKey:@"lastPort"];
    [[NSUserDefaults standardUserDefaults]setValue:serverSave forKey:@"lastServer"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

}
@end
