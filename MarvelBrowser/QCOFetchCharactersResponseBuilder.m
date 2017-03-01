//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "QCOFetchCharactersResponseBuilder.h"

#import "QCOFetchCharactersResponseModel.h"


@implementation QCOFetchCharactersResponseBuilder

- (QCOFetchCharactersResponseModel *)parseJSONData:(NSData *)jsonData
{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:(NSJSONReadingOptions)0
                                                           error:NULL];
    if (!dict)
        return nil;
    if (![dict isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSNumber *code = dict[@"code"];
    return [[QCOFetchCharactersResponseModel alloc] initWithCode:code.integerValue];
}

@end
