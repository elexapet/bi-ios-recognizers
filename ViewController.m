//
//  ViewController.m
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 07/10/14.
//  Copyright (c) 2014 Ackee s.r.o. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) GraphView* graphView;
@property (weak, nonatomic) PanelView* panelView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    //Red rectangle with geasture recognizers
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
    
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    
    UIPanGestureRecognizer* panReco = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    
    [v addGestureRecognizer:tapGesture];
    [v addGestureRecognizer:doubleTapGesture];
    [v addGestureRecognizer:panReco];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    [self.view addSubview:v];
    */
    
    //panel for graph
    PanelView *panelview = [[PanelView alloc] initWithFrame:CGRectZero];
    panelview.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    panelview.delegate = self;
    
    [self.view addSubview:panelview];
    self.panelView = panelview;
    
    //graph
    GraphView* graph = [[GraphView alloc] initWithFrame:CGRectMake(10, 130, CGRectGetWidth(self.view.frame)-20, 200)];
    graph.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //graph.backgroundColor = [UIColor lightGrayColor];
    
    self.graphView = graph;
    [self.view addSubview:graph];    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.graphView.frame = CGRectMake(8, 20 + 8, CGRectGetWidth(self.view.bounds) - 16, 200);
    self.panelView.frame = CGRectMake(8, 20 + 16 + 200, CGRectGetWidth(self.view.bounds) - 16, 128);
}

- (void) pan:(UIPanGestureRecognizer*) recognizer {
    
    CGPoint point = [recognizer translationInView:self.view];
    
    static CGPoint center;
    
    switch(recognizer.state) {
            
        case UIGestureRecognizerStateBegan: {
            center = recognizer.view.center;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            recognizer.view.center = CGPointMake(point.x + center.x, point.y + center.y);
            break;
        }
        
        default:
            break;
            
    }
    
}

- (void) oneTap:(UITapGestureRecognizer*) recognizer {
    NSLog(@"OneTap");
}

- (void) doubleTap:(UITapGestureRecognizer*) recognizer {
    NSLog(@"DoubleTap");
}

- (void)panelView:(PanelView *)panelView sliderChanged:(UISlider *)slider
{
    self.graphView.amp = slider.value;
    self.panelView.amplitudeLabel.text = [NSString stringWithFormat:@"%u", (unsigned)self.graphView.amp];
}

- (void)panelView:(PanelView *)panelView stepperChanged:(UIStepper *)stepper
{
    self.graphView.amp = stepper.value;
    self.panelView.amplitudeLabel.text = [NSString stringWithFormat:@"%u", (unsigned)self.graphView.amp];
}

- (void)panelView:(PanelView *)panelView segmentedControlChanged:(UISegmentedControl *)sc
{
    switch (sc.selectedSegmentIndex) {
        case 0:
            self.graphView.color = [UIColor redColor];
            break;
        case 1:
            self.graphView.color = [UIColor blueColor];
            break;
        case 2:
            self.graphView.color = [UIColor greenColor];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
