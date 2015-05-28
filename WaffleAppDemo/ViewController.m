//
//  ViewController.m
//  WaffleAppDemo
//
//  Created by Sebastian Cain on 5/27/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property UIAlertController* alert;

@property BOOL coverChanging;
@property BOOL imageChanging;

@property UIScrollView *coverScrollView;

@property UIButton *keyboardDoneButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    // View setup done here.
    
    // Header Setup
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    [header setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:header];
    
    // Button Setup
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 75, 40)];
    [cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont fontWithName:@"Ubuntu-Light" size:15]];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [cancelButton.layer setCornerRadius:3];
    [cancelButton.layer setBorderWidth:1];
    [cancelButton.layer setBorderColor:[[UIColor colorWithWhite:.9 alpha:1] CGColor]];
    [cancelButton setTitleColor:[UIColor colorWithWhite:.9 alpha:1] forState:UIControlStateHighlighted];
    
    [header addSubview:cancelButton];
    
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-85, 10, 75, 40)];
    [nextButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton.titleLabel setFont:[UIFont fontWithName:@"Ubuntu-Light" size:15]];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [nextButton.layer setCornerRadius:3];
    [nextButton.layer setBorderWidth:1];
    [nextButton.layer setBorderColor:[[UIColor colorWithWhite:.9 alpha:1] CGColor]];
    [nextButton setTitleColor:[UIColor colorWithWhite:.9 alpha:1] forState:UIControlStateHighlighted];
    
    [header addSubview:nextButton];
    
    // Title Setup
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    [title setTextAlignment:NSTextAlignmentCenter];
    [title setText:@"New Post"];
    [title setFont:[UIFont fontWithName:@"Ubuntu" size:24]];
    [title.layer setPosition:CGPointMake(self.view.frame.size.width/2, 30)];
    [header addSubview:title];
    
    // Content
    
    UIScrollView *content = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-60)];
    [content setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+80)];
	[content setBounces:NO];
    [self.view addSubview:content];
	
	self.content = content;
    
    // Cover Photo Setup
    
    UIScrollView *coverScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    self.coverScrollView = coverScrollView;
    coverScrollView.minimumZoomScale = 0.125;
    coverScrollView.maximumZoomScale = 2;
    coverScrollView.tag = 1;
    coverScrollView.delegate = self;
    [content addSubview:coverScrollView];
	
    UIImageView *coverPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    [coverPhoto setBackgroundColor:[UIColor blackColor]];
	[coverPhoto setContentMode:UIViewContentModeScaleAspectFill];
    self.coverPhoto = coverPhoto;
    [self.coverScrollView addSubview:coverPhoto];
	[coverPhoto setClipsToBounds:YES];
	
    UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 105, 25, 25)];
    [cameraButton addTarget:self action:@selector(coverCameraPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cameraButton setImage:[UIImage imageNamed:@"Camera-White"] forState:UIControlStateNormal];
    [cameraButton.imageView setContentMode: UIViewContentModeScaleAspectFit];
    
    [content addSubview:cameraButton];
    
    [coverPhoto setClipsToBounds:YES];
    
    
    // Body Setup
    
	UIView *body = [[UIView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-210)];
    [content addSubview:body];
    
    //	CADisplayLink *svHeight = [CADisplayLink displayLinkWithTarget:self selector:@selector(svHeight)];
    //	[svHeight addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    UITextField *waffleFlavour = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 64)];
    [waffleFlavour setTextColor:[UIColor blackColor]];
    [waffleFlavour setTintColor:[UIColor blackColor]];
    [waffleFlavour setPlaceholder:@"Flavour of Waffle"];
    [waffleFlavour setFont:[UIFont fontWithName:@"Ubuntu" size:36]];
    waffleFlavour.tag = 10;
	[waffleFlavour setFont:[UIFont fontWithName:@"Ubuntu" size:36]];
	[waffleFlavour setReturnKeyType: UIReturnKeyDone];
	[waffleFlavour setDelegate:self];

    
    [body addSubview:waffleFlavour];
    
    UITextView *whatsGoingOn = [[UITextView alloc]initWithFrame:CGRectMake(20, 80, self.view.frame.size.width-40, 100)];
    [whatsGoingOn setTextColor:[UIColor lightGrayColor]];
    [whatsGoingOn setTintColor:[UIColor blackColor]];
	[whatsGoingOn setText:@"What's Going On..."];
    [whatsGoingOn setFont:[UIFont fontWithName:@"Ubuntu-Light" size:24]];
    whatsGoingOn.tag = 11;
	[whatsGoingOn setReturnKeyType: UIReturnKeyDone];
	[whatsGoingOn setDelegate:self];
    [body addSubview:whatsGoingOn];
	
	UILabel *addedPhotoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 200, 200, 50)];
	[addedPhotoLabel setTextAlignment:NSTextAlignmentCenter];
	[addedPhotoLabel setTextColor:[UIColor lightGrayColor]];
	[addedPhotoLabel setFont:[UIFont fontWithName:@"Ubuntu-Light" size:24]];
	[addedPhotoLabel setText:@"Added Photo:"];
	
	[body addSubview:addedPhotoLabel];
	
	UIImageView *addedPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 250, 100, 100)];
	[addedPhoto setBackgroundColor:[UIColor whiteColor]];
    [addedPhoto setContentMode:UIViewContentModeScaleAspectFit];
    [addedPhoto.layer setMasksToBounds:YES];
	self.addedPhoto = addedPhoto;
	[addedPhoto.layer setBorderWidth:1];
	[addedPhoto.layer setBorderColor:[[UIColor colorWithWhite:.9 alpha:1] CGColor]];
	
	[body addSubview:addedPhoto];
    
    //Keyboard notifications
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardHiding:) name:UIKeyboardDidHideNotification object:nil];
}

-(UIView *)inputAccessoryView {
    UIView *toolbar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [toolbar setBackgroundColor:[UIColor whiteColor]];
    
    UIView *shadow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    [shadow setBackgroundColor:[UIColor colorWithWhite:.9 alpha:1]];
    [toolbar addSubview:shadow];
    
    UIImageView *camera = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [camera.layer setPosition:CGPointMake(self.view.frame.size.width/2, 25)];
    [camera setImage:[UIImage imageNamed:@"Camera-Black"]];
    [toolbar addSubview:camera];
    
    UIButton *toolbarCameraButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-37.5, 5, 75, 40)];
    [toolbarCameraButton addTarget:self action:@selector(toolbarCameraPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [toolbarCameraButton.layer setCornerRadius:3];
    [toolbarCameraButton.layer setBorderWidth:1];
    [toolbarCameraButton.layer setBorderColor:[[UIColor colorWithWhite:.9 alpha:1] CGColor]];
    
    [toolbar addSubview:toolbarCameraButton];
    
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 0, 60, 50)];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
    doneButton.hidden = YES;
    self.keyboardDoneButton = doneButton;
    [toolbar addSubview:doneButton];
    
    return toolbar;
}


-(void)coverCameraPressed:(UIButton*)sender{
    self.coverChanging = YES;
    self.imageChanging = NO;
    [self actionSheet:sender];
}

-(void)toolbarCameraPressed:(UIButton*)sender {
    self.coverChanging = NO;
    self.imageChanging = YES;
    [self actionSheet:sender];
}


-(void)actionSheet: (UIButton*)sender{
    // set up Action Sheet (Action Sheet was deprecated, this is the replacement)
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cover Photo"
                                                                   message:@"Would you like to take a new photo or choose an existing one?"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* takePhoto = [UIAlertAction
                                actionWithTitle:@"Take Photo"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Do some thing here
                                    [self startMediaBrowserFromViewController:self usingDelegate:self takePhoto:YES];
                                    
                                }];
    UIAlertAction* chooseExisiting = [UIAlertAction
                                      actionWithTitle:@"Choose Exisiting"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [self startMediaBrowserFromViewController:self usingDelegate:self takePhoto:NO];
                                      }];
    
    UIAlertAction* cancel = [UIAlertAction
                                      actionWithTitle:@"Cancel"
                                      style:UIAlertActionStyleDestructive
                                      handler:^(UIAlertAction * action)
                                      {
                                          [alert dismissViewControllerAnimated:YES completion:nil];
                                      }];
    
    [alert addAction:takePhoto];
    [alert addAction:chooseExisiting];
    [alert addAction:cancel];
    
    
    UIPopoverPresentationController *popupPresenter = [alert
                                                       popoverPresentationController];
    popupPresenter.sourceView = sender;
    popupPresenter.sourceRect = sender.bounds;
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - UIImagePicker

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate takePhoto:(BOOL) takePhoto{
    if (takePhoto) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO || (delegate == nil) || (controller == nil)) {
            return NO;
        }
        UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
        mediaUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // Displays saved pictures and movies, if both are available, from the
        // Camera Roll album.
        

        mediaUI.delegate = delegate;
        self.picker = mediaUI;
        [controller presentViewController: mediaUI animated: YES completion:nil];
        
        
        
        
    }else{
        
        if (([UIImagePickerController isSourceTypeAvailable:
              UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
            || (delegate == nil)
            || (controller == nil))
            return NO;
        
        UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
        mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        // Displays saved pictures and movies, if both are available, from the
        // Camera Roll album.
        
        mediaUI.delegate = delegate;
        self.picker = mediaUI;
        [controller presentViewController: mediaUI animated: YES completion:nil];
        
    }
    return YES;
}

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    UIImage *originalImage, *editedImage, *imageToUse;
    
    // Handle a still image picked from a photo album
    
    editedImage = (UIImage *) [info objectForKey:
                               UIImagePickerControllerEditedImage];
    originalImage = (UIImage *) [info objectForKey:
                                 UIImagePickerControllerOriginalImage];
    
    if (editedImage) {
        imageToUse = editedImage;
    } else {
        imageToUse = originalImage;
    }
    
    if (imageToUse.imageOrientation != UIImageOrientationUp){
    
    UIGraphicsBeginImageContextWithOptions(imageToUse.size, NO, imageToUse.scale);
        [imageToUse drawInRect:(CGRect){0, 0, imageToUse.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        imageToUse = normalizedImage;
    }
	
	
	if (self.imageChanging) {
		self.addedPhoto.image = imageToUse;
	} else {
		self.coverPhoto.image = imageToUse;
	}

    
    if(self.coverChanging){
        self.coverPhoto.frame = CGRectMake(0, 0, imageToUse.size.width, imageToUse.size.height);
        self.coverPhoto.image = imageToUse;
        self.coverPhoto.contentMode = UIViewContentModeScaleAspectFill;
        self.coverScrollView.zoomScale = self.view.frame.size.width / imageToUse.size.width;
        self.coverScrollView.contentSize = imageToUse.size;
        self.coverScrollView.minimumZoomScale = self.view.frame.size.width / imageToUse.size.width;
    }
    if (self.imageChanging) {
        
    }
    
    
    self.imageChanging = NO;
    self.coverChanging = NO;

	
    [self dismissViewControllerAnimated: YES completion:nil];
}





#pragma mark - Keyboard Handling

-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    NSLog(@"keyboardFrame: %@", NSStringFromCGRect(keyboardFrame));
    
    if (keyboardFrame.size.height > 50) {
        self.keyboardDoneButton.hidden = NO;
    }
}

-(void)keyboardHiding:(NSNotification*)notification{
    self.keyboardDoneButton.hidden = YES;
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

-(void)donePressed:(UIButton*)sender {
    [self.view endEditing:YES];
}


#pragma mark - Text Handling

//Note: Because UITextField does not have a built in placeholder, an override is needed.
//Text View/Field Modification
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"What's Going On..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
    [self.content setContentOffset:CGPointMake(0, 140) animated:NO];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"What's Going On...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

// Because UITextField does not have a built in done button, an override is needed.

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
    
}

#pragma mark - Other Functions

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)cancelPressed{
    //In the future, code here will dismiss the view.
}

-(void)nextPressed {
    //In the future, code here will move the UI to the next view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
