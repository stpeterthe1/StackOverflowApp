//
//  SOAPI.m
//  StackOverflowApp
//
//  Created by Denis Rudoy on 3/31/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import "SOAPI.h"

#define URL_STRING @"https://api.stackexchange.com/2.2/users?site=stackoverflow"

@implementation SOAPI

+(void)requestUsersWithCompletion:(void (^ _Nullable)(NSError * _Nullable error, NSArray <SOUser*> *  _Nullable users))completion{
    
    NSString *urlAsString = [NSString stringWithFormat:URL_STRING];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlAsString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                [[self class] handleData:data response:response error:error withCompletion:completion];
                
            }] resume];
}

+(void)handleData:(NSData*)data response:(NSURLResponse*)response error:(NSError*)error withCompletion:(void (^ _Nullable)(NSError * _Nullable error, NSArray <SOUser*> *  _Nullable users))completion{
    
    if (!error) {
        // Success
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSError *jsonError;
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError) {
                completion(jsonError,nil);
            } else {
                //                NSLog(@"%@",jsonResponse);
                NSArray *jsonArray = jsonResponse[@"items"];
                completion(nil,[[self class] usersFromJsonArray:jsonArray]);
            }
        }  else {
            //Web server is returning an error
            completion([NSError errorWithDomain:@"com.RudoyApp.iOSChallendge" code:1 userInfo:[NSDictionary dictionaryWithObject:@"Web server is returning an error" forKey:NSLocalizedDescriptionKey]],nil);
        }
    } else {
        // Fail
        completion(error,nil);
        NSLog(@"error : %@", error.description);
    }
}

+(NSArray*)usersFromJsonArray:(NSArray <SOUser*> * )jsonArray{
    if (!jsonArray) {
        return nil;
    }
    NSMutableArray *users = [NSMutableArray new];
    for (NSDictionary *jsonForUser in jsonArray) {
        
        SOUser *user = [[SOUser alloc] initWithDict:jsonForUser];
        [users addObject:user];
    }
    return users;
}

@end
