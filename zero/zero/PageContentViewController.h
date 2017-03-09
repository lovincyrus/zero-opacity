/********************************/
// CS63A - Winter 2017
// HW2: Milestone 2
// Student Name: Cyrus Goh
// SID: 20186628
/********************************/

//
//  PageContentViewController.h
//  zero
//
//  Created by 吳隆筠 on 1/27/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property NSUInteger pageIndex;
@property NSString *titleText;
//@property NSString *imageFile;

@end
