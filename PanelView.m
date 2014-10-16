//
//  PanelView.m
//  bi-ios-recognizers
//
//  Created by Petr on 10.10.14.
//  Copyright (c) 2014 Ackee s.r.o. All rights reserved.
//

#import "PanelView.h"

@interface PanelView ()
@property (weak, nonatomic) UISlider* slider;
@property (weak, nonatomic) UIStepper* stepper;
@property (weak, nonatomic) UISegmentedControl* segmentedControl;
@property (weak, nonatomic) UISwitch* mySwitch;
@property (weak, nonatomic) NSTimer* myTimer;
@property (weak, nonatomic) UIView* line;
@end

@implementation PanelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        
        UIView* l = [[UIView alloc]initWithFrame:CGRectZero];
        l.backgroundColor = [UIColor lightGrayColor];
        self.line = l;
        [self addSubview:l];
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.textColor = [UIColor whiteColor];
        self.amplitudeLabel = label;
        [self addSubview:label];
        
        //timer pro pocatecni animaci
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:(1/30)
                                                          target:self
                                                        selector:@selector(timerFired:)
                                                        userInfo:@"I am timer!"
                                                         repeats:YES];
        
        
        
        //po 5 vterinach stopne Timer
        [self performSelector:@selector(invalidateTimer:)
                   withObject:@{ @"timer1" : self.myTimer }
                   afterDelay:5];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.line.frame = CGRectMake(8, 8 + 3*44, CGRectGetWidth(self.bounds) - 16, 3);
    self.slider.frame = CGRectMake(8, 8, CGRectGetWidth(self.bounds) - 16, 44);
    self.stepper.frame = CGRectMake(8, 8 + 44 + 8, CGRectGetWidth(self.bounds) - 16, 44);
    self.segmentedControl.frame = CGRectMake(16 + CGRectGetWidth(self.stepper.bounds), 8 + 44 + 8,
                                             CGRectGetWidth(self.bounds) - CGRectGetWidth(self.stepper.bounds) - 24,
                                             CGRectGetHeight(self.stepper.bounds));
    self.amplitudeLabel.frame = CGRectMake(8, 2*8 + 2*44 + CGRectGetHeight(self.mySwitch.bounds)/4,
                                           CGRectGetWidth(self.bounds) - 16 - CGRectGetWidth(self.mySwitch.bounds), 30);
    self.mySwitch.frame = CGRectMake(CGRectGetWidth(self.bounds) - 8 - CGRectGetWidth(self.mySwitch.bounds),
                                     2*8 + 2*44,
                                     (CGRectGetWidth(self.bounds) - 16)/2, 44);
}


- (void)invalidateTimer:(NSDictionary *)userInfo
{
    NSTimer *timer = userInfo[@"timer1"];
    [timer invalidate];
}

#pragma mark - Actions

- (void)timerFired:(NSTimer *)timer {
    CGFloat value = self.slider.value;
    value += 0.01;
    self.slider.value = value;
    self.stepper.value = value;
    [self sliderValueChanged:self.slider];
}

- (UIStepper *)stepper{
    if(!_stepper){
        UIStepper* stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
        stepper.minimumValue = 0;
        stepper.maximumValue = 15;
        stepper.stepValue = 0.5;
        stepper.value = self.delegate.defaultAmp;
        [stepper addTarget:self
                    action:@selector(stepperValueChanged:)
          forControlEvents:UIControlEventTouchUpInside];
        
        _stepper = stepper;
        [self addSubview:stepper];

    }
    return _stepper;
}

- (UISlider *)slider{
    if(!_slider){
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
        slider.minimumValue = 0;
        slider.maximumValue = 15;
        slider.value = self.delegate.defaultAmp;
        [slider addTarget:self
                   action:@selector(sliderValueChanged:)
         forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:slider];
        _slider = slider;
    }
    return _slider;
}

- (UISegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        //color switcher
        UISegmentedControl* sc = [[UISegmentedControl alloc] initWithItems:@[@"Red",@"Blue",@"Green"]];
        sc.selectedSegmentIndex = 0;
        [sc addTarget:self
               action:@selector(segmentedControlStateChanged:)
     forControlEvents:UIControlEventValueChanged];
        
        _segmentedControl = sc;
        [self addSubview:sc];
    }
    return _segmentedControl;
}

-(UISwitch *)mySwitch{
    if (!_mySwitch) {
        UISwitch* sw = [[UISwitch alloc]initWithFrame:CGRectZero];
        sw.on = true;
        [sw addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventValueChanged];
        _mySwitch = sw;
        [self addSubview:sw];
    }
    return _mySwitch;
}

- (void)stepperValueChanged:(UIStepper *)stepper
{
    if ([self.delegate respondsToSelector:@selector(panelView:stepperChanged:)]) {
        [self.delegate panelView:self
             stepperChanged:stepper];
    }
    
    self.slider.value = stepper.value;
}

- (void)sliderValueChanged:(UISlider *)slider
{
    if ([self.delegate respondsToSelector:@selector(panelView:sliderChanged:)]) {
        [self.delegate panelView:self
                   sliderChanged:slider];
    }

    self.stepper.value = slider.value;
}

- (void)segmentedControlStateChanged:(UISegmentedControl*)sender {
    if ([self.delegate respondsToSelector:@selector(panelView:segmentedControlChanged:)]) {
        [self.delegate panelView:self
         segmentedControlChanged:sender];
    }
}

- (void)switchStateChanged:(UISwitch*)sender{
    if (sender.on) {
        self.slider.enabled = true;
        self.stepper.enabled = true;
    }else{
        self.slider.enabled = false;
        self.stepper.enabled = false;
        if (self.myTimer) {
            [self invalidateTimer:@{ @"timer1" : self.myTimer }];
        }
    }
}

@end