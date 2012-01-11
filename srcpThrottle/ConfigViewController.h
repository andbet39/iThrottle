//
//  ConfigViewController.h
//  srcpThrottle
//
//  Created by Andrea on 30/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketManager.h"
#import "Locomotiva.h"
#import "Protocol.h"
#import "SRCPProtocol.h"
#import "ProtocolManager.h"

@interface ConfigViewController : UITableViewController <UIAlertViewDelegate>
{

    LocomotiveManager * lm;
    ProtocolManager  * sharedProtocol;
    
    NSTimer *connecTimer;
    float connectingTime;


}
@property (weak, nonatomic) IBOutlet UITextField *PortText;
@property (weak, nonatomic) IBOutlet UITextField *serverText;
@property (weak, nonatomic) IBOutlet UIButton *ConnectButton;



- (IBAction)Connect:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Save;
- (IBAction)Save:(id)sender;

@end
