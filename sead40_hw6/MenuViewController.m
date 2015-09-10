//
//  MenuViewController.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/10/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"

@interface MenuViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic) UITableView *menuTableView;

@property (strong, nonatomic) UITableViewCell *browseHotelsCell;
@property (strong, nonatomic) UITableViewCell *bookAroomCell;
@property (strong, nonatomic) UITableViewCell *lookUpReservationsCell;
@property (strong, nonatomic) NSArray *tableData;

@end

@implementation MenuViewController

-(void)loadView{
  
  UIView *rootView = [[UIView alloc]init];
  UITableView *tableView = [[UITableView alloc]initWithFrame:rootView.frame style:UITableViewStyleGrouped];
  
  self.menuTableView = tableView;
  [tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:tableView]; //check if there is method here
  
  NSDictionary *views = @{@"tableView" : tableView};
  
  NSArray *tableViewVerticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewVerticalConstraints];
  
  NSArray *tableViewHorizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  
  [rootView addConstraints:tableViewHorizontalConstraints];
  
  // construct menu cells, section 1, row 00
  self.browseHotelsCell = [[UITableViewCell alloc]init];
  self.browseHotelsCell.textLabel.text = @"Browse Hotels";
  self.browseHotelsCell.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
  self.browseHotelsCell.accessoryType = UITableViewCellAccessoryDetailButton;
  
  self.view = rootView;
  
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.menuTableView.delegate = self;
  self.menuTableView.dataSource = self;
  
  [self.menuTableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"MenuCellIdentifier"];
  
  self.tableData = [NSArray arrayWithObjects:@"Browse Hotels",@"Book a Room",@"Lookup reservations", nil];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *menuCell = [tableView dequeueReusableCellWithIdentifier:@"MenuCellIdentifier" forIndexPath:indexPath];
  
  menuCell.textLabel.text =  [self.tableData objectAtIndex:indexPath.row];
  
  return menuCell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
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
