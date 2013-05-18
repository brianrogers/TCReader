//
//  CommentPopoverViewController.m
//  TinCanReader
//
//  Created by Brian Rogers on 5/6/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "CommentPopoverViewController.h"

@interface CommentPopoverViewController ()

@end

@implementation CommentPopoverViewController

@synthesize page = _page;
@synthesize delegate;

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
    [_textView setText:_page];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveComment:(id)sender
{
    TCRAppDelegate *appdelegate = (TCRAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *statementOptions = [[NSMutableDictionary alloc] init];
    [statementOptions setValue:[NSString stringWithFormat:@"http://tcreader.com/tcreader/page/%@/comment",_page ] forKey:@"activityId"];
    [statementOptions setValue:[[TCVerb alloc] initWithId:@"http://tcreader.com/verbs/commented" withVerbDisplay:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"commented"]] forKey:@"verb"];
    [statementOptions setValue:@"http://tcreader.com/activities/document#comment" forKey:@"activityType"];
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    TCAgent *actor = [[TCAgent alloc] initWithName:[standardUserDefaults stringForKey:@"username"] withMbox:[standardUserDefaults stringForKey:@"email"]];
    
    TCActivityDefinition *actDef = [[TCActivityDefinition alloc] initWithName:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"TCReader Comment"]
                                                              withDescription:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"Comment on a page in TCReader"]
                                                                     withType:[statementOptions valueForKey:@"activityType"]
                                                               withExtensions:nil
                                                          withInteractionType:nil
                                                  withCorrectResponsesPattern:nil
                                                                  withChoices:nil
                                                                    withScale:nil
                                                                   withTarget:nil
                                                                    withSteps:nil];
    
    TCActivity *activity = [[TCActivity alloc] initWithId:[statementOptions valueForKey:@"activityId"] withActivityDefinition:actDef];
    
    TCVerb *verb = [statementOptions valueForKey:@"verb"];
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *resultExtensions = [[NSMutableDictionary alloc] init];
    [resultExtensions setValue:self.textView.text forKey:@"http://tcreader.com/extensions/comment"];
    [result setValue:resultExtensions forKey:@"extensions"];
    
    TCStatement *statementToSend = [[TCStatement alloc] initWithId:[TCUtil GetUUID] withActor:actor withTarget:activity withVerb:verb withResult:result];
    
    [appdelegate.tincan sendStatement:statementToSend withCompletionBlock:^(){
        
    }withErrorBlock:^(TCError *error){
        
        NSLog(@"ERROR: %@", error.localizedDescription);
    }];

    [delegate dismissPop:@""];
}

@end
