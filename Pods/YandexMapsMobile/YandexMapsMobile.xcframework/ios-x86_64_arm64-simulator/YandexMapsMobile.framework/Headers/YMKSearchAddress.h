#import <YandexMapsMobile/YRTExport.h>

#import <Foundation/Foundation.h>

@class YMKSearchAddressComponent;

/**
 * Contains structured address, formatted address, postal code and
 * country code.
 *
 * Structured address is an ordered list of components (usually
 * administrative hierarchy). Formatted address is a full address as a
 * single string. Formatted address generally can't be obtained from
 * component names. Some components could be ignored (large
 * administrative region) or absent (office number).
 */
YRT_EXPORT @interface YMKSearchAddress : NSObject

/**
 * Human-readable address.
 */
@property (nonatomic, readonly, nonnull) NSString *formattedAddress;

/**
 * Additional address info.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *additionalInfo;

/**
 * Postal/Zip code.
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *postalCode;

/**
 * Country code in ISO 3166-1 alpha-2 format (two-letter country code).
 *
 * Optional field, can be nil.
 */
@property (nonatomic, readonly, nullable) NSString *countryCode;

/**
 * Address component list, see YMKSearchAddressComponent, may be empty.
 */
@property (nonatomic, readonly, nonnull) NSArray<YMKSearchAddressComponent *> *components;


+ (nonnull YMKSearchAddress *)addressWithFormattedAddress:(nonnull NSString *)formattedAddress
                                           additionalInfo:(nullable NSString *)additionalInfo
                                               postalCode:(nullable NSString *)postalCode
                                              countryCode:(nullable NSString *)countryCode
                                               components:(nonnull NSArray<YMKSearchAddressComponent *> *)components;


@end

/**
 * An address component kind, for example, large administrative area.
 */
typedef NS_ENUM(NSUInteger, YMKSearchComponentKind) {
    /**
     * Unknown component kind
     */
    YMKSearchComponentKindUnknown,
    /**
     * Country component, for example "Russian Federation".
     */
    YMKSearchComponentKindCountry,
    /**
     * Region component, for example "Central Federative Region".
     */
    YMKSearchComponentKindRegion,
    /**
     * Province component, for example "Moscow Region".
     */
    YMKSearchComponentKindProvince,
    /**
     * Area component, for example "Primorskiy rayon".
     */
    YMKSearchComponentKindArea,
    /**
     * Locality component, for example "Saint-Petersburg".
     */
    YMKSearchComponentKindLocality,
    /**
     * District component, for example "Kirovskiy district".
     */
    YMKSearchComponentKindDistrict,
    /**
     * Street component, for example "Leo Tolstoy street".
     */
    YMKSearchComponentKindStreet,
    /**
     * House component, for example "16", "42а", "д16ак2стр14".
     */
    YMKSearchComponentKindHouse,
    /**
     * Entrance component, for example "2", "main entrance".
     */
    YMKSearchComponentKindEntrance,
    /**
     * Indoor level component, for example "2", "reception".
     */
    YMKSearchComponentKindLevel,
    /**
     * Apartment component, for example "83", "Blue suite".
     */
    YMKSearchComponentKindApartment,
    /**
     * Line component, for example "Violet line"
     * ("Таганско-Краснопресненская линия").
     */
    YMKSearchComponentKindRoute,
    /**
     * Generic station component, for example "Dolgoprudnaya".
     */
    YMKSearchComponentKindStation,
    /**
     * Metro station component, for example "Chekhovskaya".
     */
    YMKSearchComponentKindMetroStation,
    /**
     * Railway station component, for example "Chekhovskaya".
     */
    YMKSearchComponentKindRailwayStation,
    /**
     * Vegetation component, for example "Bitsevskiy park".
     */
    YMKSearchComponentKindVegetation,
    /**
     * Hydro component, for example "Moscow river", "Lokh-ness lake",
     * "Atlantic ocean".
     */
    YMKSearchComponentKindHydro,
    /**
     * Airport component, for example "Sheremetyevo", "Charles-de-Golle
     * airport".
     */
    YMKSearchComponentKindAirport,
    /**
     * Kind for other toponyms, for example cemeteries or some other
     * landmarks, which can't be easily described by kinds.
     */
    YMKSearchComponentKindOther
};

/**
 * Single address component.
 *
 * Component represents a single entry in the administrative hierarchy
 * of the address.
 */
YRT_EXPORT @interface YMKSearchAddressComponent : NSObject

/**
 * Component name.
 */
@property (nonatomic, readonly, nonnull) NSString *name;

/**
 * Component kinds. May contain both general and specific kind, for
 * example YMKSearchComponentKindStation and
 * YMKSearchComponentKindMetroStation.
 */
@property (nonatomic, readonly, nonnull) NSArray<NSNumber *> *kinds;


+ (nonnull YMKSearchAddressComponent *)componentWithName:(nonnull NSString *)name
                                                   kinds:(nonnull NSArray<NSNumber *> *)kinds;


@end
