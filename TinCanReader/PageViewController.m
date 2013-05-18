//
//  PageViewController.m
//
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController()
{
    __weak UIPopoverController *commentPopover;
}

@property (nonatomic, strong) NSNumber *currentPage;
@property (nonatomic, strong) CommentPopoverViewController *commentPopoverViewController;

@end

@implementation PageViewController

-(id)initWithPDFAtPath:(NSString *)path {
    
    NSURL *pdfUrl = [NSURL fileURLWithPath:path];
    PDFDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfUrl);
    totalPages = (int)CGPDFDocumentGetNumberOfPages(PDFDocument);
    
    self.title = [path lastPathComponent];
    
    self = [super initWithNibName:nil bundle:nil];
    return self;
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController 
      viewControllerBeforeViewController:(UIViewController *)viewController {
    
    _contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
    
    currentIndex = [modelArray indexOfObject:[(ContentViewController *)viewController page]];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    _currentPage = [f numberFromString:[(ContentViewController *)viewController page]];
    
    NSLog(@"currentIndex %d", currentIndex);
    
    if (currentIndex == 0) {
        
        return nil;
        
    }
    
    _contentViewController.page = [modelArray objectAtIndex:currentIndex - 1];
    
    return _contentViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    _contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
    
    //get the current page
    currentIndex = [modelArray indexOfObject:[(ContentViewController *)viewController page]];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    _currentPage = [f numberFromString:[(ContentViewController *)viewController page]];

    NSLog(@"currentIndex %d", currentIndex);
    
    TCRAppDelegate *appdelegate = (TCRAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *statementOptions = [[NSMutableDictionary alloc] init];
    [statementOptions setValue:[NSString stringWithFormat:@"http://tcreader.com/tcreader/page/%@",[(ContentViewController *)viewController page] ] forKey:@"activityId"];
    [statementOptions setValue:[[TCVerb alloc] initWithId:@"http://tcreader.com/verbs/viewed" withVerbDisplay:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"viewed"]] forKey:@"verb"];
    [statementOptions setValue:@"http://tcreader.com/activities/document" forKey:@"activityType"];
    
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    TCAgent *actor = [[TCAgent alloc] initWithName:[standardUserDefaults stringForKey:@"username"] withMbox:[standardUserDefaults stringForKey:@"email"]];
    
    TCActivityDefinition *actDef = [[TCActivityDefinition alloc] initWithName:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"http://tcreader.com/"]
                                                              withDescription:[[TCLocalizedValues alloc] initWithLanguageCode:@"en-US" withValue:@"Page from TCReader"]
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
    
    TCStatement *statementToSend = [[TCStatement alloc] initWithId:[TCUtil GetUUID] withActor:actor withTarget:activity withVerb:verb withResult:nil];
    
    [appdelegate.tincan sendStatement:statementToSend withCompletionBlock:^(){
        
    }withErrorBlock:^(TCError *error){
        
        NSLog(@"ERROR: %@", error.localizedDescription);
    }];
    
    if (currentIndex == totalPages - 1) {
        return nil;
    }
    
    _contentViewController.page = [modelArray objectAtIndex:currentIndex + 1];
        
    return _contentViewController;
}

#pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    UIViewController *currentViewController = [_pageViewController.viewControllers objectAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    _pageViewController.doubleSided = NO;

    return UIPageViewControllerSpineLocationMin;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //modelArray holds the page numbers
    modelArray = [[NSMutableArray alloc] init];
    
    for (int index = 1; index <= totalPages; index++) {
        
        [modelArray addObject:[NSString stringWithFormat:@"%i", index]];
        
    }
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    _pageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
    _contentViewController.page = [modelArray objectAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:_contentViewController];
    [_pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    _pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    [_pageViewController didMoveToParentViewController:self];
        
    self.view.backgroundColor = [UIColor underPageBackgroundColor];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"commentPopover"])
    {
        commentPopover = [(UIStoryboardPopoverSegue *)segue popoverController];
        //[commentPopover setDelegate:self];
        
        CommentPopoverViewController *commentPopoverViewController = (CommentPopoverViewController *) segue.destinationViewController;
        [commentPopoverViewController setPage:[_contentViewController page]];
        [commentPopoverViewController setDelegate:self];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (commentPopover)
    {
        return NO;
    }
    else{
        return YES;
    }
}

-(void)dismissPop:(NSString *)value
{
    NSLog(@"dismiss pop");
    [commentPopover dismissPopoverAnimated:YES];
    commentPopover = nil;
}

-(void)dealloc {
        
    _contentViewController = nil;
    modelArray = nil;
    
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    
    _contentViewController = nil;
    modelArray = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
