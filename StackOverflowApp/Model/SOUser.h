//
//  SOUser.h
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SOUser : NSObject

- (instancetype) initWithDict:(NSDictionary*)dict;

@property (nonatomic,strong) NSString *displayName;
@property (nonatomic,strong) NSNumber *reputation;
@property (nonatomic,strong) NSURL *profileImageURL;
@property (nonatomic,strong) NSNumber *goldNumber;
@property (nonatomic,strong) NSNumber *silverNumber;
@property (nonatomic,strong) NSNumber *bronzeNumber;


@end

NS_ASSUME_NONNULL_END
