//
//  Reservation.h
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/8/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) Guest *guest;
@property (nonatomic, retain) Room *room;

@end
