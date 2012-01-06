//
//  Locomotiva.m
//  srcpThrottle
//
//  Created by Andrea on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Locomotiva.h"



@implementation Locomotiva

@synthesize identifier,locoThumb,speed,max_speed,dir,address,f1,f2,f3,f4,f5,bus,isError,isInitiated;

-(id) init
{
    
    locoThumb =[[UIImage alloc]init];
    
    speed = 0;
    address = 0;
    max_speed=0;
    
    dir=kForward;
    
    bus=SRCP_LOCO_BUS;
    
    f1=false;
    f2=false;
    f3=false;
    f4=false;
    f5=false;
    
    isError=false;
    isInitiated=false;
    
    
    return self;
    
}
    
-(id)initWithAddress:(int)add {
    
    self=[self init];
    
    address=add;
    
    
    return self;
    
}

-(id)initWithAllParam:(int)add Identifier:(NSString *) _identifier MaxSpeed:(int)_max_speed ThumImage:(UIImage *)thumb{
    
    self=[self init];
    
    self.address=add;
    self.identifier=_identifier;
    self.max_speed=_max_speed;
    self.locoThumb=thumb;
    
    
    return self;
    
}

#pragma mark NSCoding

#define kIdentifierKey  @"Identifier"
#define kAddressKey  @"Address"
#define kImageKey  @"Image"
#define kMaxSpeedKey  @"MaxSpeed"


- (void) encodeWithCoder:(NSCoder *)encoder {
    
    NSData *fullImageData = UIImagePNGRepresentation(locoThumb);

    [encoder encodeObject:fullImageData forKey:kImageKey];
    [encoder encodeObject:identifier forKey:kIdentifierKey];
    [encoder encodeInt:address forKey:kAddressKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    
    NSString *_identifier = [decoder decodeObjectForKey:kIdentifierKey];
    int _address = [decoder decodeIntForKey:kAddressKey];
    int _max_speed= [decoder decodeIntForKey:kMaxSpeedKey];
    
    UIImage * _locoThumb=[UIImage imageWithData:[decoder decodeObjectForKey:kImageKey]];
    
    return [self initWithAllParam:_address Identifier:_identifier MaxSpeed:_max_speed ThumImage:_locoThumb];
    
}
    
  
@end
