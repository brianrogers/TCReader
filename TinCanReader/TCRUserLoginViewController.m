//
//  TCRUserLoginViewController.m
//  TinCanReader
//
//  Created by Brian Rogers on 5/11/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "TCRUserLoginViewController.h"

@interface TCRUserLoginViewController ()
    
@end

@implementation TCRUserLoginViewController

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

-(IBAction)login:(id)sender
{
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:self.username.text forKey:@"username"];
    [standardUserDefaults setObject:[NSString stringWithFormat:@"mailto:%@",self.email.text] forKey:@"email"];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:self.username.text forKey:@"username"];
    [standardUserDefaults setObject:[NSString stringWithFormat:@"mailto:%@",self.email.text] forKey:@"email"];

}

@end
