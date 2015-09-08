//
//  Reservation.h
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/8/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) Guest *guest;

@end
