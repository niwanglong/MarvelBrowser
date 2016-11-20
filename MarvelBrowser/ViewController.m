//  TDD sample app MarvelBrowser by Jon Reid, http://qualitycoding.org/about/
//  Copyright 2016 Jonathan M. Reid. See LICENSE.txt

#import "ViewController.h"

#import "QCOFetchCharactersMarvelService.h"
#import "QCOFetchCharactersRequestModel.h"
#import "QCOMarvelAuthentication.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    QCOFetchCharactersMarvelService *service =
            [[QCOFetchCharactersMarvelService alloc] initWithSession:[NSURLSession sharedSession]
                                             authParametersGenerator:^NSString * {
                                                 return [QCOMarvelAuthentication URLParameters];
                                             }];
    QCOFetchCharactersRequestModel *requestModel =
            [[QCOFetchCharactersRequestModel alloc] initWithNamePrefix:@"Spider" pageSize:1 offset:0];
    [service fetchCharactersWithRequestModel:requestModel];
}

@end
