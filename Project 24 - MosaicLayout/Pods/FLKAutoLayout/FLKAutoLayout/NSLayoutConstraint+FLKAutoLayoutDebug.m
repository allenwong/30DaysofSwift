//
// Created by Florian on 22.07.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSLayoutConstraint+FLKAutoLayoutDebug.h"
#import "UIView+FLKAutoLayoutDebug.h"


@interface NSLayoutConstraint ()

- (NSString *)asciiArtDescription;

@end


@implementation NSLayoutConstraint (FLKAutoLayoutDebug)

#ifdef DEBUG

- (NSString *)description
{
    NSString *description = super.description;
    NSString *asciiArtDescription = self.asciiArtDescription;
    return [description stringByAppendingFormat:@" %@ (%@, %@)", asciiArtDescription, [self.firstItem flk_nameTag], [self.secondItem flk_nameTag]];
}

#endif

@end