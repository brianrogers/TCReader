//
//  TCRModelController.h
//  TinCanReader
//
//  Created by Brian Rogers on 5/2/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCRDataViewController;

@interface TCRModelController : NSObject <UIPageViewControllerDataSource>

- (TCRDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(TCRDataViewController *)viewController;

@end
