//
//  GeocoderViewController.m
//  zero
//
//  Created by 吳隆筠 on 2/10/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

@import Mapbox;
@import MapboxGeocoder;

#import <MapboxGeocoder/MapboxGeocoder.h>
#import "GeocoderViewController.h"

@interface GeocoderViewController () <MGLMapViewDelegate>

#pragma mark - Variables

@property (nonatomic) MGLMapView *mapView;
@property (nonatomic) UILabel *resultsLabel;
@property (nonatomic) MBGeocoder *geocoder;
@property (nonatomic) NSURLSessionDataTask *geocodingDataTask;

@end

@implementation GeocoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSAssert(![MapboxAccessToken isEqualToString:@"<# your Mapbox access token #>"], @"You must set `MapboxAccessToken` to your Mapbox access token.");

//    [MGLAccountManager setAccessToken:MapboxAccessToken];
    self.mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];

    self.resultsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width - 20, 30)];
    self.resultsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.resultsLabel.adjustsFontSizeToFitWidth = YES;
    self.resultsLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.resultsLabel.userInteractionEnabled = YES;
    [self.view addSubview:self.resultsLabel];

//    self.geocoder = [[MBGeocoder alloc] initWithAccessToken:MapboxAccessToken];
}

#pragma mark - MGLMapViewDelegate

- (void)mapView:(MGLMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [self.geocodingDataTask cancel];
}

- (void)mapView:(MGLMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self.geocodingDataTask cancel];
    MBReverseGeocodeOptions *options = [[MBReverseGeocodeOptions alloc] initWithCoordinate:self.mapView.centerCoordinate];
    [self.geocoder geocodeWithOptions:options completionHandler:^(NSArray<MBGeocodedPlacemark *> * _Nullable placemarks, NSString * _Nullable attribution, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else if (placemarks.count > 0) {
            self.resultsLabel.text = placemarks[0].qualifiedName;
        } else {
            self.resultsLabel.text = @"No results";
        }
    }];
}

@end
