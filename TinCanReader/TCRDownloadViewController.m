//
//  TCRDownloadViewController.m
//  TinCanReader
//
//  Created by Brian Rogers on 5/11/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "TCRDownloadViewController.h"

@interface TCRDownloadViewController ()

@end

@implementation TCRDownloadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.progressView setProgress:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadFile:(id)sender
{
    __block UIProgressView *_downloadProgress = self.progressView;
    NSString *path = self.downloadUrl.text;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    NSString *targetPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:targetPath shouldResume:YES];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@", path);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.progressView setProgress:1.0 animated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error.userInfo);
    }];
    [operation setProgressiveDownloadProgressBlock:^(AFDownloadRequestOperation *operation, NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        
        float progressValue = (float)totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
        //NSLog(@"progressValue = %f", progressValue);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView setProgress:progressValue animated:YES];
        });
        
    }];
    [operation start];
}

@end
