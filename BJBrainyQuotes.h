#import <Foundation/Foundation.h>

@interface BJBrainyQuotes : NSObject <NSXMLParserDelegate>
+ (void)parseQuotesAuthors:(void (^)(NSArray *authors, NSArray *quotes))callback;
@end
