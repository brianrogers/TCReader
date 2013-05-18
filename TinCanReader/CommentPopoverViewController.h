//
//  CommentPopoverViewController.h
//  TinCanReader
//
//  Created by Brian Rogers on 5/6/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCRAppDelegate.h"

@protocol PopViewControllerDelegate; 

@interface CommentPopoverViewController : UIViewController

@property (nonatomic, strong) NSString *page;
@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UIButton *saveButton;

@property (weak) id <PopViewControllerDelegate> delegate;

- (IBAction)saveComment:(id)sender;

@end

@protocol PopViewControllerDelegate <NSObject>

@required

- (void)dismissPop: (NSString *)value;

@end