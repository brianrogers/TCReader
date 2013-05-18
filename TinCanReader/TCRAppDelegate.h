//
//  TCRAppDelegate.h
//  TinCanReader
//
//  Created by Brian Rogers on 5/2/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTinCanConnector.h"

@interface TCRAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) RSTinCanConnector *tincan;


@end
