//
//  BaseDataItem.h
//
//  Created by WeiHan on 10/07/2017.
//

#import <Foundation/Foundation.h>

@class BaseDataItem;

@interface BaseDataItem<__covariant SourceType, __contravariant ObjectType : __kindof BaseDataItem *> : NSObject

+ (NSArray<ObjectType> *)dataItemsFromSource:(NSArray<SourceType> *)sourceItems target:(ObjectType)targetInstance block:(void (^)(SourceType sourceItem, ObjectType targetItem))block;

+ (NSArray<ObjectType> *)dataItemsFromSource:(NSArray<SourceType> *)sourceItems target:(ObjectType)targetInstance completion:(void (^)(SourceType sourceItem, ObjectType targetItem))completion;

/**
 *    @note     Note that the target conversion must be implemented in the class of targetInstance with the selector name rule dataItemFrom<TargetClass>:,
 *                    For example, if the targetInstance is kind of FooObject, the method + (instancetype)dataItemFromFooObject:(FooObject *)sourceItem or
 *                    - (instancetype)dataItemFromFooObject:(FooObject *)sourceItem will be called, the class selector is the prefer one.
 */
+ (NSArray<ObjectType> *)dataItemsFromSource:(NSArray<SourceType> *)sourceItems target:(ObjectType)targetInstance;

@end


@protocol SuppressValueProtocol <NSObject>

@property (nonatomic, strong) id value;

+ (instancetype)dataItemFromValue:(id)value;

+ (NSArray *)dataItemsFromSource:(NSArray *)sourceItems;

@end

#define VALUE_CONVERSION_METHOD_DECLARATION(__type__)   \
    + (instancetype)dataItemFromValue: (__type__)value; \
    +(NSArray<__type__> *) dataItemsFromSource: (NSArray<__type__> *)sourceItems

@interface StringDataItem : BaseDataItem <SuppressValueProtocol>

@property (nonatomic, strong) NSString *value;

VALUE_CONVERSION_METHOD_DECLARATION(NSString *);

@end

@interface NumberDataItem : BaseDataItem <SuppressValueProtocol>

@property (nonatomic, strong) NSNumber *value;

VALUE_CONVERSION_METHOD_DECLARATION(NSNumber *);

@end

@interface ValueDataItem : BaseDataItem <SuppressValueProtocol>

@property (nonatomic, strong) NSValue *value;

VALUE_CONVERSION_METHOD_DECLARATION(NSValue *);

@end

@interface DictionaryDataItem : BaseDataItem <SuppressValueProtocol>

@property (nonatomic, strong) NSDictionary *value;

VALUE_CONVERSION_METHOD_DECLARATION(NSDictionary *);

@end

@interface ArrayDataItem<__covariant ObjectType> : BaseDataItem <SuppressValueProtocol>

@property (nonatomic, strong) NSArray<ObjectType> *value;

VALUE_CONVERSION_METHOD_DECLARATION(NSArray<ObjectType> *);

@end

@interface VariableDataItem<__covariant ObjectType> : BaseDataItem <SuppressValueProtocol>

@property (nonatomic, strong) ObjectType value;

VALUE_CONVERSION_METHOD_DECLARATION(ObjectType);

@end
