//
//  LocoTableCell.m
//  srcpThrottle
//
//  Created by Andrea on 19/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocoTableCell.h"

@implementation LocoTableCell


@synthesize speedLabelCell,addressLabelCell,identifierLabelCell,speedSlider,cellLoco,locoThumb;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
           }
    return self;
}


-(void)initzializewithloc:(Locomotiva*)locom{

    
    sharedProtocol = [ProtocolManager sharedManager];
    UIFont* font = [UIFont fontWithName:@"Electronic Highway Sign" size:16];
    UIFont* font2 = [UIFont fontWithName:@"Electronic Highway Sign" size:20];
    
    [speedLabelCell setFont:font];
    [addressLabelCell setFont:font];
    [identifierLabelCell setFont:font2];
    
    
     UIImage *sliderThumb = [UIImage imageNamed:@"CellSlider.png"];
    
    
    [speedSlider setThumbImage:sliderThumb forState:UIControlStateNormal];
    [speedSlider setThumbImage:sliderThumb forState:UIControlStateHighlighted];
    
    
    
    UIImage *minImage = [UIImage imageNamed:@"pixel.png"];
	UIImage *maxImage = [UIImage imageNamed:@"pixel.png"];
    
    [speedSlider setMaximumValue:locom.max_speed];
    [speedSlider setMinimumValue:locom.max_speed*(-1) ];
    
	minImage=[minImage stretchableImageWithLeftCapWidth:100.0 topCapHeight:0.0];
	maxImage=[maxImage stretchableImageWithLeftCapWidth:100.0 topCapHeight:0.0];
    
    [speedSlider setMinimumTrackImage:minImage forState:UIControlStateNormal];
	[speedSlider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    moveto:
    cellLoco=locom;
    int speed = cellLoco.speed*speedSlider.maximumValue/cellLoco.max_speed;

    [speedLabelCell setText:[NSString stringWithFormat:@"Speed: %d",speed]];
    
    [addressLabelCell setText:[NSString stringWithFormat:@"Add.: %d",cellLoco.address]];
    [identifierLabelCell setText:[NSString stringWithFormat:@"%@",cellLoco.identifier]];    [speedSlider setValue:cellLoco.speed];
    
    cellTick = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updInfoTime) userInfo:locom repeats:YES];
    [locoThumb setImage:locom.locoThumb];
    
    
}
- (IBAction)SpeedChanged:(id)sender{
    
    int speed = speedSlider.value/speedSlider.maximumValue*cellLoco.max_speed;
    
    if(speed<0)[cellLoco setDir:kForward];
    if(speed>0)[cellLoco setDir:kBackWard];

    [cellLoco setSpeed:abs(speed) ];
    
    [sharedProtocol.protocol updateLoco:cellLoco];

}
-(IBAction)StopPress:(id)sender{

    int speed = 0;
    
    if(speed<0)[cellLoco setDir:kForward];
    if(speed>0)[cellLoco setDir:kBackWard];
    
    [cellLoco setSpeed:abs(speed) ];
    
    [sharedProtocol.protocol updateLoco:cellLoco];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)updInfoTime{

    NSString * dir_string;
    
    int speed = 0;
    
    if(cellLoco.dir==kBackWard){
        dir_string=@">";
         speed = cellLoco.speed*speedSlider.maximumValue/cellLoco.max_speed;

    }else
    {
        dir_string=@"<";
        speed = (cellLoco.speed*speedSlider.maximumValue/cellLoco.max_speed)*-1;

    }
    
    
    [speedSlider setValue:speed];
    [speedLabelCell setText:[NSString stringWithFormat:@"Speed: %@%d ",dir_string, abs(speed)]];
    
    [addressLabelCell setText:[NSString stringWithFormat:@"Add.: %d",cellLoco.address]];

    [identifierLabelCell setText:[NSString stringWithFormat:@"%@",cellLoco.identifier]];
    
    


}

@end
