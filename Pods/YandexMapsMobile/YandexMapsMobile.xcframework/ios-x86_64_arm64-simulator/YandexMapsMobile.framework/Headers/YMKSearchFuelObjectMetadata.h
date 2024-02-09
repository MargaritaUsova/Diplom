#import <YandexMapsMobile/YMKAttribution.h>
#import <YandexMapsMobile/YMKTaxiMoney.h>
#import <YandexMapsMobile/YRTExport.h>

/**
 * Fuel name and price.
 */
YRT_EXPORT @interface YMKSearchFuelType : NSObject

/**
 * Fuel name.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *name;

/**
 * Fuel price.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKTaxiMoney *price;


+ (nonnull YMKSearchFuelType *)fuelTypeWithName:(nullable NSString *)name
                                          price:(nullable YMKTaxiMoney *)price;


@end

/**
 * Fuel snippet.
 */
YRT_EXPORT @interface YMKSearchFuelMetadata : NSObject

/**
 * Snippet update time as UNIX timestamp.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSNumber *timestamp;

/**
 * Fuel list.
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKSearchFuelType *> *fuels;

/**
 * Attribution information.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) YMKAttribution *attribution;


+ (nonnull YMKSearchFuelMetadata *)fuelMetadataWithTimestamp:(nullable NSNumber *)timestamp
                                                       fuels:(nonnull NSArray<YMKSearchFuelType *> *)fuels
                                                 attribution:(nullable YMKAttribution *)attribution;


@end
