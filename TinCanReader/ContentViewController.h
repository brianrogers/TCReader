//
//  ContentViewController.h
//


#import <UIKit/UIKit.h>
#import "TCRAppDelegate.h"
#import "PDFScrollView.h"

@class PDFScrollView;

@interface ContentViewController : UIViewController <UIScrollViewDelegate> {
    
    CGPDFDocumentRef pdfToDisplay;
    PDFScrollView *pdfScrollView;
    
}

-(id)initWithPDF:(CGPDFDocumentRef)pdf;

@property (nonatomic, strong) NSString *page;

@end
