//
//  LocoListViewController.h
//  srcpThrottle
//
//  Created by Andrea on 19/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SynthesizeSingleton.h"
#import "LocomotiveManager.h"
#import "ProtocolManager.h"
#import "LocomotiveNewViewController.h"
#import "LocoControllerViewController.h"

@interface LocoListViewController : UITableViewController <LocomotiveNewViewControllerDelegate>
{

    LocomotiveManager *lm;
    ProtocolManager *sharedProtocol;
    
    Locomotiva *selectedLoco;

    NSMutableArray * activeLocosArray;
    
    NSTimer * locosUpdateTime;
    
    __weak IBOutlet UIBarButtonItem *editButton;
    bool isEditable;
    
}

-(IBAction)DetailPressed:(id)sender;
- (IBAction)editPress:(id)sender;


@property (nonatomic,retain) NSArray * activeLocosArray;


@end
