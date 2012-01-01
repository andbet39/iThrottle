//
//  LocoTableCell.h
//  srcpThrottle
//
//  Created by Andrea on 19/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Locomotiva.h"
#import "ProtocolManager.h"
#import "LocoControllerViewController.h"
@interface LocoTableCell : UITableViewCell
{
    ProtocolManager *sharedProtocol;

    Locomotiva *cellLoco;
    
    NSTimer * cellTick;
}

@property(nonatomic,retain)IBOutlet UILabel * speedLabelCell;
@property(nonatomic,retain)IBOutlet UILabel * addressLabelCell;
@property(nonatomic,retain)IBOutlet UILabel * identifierLabelCell;

@property(nonatomic,retain)IBOutlet UISlider * speedSlider;
@property(nonatomic,retain)IBOutlet UIImageView * locoThumb;

@property(nonatomic,retain)Locomotiva * cellLoco;

- (IBAction)SpeedChanged:(id)sender;
-(IBAction)StopPress:(id)sender;

-(void)initzializewithloc:(Locomotiva*)locom;




@end
