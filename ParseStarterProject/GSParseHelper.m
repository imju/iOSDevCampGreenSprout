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

+ (void)queryBizWithCity:(NSString *)city category:(NSString *)category andBlock:(void(^)(NSArray *objects, NSDictionary *images, NSError *error))block{
    PFQuery* query = [PFQuery queryWithClassName:@"biz"];
    
    if(city){
        [query whereKey:@"city" equalTo:city];
    }
    if(category){
        [query whereKey:@"category" equalTo:category];
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

+ (void)queryBizWithObjectId:(NSString *)objectId andBlock:(void(^)(PFObject *object, UIImage *mainImage, NSArray *classes, NSArray *pictures, NSError *error))block{
    __block NSArray *classes = nil;
    void(^retrieveClassesPictures)(PFObject *object, UIImage *mainImage) = ^(PFObject *object, UIImage *mainImage) {
        __block PFQuery *query = [PFQuery queryWithClassName:@"classes"];
        [query whereKey:@"bizPointer" equalTo:object];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            query = [PFQuery queryWithClassName:@"images"];
            [query whereKey:@"biz" equalTo:object];
//            NSMutableArray *images = [NSMutableArray dictionary];
//            [objects enumerateObjectsUsingBlock:^(PFObject *obj, NSUInteger idx, BOOL *stop) {
//                if(obj[@"picture"]){
//                    [(PFFile *)obj[@"picture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                        if(data){
//                            images[obj.objectId] = [UIImage imageWithData:data];
//                        }
//                        processedImageHandler();
//                    }];
//                }else{
//                    processedImageHandler();
//                }
//            }];

            block(object, mainImage, objects, classes, error);
        }];
    };

//    void(^retrievePictures)(PFObject *object, UIImage *mainImage, NSArray *classes) = ^(PFObject *object, UIImage *mainImage, NSArray *classes) {
//        PFQuery *query = [PFQuery queryWithClassName:@"images"];
//        [query whereKey:@"biz" equalTo:object];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *pictures, NSError *error) {
//            block(object, mainImage, classes,pictures, error);
//        }];
//    };

    PFQuery *query = [PFQuery queryWithClassName:@"biz"];
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        if(!object || error){
            block(object, nil, nil, nil, error);
        }else{
            __block UIImage *image = nil;
             if(object[@"picture"]){
                [(PFFile *)object[@"picture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if(data){
                        image = [UIImage imageWithData:data];
                    }
                    if(error){
                        block(object, image, nil, nil, error);
                    }else{
                        retrieveClassesPictures(object, image);
 //                       retrievePictures(object, image, classes);
                    }
                }];
            }else{
                retrieveClassesPictures(object, nil);
 //               retrievePictures(object, nil, classes);
            }
        }
    }];
}

@end
