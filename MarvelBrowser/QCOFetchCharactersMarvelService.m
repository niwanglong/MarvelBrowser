//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2017 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersMarvelService.h"

#import "QCOFetchCharactersRequestModel.h"
#import "QCONetworkRequest.h"


@interface QCOFetchCharactersMarvelService ()
@property (nonatomic, strong, readonly) NSURLSession *session;
@property (nonatomic, copy, readonly) NSString *(^authParametersGenerator)(void);
@end

@implementation QCOFetchCharactersMarvelService

- (instancetype)initWithSession:(NSURLSession *)session
        authParametersGenerator:(NSString *(^)(void))authParametersGenerator
{
    self = [super init];
    if (self)
    {
        _session = session;
        _authParametersGenerator = [authParametersGenerator copy];
    }
    return self;
}

- (void)fetchCharactersWithRequestModel:(QCOFetchCharactersRequestModel *)requestModel
                         networkRequest:(QCONetworkRequest *)networkRequest
                       completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler
{
    NSURL *url = [self URLForRequestModel:requestModel];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                     completionHandler ? completionHandler(data,response,error) : nil;
    }];
    [networkRequest startTask:dataTask];
}

- (NSURL *)URLForRequestModel:(QCOFetchCharactersRequestModel *)requestModel
{
    NSString *encodedNamePrefix = [requestModel.namePrefix stringByAddingPercentEncodingWithAllowedCharacters:
            [NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:
            @"https://gateway.marvel.com/v1/public/characters?nameStartsWith=%@&limit=%lu&offset=%lu",
            encodedNamePrefix,
            (unsigned long)requestModel.pageSize,
            (unsigned long)requestModel.offset
    ];
    urlString = [urlString stringByAppendingString:self.authParametersGenerator()];
    return [[NSURL alloc] initWithString:urlString];
}

@end
