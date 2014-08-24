//
//  GSParseHelper.h
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import <Foundation/Foundation.h>

@interface GSParseHelper : NSObject

+ (void)queryBizWithCity:(NSString *)city category:(NSString *)category andBlock:(void(^)(NSArray *objects, NSDictionary *images, NSError *error))block;

@end
