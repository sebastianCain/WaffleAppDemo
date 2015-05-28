//
//  ViewController.m
//  WaffleAppDemo
//
//  Created by Sebastian Cain on 5/27/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate>

@property UIImageView *coverPhoto;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillLayoutSubviews {
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
    
    // Cover Photo Setup
    
    UIImageView *coverPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 150)];
    [coverPhoto setBackgroundColor:[UIColor blackColor]];
    self.coverPhoto = coverPhoto;
    [self.view addSubview:coverPhoto];
    
    UIButton *cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 45, 45)];
    [cameraButton addTarget:self action:@selector(coverCameraPressed) forControlEvents:UIControlEventTouchUpInside];
    [cameraButton setImage:[UIImage imageNamed:@"Camera-White"] forState:UIControlStateNormal];
    [cameraButton.imageView setContentMode: UIViewContentModeScaleAspectFit];
    
    [coverPhoto addSubview:cameraButton];
    
    // Body Setup
    
    UIView *body = [[UIView alloc]initWithFrame:CGRectMake(0, 210, self.view.frame.size.width, self.view.frame.size.height-210)];
    
    [self.view addSubview:body];
    
    UITextField *waffleFlavour = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 64)];
    [waffleFlavour setTextColor:[UIColor blackColor]];
    [waffleFlavour setTintColor:[UIColor blackColor]];
    [waffleFlavour setPlaceholder:@"Flavour of Waffle"];
    [waffleFlavour setFont:[UIFont fontWithName:@"Ubuntu" size:36]];
    
    [body addSubview:waffleFlavour];
    
    UITextField *whatsGoingOn = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 100)];
    [whatsGoingOn setTextColor:[UIColor blackColor]];
    [whatsGoingOn setTintColor:[UIColor blackColor]];
    [whatsGoingOn setPlaceholder:@"What's going on"];
    [whatsGoingOn setFont:[UIFont fontWithName:@"Ubuntu-Light" size:24]];
    
    [body addSubview:whatsGoingOn];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)coverCameraPressed{
    NSLog(@"Here");
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

#pragma mark - UIImagePicker

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    
    mediaUI.delegate = delegate;
    self.picker = mediaUI;
    [controller presentModalViewController: mediaUI animated: YES];
    return YES;
}

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
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
    self.coverPhoto.image = imageToUse;
    self.coverPhoto.contentMode = UIViewContentModeScaleAspectFit;
    
    
    // Do something with imageToUse
    
    
    [self dismissModalViewControllerAnimated: YES];
}


-(void)cancelPressed {
    
}

@end
