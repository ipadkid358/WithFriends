#import "BJBrainyQuotes.h"


@implementation BJBrainyQuotes {
    NSXMLParser *_parser;
    NSMutableArray *_authors;
    NSMutableArray *_quotes;
    NSString *_element;
    BOOL _startLogging;
}

+ (void)parseQuotesAuthors:(void (^)(NSArray *authors, NSArray *quotes))callback {
    BJBrainyQuotes *inst = self.new;
    [inst _parseQuotesAuthors:callback];
}

- (void)_parseQuotesAuthors:(void (^)(NSArray *authors, NSArray *quotes))callback {
    _authors = [NSMutableArray array];
    _quotes = [NSMutableArray array];
    _startLogging = NO;
    
    NSURL *url = [NSURL URLWithString:@"https://www.brainyquote.com/link/quotebr.rss"];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        _parser = [[NSXMLParser alloc] initWithData:data];
        _parser.delegate = self;
        _parser.shouldResolveExternalEntities = NO;
        if (_parser.parse) {
            callback(_authors, _quotes);
        } else {
            callback(NULL, NULL);
        }
    }] resume];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (_startLogging) {
        _element = elementName;
    } else if ([elementName isEqualToString:@"item"]) {
        _startLogging = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (![string isEqualToString:@"\n      "]) {
        if ([_element isEqualToString:@"title"]) {
            [_authors addObject:string];
        } else if ([_element isEqualToString:@"description"]) {
            [_quotes addObject:string];
        }
    }
}

@end
