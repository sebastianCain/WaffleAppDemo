//
//  ViewController.h
//  WaffleAppDemo
//
//  Created by Sebastian Cain on 5/27/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate>


@property UITextView *whatsGoingOn;
@property UIScrollView *content;
@property UIImagePickerController *picker;
@property UIImageView *coverPhoto;
@property UIImageView *addedPhoto;
@end

