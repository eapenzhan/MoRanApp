//
//  GBMLoginRequest.m
//  GBMoran_iOS
//
//  Created by yikobe_mac on 15/9/21.
//  Copyright © 2015年 Brave. All rights reserved.
//

#import "GBMLoginRequest.h"
#import "BLMultipartForm.h"
#import "GBMLoginRequestParser.h"

@implementation GBMLoginRequest

- (void)sendLoginRequestWithEmail:(NSString *)email
                               password:(NSString *)password
                                   gbid:(NSString *)gbid
{
    [self.urlConnection cancel];
    
    NSString *urlString = @"http://moran.chinacloudapp.cn/moran/web/user/login";
    
    // POST请求
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData; // 忽略本地和远程的缓存
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:email forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    request.HTTPBody = [form httpBody];
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
}

#pragma mark - 网络请求代理方法

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        self.receivedData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *string = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"receive data string:%@", string);
    
    GBMLoginRequestParser *parser = [[GBMLoginRequestParser alloc] init];
    [parser parseJson:self.receivedData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", error);
}


@end
