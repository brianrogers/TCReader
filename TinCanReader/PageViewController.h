//
//  PageViewController.h
//


#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "TCRChoosePdfViewController.h"
#import "CommentPopoverViewController.h"

@class ContentViewController, UIPrintInteractionController;

@interface PageViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource, PopViewControllerDelegate, UIPopoverControllerDelegate> {
    
    //UIPageViewController *thePageViewController;
    //ContentViewController *contentViewController;
    NSMutableArray *modelArray;
    CGPDFDocumentRef PDFDocument;
    int currentIndex;
    int totalPages;
    
}

@property (strong, nonatomic) IBOutlet UIPageViewController *pageViewController;
@property (strong, nonatomic) IBOutlet ContentViewController *contentViewController;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

-(id)initWithPDFAtPath:(NSString *)path;

- (IBAction)showCommentWindow:(id)sender;

-(void)dismissPop:(NSString *)value;

@end
