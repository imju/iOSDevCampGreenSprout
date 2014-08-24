//
//  GSParseHelper.h
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface GSParseHelper : NSObject

+ (void)queryBizWithCity:(NSString *)city category:(NSString *)category searchString:(NSString *)searchString andBlock:(void(^)(NSArray *objects, NSDictionary *images, NSError *error))block;

+ (void)queryBizWithObjectId:(NSString *)objectId andBlock:(void(^)(PFObject *object, UIImage *mainImage, NSArray *classes, NSError *error))block;

@end
