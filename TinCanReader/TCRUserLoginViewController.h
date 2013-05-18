//
//  TCRUserLoginViewController.h
//  TinCanReader
//
//  Created by Brian Rogers on 5/11/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCRAppDelegate.h";

@interface TCRUserLoginViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *email;

- (IBAction)login:(id)sender;

@end
