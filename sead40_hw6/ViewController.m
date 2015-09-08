//
//  ViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/7/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)loadView{
  
  UIView *rootView = [[UIView alloc]init];
  
  rootView.backgroundColor = [UIColor blackColor];
  
  UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  
  //Do not add an
  [redView setTranslatesAutoresizingMaskIntoConstraints:false];
  
  redView.backgroundColor = [UIColor redColor];
  
  [rootView addSubview:redView];
  
  UILabel *whiteLabel = [[UILabel alloc]init];
  
  //Turn off their autoconstraints
  [whiteLabel setTranslatesAutoresizingMaskIntoConstraints:false];
  
  whiteLabel.text = @"Flamengo";
  [rootView addSubview:whiteLabel];
  
  NSDictionary *views = @{@"redView" : redView, @"whiteLabel" : whiteLabel};
  
  //No nearest neighbor here / Create NSNumbers to use numbers in metrics
  NSArray *redViewHOrizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[redView]-|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:redViewHOrizontalConstraints];
  
  //Red view Vertical
  NSArray *redViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[redView]-100-|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:redViewVerticalConstraints];
  
  //Class method constraintsWithVisualFormat - no reason for choosing that over alloc init
  NSArray *whiteLableVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[redView]-[whiteLabel]" options:0 metrics:nil views:views];
  [rootView addConstraints:whiteLableVerticalConstraints];
  
  NSArray *whiteLabelHorizontalContstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[whiteLabel]" options:0 metrics:nil views:views];
  [rootView addConstraints:whiteLabelHorizontalContstraints];
  
  self.view = rootView;
  
}

@end















