//
//  GetStartedViewController.m
//  zero
//
//  Created by 吳隆筠 on 1/25/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import "PageContentViewController.h"
#import "GetStartedViewController.h"
#import "ViewController.h"
//#import "MapViewController.m"

@interface GetStartedViewController ()

@end

@implementation GetStartedViewController

//@synthesize PageViewController,arrPageTitles;

// Do any additional setup after loading the view.
- (void)viewDidLoad {
    NSLog(@"viewDidLoad GetStartedVC");

//    [super viewDidLoad];
//    // Create the data model
//    _pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
//
//    // Create page view controller
//    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
//    self.pageViewController.dataSource = self;
//
//    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
//    NSArray *viewControllers = @[startingViewController];
//    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//
//    // Change the size of page view controller
//    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
//
//    [self addChildViewController:_pageViewController];
//    [self.view addSubview:_pageViewController.view];
//    [self.pageViewController didMoveToParentViewController:self];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






// openMapSegue
#pragma mark - Navigation
// setting up segue from GetStartedVC to MapVC
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // ensure the correct segue to fire
    if([segue.identifier isEqualToString:@"openMapSegue"])
        // ensure the correct destination class
        if([segue.destinationViewController isMemberOfClass:[UIViewController class]]){
            // cast destination class to be B
//            UIViewController* bvc = (UIViewController*)segue.destinationViewController;
            // info passing from A to B
//            bvc.backgroundColor = ((UIButton*)sender).backgroundColor;
            //bvc.navTitle = ((UIButton*)sender).currentTitle;
        }

}





@end
