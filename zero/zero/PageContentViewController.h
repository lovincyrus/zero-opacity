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
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSUInteger pageIndex;
@property NSString *titleText;
//@property NSString *imageFile;

@end
