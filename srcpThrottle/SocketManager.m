//
//  SocketManager.m
//  srcpThrottle
//
//  Created by Andrea on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SocketManager.h"
#import "ProtocolManager.h"

@implementation SocketManager

@synthesize outputStream,inputStream;

@synthesize messages;




-(void) Connect:(NSString *) server_address port:(int) port
{
    
    CFReadStreamRef readStream;
	CFWriteStreamRef writeStream;
	CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)server_address, port, &readStream, &writeStream);
	
	inputStream = (__bridge NSInputStream *)readStream;
	outputStream = (__bridge NSOutputStream *)writeStream;
    
	[inputStream setDelegate:self];
	[outputStream setDelegate:self];
	[inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[inputStream open];
	[outputStream open];  
    
    messages = [[NSMutableArray alloc] init];

}
    

- (void)sendMessage:(NSString *)message {
    
    NSString *response  = [NSString stringWithFormat:@"%@\n", message];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
	message = @"";

}




- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
	NSLog(@"stream event %i", streamEvent);
	
	switch (streamEvent) {
			
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
			break;
		case NSStreamEventHasBytesAvailable:
            
			if (theStream == inputStream) {
				
				uint8_t buffer[1024];
				int len;
				
				while ([inputStream hasBytesAvailable]) {
					len = [inputStream read:buffer maxLength:sizeof(buffer)];
					if (len > 0) {
						
						NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
						
						if (nil != output) {
                            
							NSLog(@"server said: %@", output);
							[self messageReceived:output];
							
						}
					}
				}
			}
			break;
            
			
		case NSStreamEventErrorOccurred:
			
			NSLog(@"Can not connect to the host!");
			break;
			
		case NSStreamEventEndEncountered:
            NSLog(@" NSStreamEventEndEncountere");

            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream = nil;
			
			break;
		default:
			NSLog(@"Unknown event");
            
            

	}
    
}

- (void) messageReceived:(NSString *)message {
		
    [messages addObject:message];
    ProtocolManager *prt =[ProtocolManager sharedManager];
    [prt.protocol update];
    
    NSLog([NSString stringWithFormat:@"%@",message ]);
    
    reply=message;
    NSLog(@"Messaggio ricevuto");
    
    
    
}






@end
