//
//  ConfirmReservationViewController.h
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/13/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface ConfirmReservationViewController : UIViewController

@property (nonatomic, strong) Room *selectedRoom;
@property (strong, nonatomic) NSDate *selectedConfirmStartDate;
@property (strong, nonatomic) NSDate *selectedConfirmEndDate;


@end
