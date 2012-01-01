//
//  LocoControllerViewController.h
//  srcpThrottle
//
//  Created by Andrea on 27/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Locomotiva.h"
#import "LocomotiveManager.h"
#import "ProtocolManager.h"
#define UPD_INTERVAL 0.5


@interface LocoControllerViewController : UIViewController
{
    Locomotiva *controlledLoco;
    LocomotiveManager * lm;
    ProtocolManager  * sharedProtocol;
    NSTimer *updTimer;
    
    __weak IBOutlet UILabel *AddressLabel;
    __weak IBOutlet UILabel *speedLabel;
    __weak IBOutlet UIButton *FnButton;
    __weak IBOutlet UIButton *F1Button;
    __weak IBOutlet UIButton *F2Button;
    __weak IBOutlet UIButton *F3Button;
    __weak IBOutlet UIButton *F4Button;
    __weak IBOutlet UISlider *speedSlider;
    __weak IBOutlet UINavigationItem *navBar;
    __weak IBOutlet UIButton *dirButton;

    __weak IBOutlet UILabel *staticAddressLabel;
    __weak IBOutlet UILabel *staticSpeedLabel;
}
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

@property (nonatomic,retain) Locomotiva * controlledLoco;

-(IBAction)StopAction:(id)sender;
-(void)initzializeWithLoco:(Locomotiva *)l ;
- (IBAction)FnButtonPress:(id)sender;
- (IBAction)sliderSpeedChanged:(id)sender;

- (IBAction)F1ButtonPress:(id)sender;
- (IBAction)F2ButtonPress:(id)sender;
- (IBAction)F3ButtonPress:(id)sender;
- (IBAction)F4ButtonPress:(id)sender;
- (IBAction)dirButtonPress:(id)sender;
- (IBAction)stopButtonPress:(id)sender;



@end
