//
//  BaseDataItem.m
//
//  Created by WeiHan on 10/07/2017.
//

#import "BaseDataItem.h"

#pragma mark - BaseDataItem

@implementation BaseDataItem

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmismatched-parameter-types"

+ (NSArray *)dataItemsFromSource:(NSArray *)sourceItems target:(id)targetInstance
{
    return [self dataItemsFromSource:sourceItems target:targetInstance block:nil completion:nil];
}

+ (NSArray *)dataItemsFromSource:(NSArray *)sourceItems target:(id)targetInstance block:(void (^)(id sourceItem, id targetItem))block
{
    return [self dataItemsFromSource:sourceItems target:targetInstance block:block completion:nil];
}

+ (NSArray *)dataItemsFromSource:(NSArray *)sourceItems target:(id)targetInstance completion:(void (^)(id sourceItem, id targetItem))completion
{
    return [self dataItemsFromSource:sourceItems target:targetInstance block:nil completion:completion];
}

#pragma clang diagnostic pop

+ (NSArray *)dataItemsFromSource:(NSArray *)sourceItems target:(id)targetInstance block:(void (^)(id, id))block completion:(void (^)(id, id))completion
{
    NSParameterAssert([targetInstance isKindOfClass:[BaseDataItem class]] && ![targetInstance isMemberOfClass:[BaseDataItem class]]); // It must be a type of subclasses.
    id sourceItem = sourceItems.firstObject;

    if (!sourceItem) {
        return nil;
    }

    Class sourceClass = [sourceItem class];
    Class targetClass = [targetInstance class];
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"dataItemFrom%@:", NSStringFromClass(sourceClass)]);

    BOOL foundClassSelector = [targetClass respondsToSelector:selector];
    BOOL foundInstanceSelector = [targetClass instancesRespondToSelector:selector];

    NSAssert(block || foundClassSelector || foundInstanceSelector, @"Didn't found the selector %@ in class %@!", NSStringFromSelector(selector), NSStringFromClass(targetClass));

    NSMutableArray<__kindof BaseDataItem *> *array = [[NSMutableArray alloc] initWithCapacity:sourceItems.count];

    for (id item in sourceItems) {
        BaseDataItem *model = nil;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

        if (block) {
            model = [targetClass new];
            block(item, model);
        } else if (foundClassSelector) {
            model = [targetClass performSelector:selector withObject:item];
        } else if (foundInstanceSelector) {
            model = [targetInstance performSelector:selector withObject:item];
        }

        if (completion) {
            completion(item, model);
        }

#pragma clang diagnostic pop

        NSAssert(model, @"Invalid returned value from selector %@ in class %@!", NSStringFromSelector(selector), NSStringFromClass(targetClass));
        [array addObject:model];
    }

    return array;
}

@end

#pragma mark - StringDataItem

#define FORWARD_DESCRIPTION              \
    - (NSString *)description            \
    {                                    \
        return [self.value description]; \
    }


#if DEBUG
#define VALIDATE_TYPE(__type__, __object__)                       \
    NSString * strType = @ # __type__;                            \
                                                                  \
    strType = [strType stringByReplacingOccurrencesOfString:@"*"  \
                                                 withString:@""]; \
    strType = [strType stringByReplacingOccurrencesOfString:@" "  \
                                                 withString:@""]; \
                                                                  \
    Class valueType = NSClassFromString(strType);                 \
                                                                  \
    NSAssert([__object__ isKindOfClass:valueType], @"Unexpected the source item type!");
#else
#define VALIDATE_TYPE(__type__, __object__)
#endif


#define VALUE_CONVERSION_METHOD_IMPLEMENTATION(__type__)                        \
    + (instancetype)dataItemFromValue: (__type__)value                          \
    {                                                                           \
        id<SuppressValueProtocol> object = [self new];                          \
        VALIDATE_TYPE(__type__, value);                                         \
        object.value = value;                                                   \
        return object;                                                          \
    }                                                                           \
                                                                                \
    + (NSArray<__type__> *)dataItemsFromSource:(NSArray<__type__> *)sourceItems \
    {                                                                           \
        BaseDataItem<SuppressValueProtocol> *object = [self new];               \
                                                                                \
        return [self dataItemsFromSource:sourceItems                            \
                                  target:object                                 \
                                   block:^(id sourceItem, id targetItem) {      \
            VALIDATE_TYPE(__type__, sourceItem);                                \
            ((id<SuppressValueProtocol>)targetItem).value = sourceItem;         \
        }];                                                                     \
    }

@implementation StringDataItem

FORWARD_DESCRIPTION
VALUE_CONVERSION_METHOD_IMPLEMENTATION(NSString *)

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [((__typeof(self))object).value isEqual:self.value];
    } else if ([object isKindOfClass:[NSString class]]) {
        return [object isEqualToString:self.value];
    }

    return [super isEqual:object];
}

@end

#pragma mark - NumberDataItem

@implementation NumberDataItem

FORWARD_DESCRIPTION
VALUE_CONVERSION_METHOD_IMPLEMENTATION(NSNumber *)

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [((__typeof(self))object).value isEqual:self.value];
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [object isEqualToNumber:self.value];
    }

    return [super isEqual:object];
}

@end

#pragma mark - ValueDataItem

@implementation ValueDataItem

FORWARD_DESCRIPTION
VALUE_CONVERSION_METHOD_IMPLEMENTATION(NSValue *)

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [((typeof(self))object).value isEqual:self.value];
    } else if ([object isKindOfClass:[NSValue class]]) {
        return [object isEqualToValue:self.value];
    }

    return [super isEqual:object];
}

@end

#pragma mark - DictionaryDataItem

@implementation DictionaryDataItem

FORWARD_DESCRIPTION
VALUE_CONVERSION_METHOD_IMPLEMENTATION(NSDictionary *)

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [((typeof(self))object).value isEqual:self.value];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        return [object isEqualToDictionary:self.value];
    }

    return [super isEqual:object];
}

@end

#pragma mark - ArrayDataItem

@implementation ArrayDataItem

FORWARD_DESCRIPTION
VALUE_CONVERSION_METHOD_IMPLEMENTATION(NSArray *)

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [((typeof(self))object).value isEqual:self.value];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [object isEqualToArray:self.value];
    }

    return [super isEqual:object];
}

@end

#pragma mark - VariableDataItem

@implementation VariableDataItem

FORWARD_DESCRIPTION
VALUE_CONVERSION_METHOD_IMPLEMENTATION(NSObject *)

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [((typeof(self))object).value isEqual:self.value];
    }

    return [super isEqual:object];
}

@end
