//
//  SOEditableField.h
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SOEditableField : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *value;
@property BOOL numeric;

@end

NS_ASSUME_NONNULL_END
