//
//  TCRDownloadViewController.h
//  TinCanReader
//
//  Created by Brian Rogers on 5/11/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <AFDownloadRequestOperation.h>

@interface TCRDownloadViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *downloadUrl;
@property (nonatomic, weak) IBOutlet UIProgressView *progressView;

- (IBAction)downloadFile:(id)sender;

@end
