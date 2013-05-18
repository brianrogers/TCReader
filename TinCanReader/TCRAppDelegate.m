//
//  TCRAppDelegate.m
//  TinCanReader
//
//  Created by Brian Rogers on 5/2/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "TCRAppDelegate.h"

@implementation TCRAppDelegate

@synthesize tincan = _tincan;
@synthesize username = _username;
@synthesize email = _email;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *lrs = [[NSMutableDictionary alloc] init];

    [lrs setValue:@"http://lrs.endpoint/" forKey:@"endpoint"];
    [lrs setValue:@"Basic h7eyhdtYYhdyeuyehd654tYYetehhdgsuowikejdu9938748==" forKey:@"auth"];
    [lrs setValue:@"1.0.0" forKey:@"version"];
    // just add one LRS for now
    [options setValue:[NSArray arrayWithObject:lrs] forKey:@"recordStore"];
    
    _tincan = [[RSTinCanConnector alloc] initWithOptions:[options copy]];
    
    NSMutableDictionary *statementOptions = [[NSMutableDictionary alloc] init];
    [statementOptions setValue:@"http://tcreader.com/tcreader" forKey:@"activityId"];
    [statementOptions setValue:[[TCVerb alloc] initWithId:@"http://adlnet.gov/expapi/verbs/experienced" withVerbDisplay:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"experienced"]] forKey:@"verb"];
    [statementOptions setValue:@"http://tcreader.com/activities/document" forKey:@"activityType"];
    
    TCStatement *statementToSend = [self createTestStatementWithOptions:statementOptions];
    
    [_tincan sendStatement:statementToSend withCompletionBlock:^(){
        
    }withErrorBlock:^(TCError *error){
        
        NSLog(@"ERROR: %@", error.localizedDescription);
    }];
    
    return YES;
}

- (TCStatement *)createTestStatementWithOptions:(NSDictionary *)options
{
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    TCAgent *actor = [[TCAgent alloc] initWithName:[standardUserDefaults stringForKey:@"username"] withMbox:[standardUserDefaults stringForKey:@"email"]];
    
    TCActivityDefinition *actDef = [[TCActivityDefinition alloc] initWithName:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"http://tcreader.com/test"]
                                                              withDescription:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"TCReader activity"]
                                                                     withType:[options valueForKey:@"activityType"]
                                                               withExtensions:nil
                                                          withInteractionType:nil
                                                  withCorrectResponsesPattern:nil
                                                                  withChoices:nil
                                                                    withScale:nil
                                                                   withTarget:nil
                                                                    withSteps:nil];
    
    TCActivity *activity = [[TCActivity alloc] initWithId:[options valueForKey:@"activityId"] withActivityDefinition:actDef];
    
    TCVerb *verb = [options valueForKey:@"verb"];
    
    TCStatement *statementToSend = [[TCStatement alloc] initWithId:[TCUtil GetUUID] withActor:actor withTarget:activity withVerb:verb withResult:nil];
    
    return statementToSend;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
