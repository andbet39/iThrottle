//
//  LocoControllerViewController.m
//  srcpThrottle
//
//  Created by Andrea on 27/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocoControllerViewController.h"

@implementation LocoControllerViewController


@synthesize speedSlider;
@synthesize  controlledLoco;


- (IBAction)StopAction:(id)sender {
    
    [AddressLabel setText: [NSString stringWithFormat:@"%d", controlledLoco.address]];

}

-(void)initzializeWithLoco:(Locomotiva *)l {


    controlledLoco =l;
    [AddressLabel setText: [NSString stringWithFormat:@"%d", controlledLoco.address]];

}

-(void)updInfoTime{
    
    [sharedProtocol.protocol getInfoLoco:controlledLoco];
    
   //update slider velocita 
    
    int speed = controlledLoco.speed*speedSlider.maximumValue/controlledLoco.max_speed;
    
    [speedSlider setValue:speed];
    [speedLabel setText:[NSString stringWithFormat:@"%d",controlledLoco.speed]];

    UIImage * btn_bck1;
    UIImage * btn_bck2;
    UIImage * btn_bck3;
    UIImage * btn_bck4;
    UIImage * btn_bck5;
    
    
    if(controlledLoco.dir==kBackWard){
        [dirButton setBackgroundImage:[UIImage imageNamed:@"dir_forw@2x.png"] forState:UIControlStateNormal];
        
    }else{
        [dirButton setBackgroundImage:[UIImage imageNamed:@"dir_back@2x.png"] forState:UIControlStateNormal];
        
    }

    
    if(!controlledLoco.f1){
        [FnButton setBackgroundImage:[UIImage imageNamed:@"fn_red@2x.png"] forState:UIControlStateNormal];
        
    }else{
        [FnButton setBackgroundImage:[UIImage imageNamed:@"fn_green@2x.png"] forState:UIControlStateNormal];
        
    }

    if(!controlledLoco.f2){
        btn_bck2=[UIImage imageNamed:@"f1_red@2x.png"];
        
    }else{
        btn_bck2=[UIImage imageNamed:@"f1_green@2x.png"];
        
    }
    [F1Button setBackgroundImage:btn_bck2 forState:UIControlStateNormal];

    if(!controlledLoco.f3){
        btn_bck3=[UIImage imageNamed:@"f2_red@2x.png"];
        
    }else{
        btn_bck3=[UIImage imageNamed:@"f2_green@2x.png"];
        
    }
    [F2Button setBackgroundImage:btn_bck3 forState:UIControlStateNormal];
    if(!controlledLoco.f4){
        btn_bck4=[UIImage imageNamed:@"f3_red@2x.png"];
        
    }else{
        btn_bck4=[UIImage imageNamed:@"f3_green@2x.png"];
        
    }
    [F3Button setBackgroundImage:btn_bck4 forState:UIControlStateNormal];


    if(!controlledLoco.f5){
        btn_bck5=[UIImage imageNamed:@"f4_red@2x.png"];
        
    }else{
        btn_bck5=[UIImage imageNamed:@"f4_green@2x.png"];
        
    }
    [F4Button setBackgroundImage:btn_bck5 forState:UIControlStateNormal];
    
}



- (IBAction)FnButtonPress:(id)sender {
    
    
    UIImage * btn_bck;
    
    if(controlledLoco.f1){
        [controlledLoco setF1:FALSE];
         btn_bck=[UIImage imageNamed:@"fn_red@2x.png"];
        
    }else{
        [controlledLoco setF1:TRUE];
        btn_bck=[UIImage imageNamed:@"fn_green@2x.png"];

    }
    [sharedProtocol.protocol updateLoco:controlledLoco];
    [FnButton setBackgroundImage:btn_bck forState:UIControlStateNormal];


}

- (IBAction)sliderSpeedChanged:(id)sender {
    
    
    int speed = speedSlider.value/speedSlider.maximumValue*controlledLoco.max_speed;
    
    [speedLabel setText:[NSString stringWithFormat:@"%d",speed]];
    [controlledLoco setSpeed:speed ];
    [sharedProtocol.protocol updateLoco:controlledLoco];
    
    
    
}
- (IBAction)stopButtonPress:(id)sender{
    int speed = 0;
    
    [speedLabel setText:[NSString stringWithFormat:@"%d",speed]];
    [controlledLoco setSpeed:speed ];
    [sharedProtocol.protocol updateLoco:controlledLoco];


}
- (IBAction)F1ButtonPress:(id)sender {
    UIImage * btn_bck;
    
    if(controlledLoco.f2){
        [controlledLoco setF2:FALSE];
        btn_bck=[UIImage imageNamed:@"f1_red@2x.png"];
        
    }else{
        [controlledLoco setF2:TRUE];
        btn_bck=[UIImage imageNamed:@"f1_green@2x.png"];
        
    }
    [sharedProtocol.protocol updateLoco:controlledLoco];
    [F1Button setBackgroundImage:btn_bck forState:UIControlStateNormal];
   }

- (IBAction)F2ButtonPress:(id)sender {
    UIImage * btn_bck;
    
    if(controlledLoco.f3){
        [controlledLoco setF3:FALSE];
        btn_bck=[UIImage imageNamed:@"f2_red@2x.png"];
        
    }else{
        [controlledLoco setF3:TRUE];
        btn_bck=[UIImage imageNamed:@"f2_green@2x.png"];
        
    }
    [sharedProtocol.protocol updateLoco:controlledLoco];
    [F2Button setBackgroundImage:btn_bck forState:UIControlStateNormal];
}

- (IBAction)F3ButtonPress:(id)sender {
    UIImage * btn_bck;
    
    if(controlledLoco.f4){
        [controlledLoco setF4:FALSE];
        btn_bck=[UIImage imageNamed:@"f3_red@2x.png"];
        
    }else{
        [controlledLoco setF4:TRUE];
        btn_bck=[UIImage imageNamed:@"f3_green@2x.png"];
        
    }
    [sharedProtocol.protocol updateLoco:controlledLoco];
    [F3Button setBackgroundImage:btn_bck forState:UIControlStateNormal];
}

- (IBAction)F4ButtonPress:(id)sender {
    UIImage * btn_bck;
    
    if(controlledLoco.f5){
        [controlledLoco setF5:FALSE];
        btn_bck=[UIImage imageNamed:@"f4_red@2x.png"];
        
    }else{
        [controlledLoco setF5:TRUE];
        btn_bck=[UIImage imageNamed:@"f4_green@2x.png"];
        
    }
    [sharedProtocol.protocol updateLoco:controlledLoco];
    [F4Button setBackgroundImage:btn_bck forState:UIControlStateNormal];
}

- (IBAction)dirButtonPress:(id)sender {
    
    
    UIImage * btn_bck;
    
    if(controlledLoco.dir==kForward){
        [controlledLoco setDir:kBackWard];
        btn_bck=[UIImage imageNamed:@"dir_back@2x.png"];
        
    }else{
        [controlledLoco setDir:kForward];
        btn_bck=[UIImage imageNamed:@"dir_forw@2x.png"];
        
    }
    [sharedProtocol.protocol updateLoco:controlledLoco];
    [dirButton setBackgroundImage:btn_bck forState:UIControlStateNormal];
    
    
    
    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [AddressLabel setText: [NSString stringWithFormat:@"%d", controlledLoco.address]];

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [AddressLabel setText: [NSString stringWithFormat:@"%d", controlledLoco.address]];

    [navBar setTitle:controlledLoco.identifier];
    
    UIImage *sliderThumb = [UIImage imageNamed:@"slider.png"];
    
    
    [speedSlider setThumbImage:sliderThumb forState:UIControlStateNormal];
    [speedSlider setThumbImage:sliderThumb forState:UIControlStateHighlighted];
    
    
    
    UIImage *minImage = [UIImage imageNamed:@"pixel.png"];
	UIImage *maxImage = [UIImage imageNamed:@"pixel.png"];
    
  
    
	minImage=[minImage stretchableImageWithLeftCapWidth:100.0 topCapHeight:0.0];
	maxImage=[maxImage stretchableImageWithLeftCapWidth:100.0 topCapHeight:0.0];
    
    [speedSlider setMinimumTrackImage:minImage forState:UIControlStateNormal];
	[speedSlider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    
    
    UIFont* font = [UIFont fontWithName:@"Electronic Highway Sign" size:30];
    
    [speedLabel setFont:font];
    [staticSpeedLabel setFont:font];
    
    
    UIFont* font2 = [UIFont fontWithName:@"Electronic Highway Sign" size:28];
    
    [AddressLabel setFont:font2];
    [staticAddressLabel setFont:font2];
    
    //Inizializza il gestor del protocollo
    sharedProtocol =[ProtocolManager sharedManager];
    
    if(sharedProtocol.isBidirection){
        updTimer = [NSTimer scheduledTimerWithTimeInterval:UPD_INTERVAL target:self selector:@selector(updInfoTime) userInfo:controlledLoco repeats:YES];
    }
    
}


- (void)viewDidUnload
{
    AddressLabel = nil;
    FnButton = nil;
    F1Button = nil;
    F2Button = nil;
    F3Button = nil;
    F4Button = nil;
    speedSlider = nil;
    [self setSpeedSlider:nil];
    navBar = nil;
    dirButton = nil;
    dirButton = nil;
    speedLabel = nil;
    staticAddressLabel = nil;
    staticSpeedLabel = nil;
     [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
