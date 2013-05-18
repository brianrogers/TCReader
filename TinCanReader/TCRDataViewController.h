//
//  TCRDataViewController.h
//  TinCanReader
//
//  Created by Brian Rogers on 5/2/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCRDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@end
