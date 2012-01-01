//
//  LocomotiveNewViewController.m
//  srcpThrottle
//
//  Created by Andrea on 27/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LocomotiveNewViewController.h"

@implementation LocomotiveNewViewController

@synthesize imageView;
@synthesize AddressText;
@synthesize idText;
@synthesize stepText;
@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)ImageClick:(id)sender{
UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Insert Photo" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Library", nil];
    
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	
    [popupQuery showInView:self.view];
	
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if (buttonIndex == 0) {
        
        
        
        UIImageView * ovewrlayView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mirino.png"]];
        
        ovewrlayView.contentMode = UIViewContentModeCenter;
        ovewrlayView.clipsToBounds = NO;
        ovewrlayView.contentMode = UIViewContentModeScaleAspectFit;  
        ovewrlayView.frame = CGRectMake(22.0f, 180.0f, 276.0f, 138.0f);
    
    
        
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setDelegate:self];
        [picker setAllowsEditing:YES];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;

        picker.cameraOverlayView =(UIView*) ovewrlayView;
        
        
        [self presentModalViewController:picker animated:YES];
		
    } else if (buttonIndex == 1) {
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setDelegate:self];
        [picker setAllowsEditing:YES];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentModalViewController:picker animated:(YES)];
		
    } 
    
    
}

- (UIImage*)imageWithImage:(UIImage*)image 
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
	
    
    	
    CGSize  reducedSize= CGSizeMake(520,640 );
    UIGraphicsBeginImageContext(reducedSize);
    [image drawInRect:CGRectMake(0,0,reducedSize.width,reducedSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
	CGImageRef imgRef = CGImageCreateWithImageInRect([newImage CGImage], CGRectMake(35.0f, 270.0f, 440.0f, 220.0f));
	
	UIImage* cropedImg =[UIImage imageWithCGImage:imgRef];
	CGImageRelease(imgRef);
    
    
    [imageView setImage:cropedImg];
	[picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}
- (IBAction)cancel:(id)sender
{
	[self.delegate locomotiveNewViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    
    
    int   dec_step= [stepText.text intValue];
    
    if((dec_step != 14) && (dec_step != 128) && (dec_step != 28)){
    
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Invalid decoder step" message:@"Check value for decoder step (14,28,128)" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }else{
        
    
    
        Locomotiva * l = [[Locomotiva alloc]initWithAddress:[AddressText.text intValue]];
    
            l.max_speed=[stepText.text intValue];
        l.identifier = [idText text];
        l.locoThumb = imageView.image;
    
    
    
        [self.delegate locomotiveNewViewControllerDidSave:self didAddLoco:l];
    }
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setAddressText:nil];
    [self setIdText:nil];
    [self setStepText:nil];
    [self setImageView:nil];
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

- (IBAction)doneButtonOnKeyboardPressed:(id)sender {
    [sender resignFirstResponder];
}



@end
