//
//  Guest.h
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/8/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Guest : NSManagedObject

@property (nonatomic, retain) NSSet *reservations;
@end

@interface Guest (CoreDataGeneratedAccessors)

- (void)addReservationsObject:(NSManagedObject *)value;
- (void)removeReservationsObject:(NSManagedObject *)value;
- (void)addReservations:(NSSet *)values;
- (void)removeReservations:(NSSet *)values;

@end
