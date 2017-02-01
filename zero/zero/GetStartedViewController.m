/********************************/
// CS63A - Winter 2017
// HW1: Milestone 1
// Student Name: Cyrus Goh
// SID: 20186628
/********************************/

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

@interface GetStartedViewController ()

@end

@implementation GetStartedViewController

//@synthesize PageViewController,arrPageTitles;

// Do any additional setup after loading the view.
- (void)viewDidLoad {
    NSLog(@"viewDidLoad GetStartedVC");
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
