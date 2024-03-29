//
//  GBMRegisterRequest.h
//  GBMoran_iOS
//
//  Created by yikobe_mac on 15/9/21.
//  Copyright © 2015年 Brave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBMRegisterRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;

- (void)sendRegisterRequestWithUserName:(NSString *)username
                                  email:(NSString *)email
                               password:(NSString *)password
                                   gbid:(NSString *)gbid;


@end
