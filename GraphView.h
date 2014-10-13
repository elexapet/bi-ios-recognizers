//
//  GraphView.h
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 07/10/14.
//  Copyright (c) 2014 Ackee s.r.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphView : UIView

- (instancetype)initWithFrame:(CGRect)frame defaultAmp:(double)defaultAmp;

@property (nonatomic, assign) double amp;
@property (nonatomic, strong) UIColor* color;

@end
