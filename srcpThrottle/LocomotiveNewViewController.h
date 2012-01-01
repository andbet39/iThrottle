//
//  LocomotiveNewViewController.h
//  srcpThrottle
//
//  Created by Andrea on 27/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Locomotiva.h"

@class LocomotiveNewViewController;

@protocol LocomotiveNewViewControllerDelegate <NSObject>
- (void)locomotiveNewViewControllerDidCancel:(LocomotiveNewViewController *)controller;
- (void)locomotiveNewViewControllerDidSave:(LocomotiveNewViewController *)controller didAddLoco:(Locomotiva *)l;
@end

@interface LocomotiveNewViewController : UITableViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *AddressText;
@property (weak, nonatomic) IBOutlet UITextField *idText;
@property (weak, nonatomic) IBOutlet UITextField *stepText;

@property (nonatomic, weak) id <LocomotiveNewViewControllerDelegate> delegate;
- (IBAction)ImageClick:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

- (IBAction)doneButtonOnKeyboardPressed:(id)sender;
- (IBAction)AddressDone:(id)sender;
@end

