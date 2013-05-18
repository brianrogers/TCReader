//
//  TCRChoosePdfViewController.m
//  TinCanReader
//
//  Created by Brian Rogers on 5/2/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "TCRChoosePdfViewController.h"
#import "PageViewController.h"

@interface TCRChoosePdfViewController ()

@end

@implementation TCRChoosePdfViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)openPDF {
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"PDF" ofType:@"pdf"];
//    PageViewController *page = [[PageViewController alloc] initWithPDFAtPath:path];
//    [self presentViewController:page animated:YES completion:NULL];
    
}



@end
