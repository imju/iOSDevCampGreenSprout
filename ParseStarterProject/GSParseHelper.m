//
//  GSParseHelper.m
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import <Parse/Parse.h>
#import "GSParseHelper.h"

@implementation GSParseHelper

+ (void)queryBizWithCity:(NSString *)city category:(NSString *)category searchString:(NSString *)searchString andBlock:(void(^)(NSArray *objects, NSDictionary *images, NSError *error))block{
    NSAssert(!(!!category && !!searchString), @"Can query only category OR searchString");
    
    PFQuery* query = [PFQuery queryWithClassName:@"biz"];
    
    if(category){
        if(city){
            [query whereKey:@"city" equalTo:city];
        }
        [query whereKey:@"category" equalTo:category];
    }else if(searchString){
        PFQuery* catQuery = [PFQuery queryWithClassName:@"biz"];
        if(city){
            [catQuery whereKey:@"city" equalTo:city];
        }
        [catQuery whereKey:@"category" matchesRegex:searchString modifiers:@"i"];
        
        PFQuery* descQuery = [PFQuery queryWithClassName:@"biz"];
        if(city){
            [descQuery whereKey:@"city" equalTo:city];
        }
        [descQuery whereKey:@"description" matchesRegex:searchString modifiers:@"i"];
        
        PFQuery* nameQuery = [PFQuery queryWithClassName:@"biz"];
        if(city){
            [nameQuery whereKey:@"city" equalTo:city];
        }
        [nameQuery whereKey:@"name" matchesRegex:searchString modifiers:@"i"];
        
        query = [PFQuery orQueryWithSubqueries:@[catQuery, descQuery, nameQuery]];
    }else if(city){
        [query whereKey:@"city" equalTo:city];
    }
    
    __block NSArray *objects = nil;
    __block NSMutableDictionary *images = nil;
    
    __block NSInteger processedImageCount = 0;
    __block void(^processedImageHandler)() = ^() {
        processedImageCount++;
        if(processedImageCount >= [objects count]){
            block(objects, images, nil);
        }
    };
    
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objs, NSError *error) {
        if([objs count] > 0){
            objects = objs;
            images = [NSMutableDictionary dictionary];
            [objects enumerateObjectsUsingBlock:^(PFObject *obj, NSUInteger idx, BOOL *stop) {
                if(obj[@"picture"]){
                    [(PFFile *)obj[@"picture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if(data){
                            images[obj.objectId] = [UIImage imageWithData:data];
                        }
                        processedImageHandler();
                    }];
                }else{
                    processedImageHandler();
                }
            }];
        }else{
            block(nil, nil, error);
        }
    }];
}

+ (void)queryBizWithObjectId:(NSString *)objectId andBlock:(void(^)(PFObject *object, UIImage *mainImage, NSArray *classes, NSError *error))block{
    
    void(^retrieveClasses)(PFObject *object, UIImage *mainImage) = ^(PFObject *object, UIImage *mainImage) {
        PFQuery *query = [PFQuery queryWithClassName:@"classes"];
        query.cachePolicy = kPFCachePolicyCacheElseNetwork;
        [query whereKey:@"bizPointer" equalTo:object];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            block(object, mainImage, objects, error);
        }];
    };
    
    PFQuery *query = [PFQuery queryWithClassName:@"biz"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        if(!object || error){
            block(object, nil, nil, error);
        }else{
            if(object[@"picture"]){
                __block UIImage *image = nil;
                [(PFFile *)object[@"picture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if(data){
                        image = [UIImage imageWithData:data];
                    }
                    if(error){
                        block(object, image, nil, error);
                    }else{
                        retrieveClasses(object, image);
                    }
                }];
            }else{
                retrieveClasses(object, nil);
            }
        }
    }];
}

@end
