//
//  MapViewController.m
//  zero
//
//  Created by 吳隆筠 on 1/25/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import "MapViewController.h"
@import Mapbox;
//@import MapboxDirections;

@interface MapViewController () <MGLMapViewDelegate>
@property (strong, nonatomic) IBOutlet MGLMapView *mapView;
@end

@implementation MapViewController

// female: 👮‍♀️👮🏻‍♀️👮🏼‍♀️👮🏽‍♀️👮🏾‍♀️👮🏿‍♀️
// male: 👮👮🏻👮🏼👮🏽👮🏾👮🏿
// add rand() array of cops annotation on the map
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad MapVC");

    // set the map view's delegate property
    self.mapView.delegate = self;

    // create annotation and assign it to local variable point
    MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];

    // give the point annotation a coordinate
    point.coordinate = CLLocationCoordinate2DMake(37.369168, -122.038412);
    point.title = @"Chick-fil-A";
    point.subtitle = @"550 W El Camino Real, Sunnyvale, CA 94087";

    // add the annotation to the map view
    [self.mapView addAnnotation:point];


}



// Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// mapview
// Tapping the annotation (display title and subtitle)
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    // Always try to show a callout when an annotation is tapped.
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
