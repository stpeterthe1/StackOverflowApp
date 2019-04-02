//
//  SOAPI.h
//  StackOverflowApp
//
//  Created by Denis Rudoy on 3/31/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOUser.h"

NS_ASSUME_NONNULL_BEGIN


@interface SOAPI : NSObject

+(void)requestUsersWithCompletion:(void (^ _Nullable)(NSError * _Nullable error, NSArray <SOUser*> *  _Nullable users))completion;

@end

NS_ASSUME_NONNULL_END
