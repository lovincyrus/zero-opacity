/********************************/
// CS63A - Winter 2017
// HW2: Milestone 2
// Student Name: Cyrus Goh
// SID: 20186628
/********************************/

//
//  ViewController.h
//  zero
//
//  Created by 吳隆筠 on 1/25/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"


// to make UIPageViewController work, we must adopt <>
@interface ViewController : UIViewController <UIPageViewControllerDataSource>


// pagecontentview
- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;

@end

