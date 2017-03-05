// Generated by Apple Swift version 3.0.2 (swiftlang-800.0.63 clang-800.0.42.1)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import Charts;
@import Realm;
@import ObjectiveC;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class RLMRealm;
@class NSPredicate;
@class ChartDataEntry;

SWIFT_CLASS("_TtC11ChartsRealm16RealmBaseDataSet")
@interface RealmBaseDataSet : ChartBaseDataSet
- (void)initialize SWIFT_METHOD_FAMILY(none);
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results yValueField:(NSString * _Nonnull)yValueField;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label;
- (void)loadResultsWithRealm:(RLMRealm * _Nonnull)realm modelName:(NSString * _Nonnull)modelName;
- (void)loadResultsWithRealm:(RLMRealm * _Nonnull)realm modelName:(NSString * _Nonnull)modelName predicate:(NSPredicate * _Nullable)predicate;
/**
  Use this method to tell the data set that the underlying data has changed
*/
- (void)notifyDataSetChanged;
- (void)calcMinMax;
/**

  returns:
  The minimum y-value this DataSet holds
*/
@property (nonatomic, readonly) double yMin;
/**

  returns:
  The maximum y-value this DataSet holds
*/
@property (nonatomic, readonly) double yMax;
/**

  returns:
  The minimum x-value this DataSet holds
*/
@property (nonatomic, readonly) double xMin;
/**

  returns:
  The maximum x-value this DataSet holds
*/
@property (nonatomic, readonly) double xMax;
/**

  returns:
  The number of y-values this DataSet represents
*/
@property (nonatomic, readonly) NSInteger entryCount;
/**

  throws:
  out of bounds
  if \code
  i
  \endcode is out of bounds, it may throw an out-of-bounds exception

  returns:
  The entry object found at the given index (not x-value!)
*/
- (ChartDataEntry * _Nullable)entryForIndex:(NSInteger)i;
/**
  \param xValue the x-value

  \param closestToY If there are multiple y-values for the specified x-value,

  \param rounding determine whether to round up/down/closest if there is no Entry matching the provided x-value


  returns:
  The first Entry object found at the given x-value with binary search.
  If the no Entry at the specified x-value is found, this method returns the Entry at the closest x-value according to the rounding.
  nil if no Entry object at that x-value.
*/
- (ChartDataEntry * _Nullable)entryForXValue:(double)xValue closestToY:(double)yValue rounding:(enum ChartDataSetRounding)rounding;
/**
  \param xValue the x-value

  \param closestToY If there are multiple y-values for the specified x-value,


  returns:
  The first Entry object found at the given x-value with binary search.
  If the no Entry at the specified x-value is found, this method returns the Entry at the closest x-value.
  nil if no Entry object at that x-value.
*/
- (ChartDataEntry * _Nullable)entryForXValue:(double)xValue closestToY:(double)y;
/**

  returns:
  All Entry objects found at the given x-value with binary search.
  An empty array if no Entry object at that x-value.
*/
- (NSArray<ChartDataEntry *> * _Nonnull)entriesForXValue:(double)xValue;
/**
  \param xValue x-value of the entry to search for

  \param closestToY If there are multiple y-values for the specified x-value,

  \param rounding Rounding method if exact value was not found


  returns:
  The array-index of the specified entry.
  If the no Entry at the specified x-value is found, this method returns the index of the Entry at the closest x-value according to the rounding.
*/
- (NSInteger)entryIndexWithX:(double)xValue closestToY:(double)yValue rounding:(enum ChartDataSetRounding)rounding;
/**
  \param e the entry to search for


  returns:
  The array-index of the specified entry
*/
- (NSInteger)entryIndexWithEntry:(ChartDataEntry * _Nonnull)e;
/**
  Not supported on Realm datasets
*/
- (BOOL)addEntry:(ChartDataEntry * _Nonnull)e;
/**
  Not supported on Realm datasets
*/
- (BOOL)addEntryOrdered:(ChartDataEntry * _Nonnull)e;
/**
  Not supported on Realm datasets
*/
- (BOOL)removeEntry:(ChartDataEntry * _Nonnull)entry;
/**
  Checks if this DataSet contains the specified Entry.

  returns:
  \code
  true
  \endcode if contains the entry, \code
  false
  \endcode ifnot.
*/
- (BOOL)contains:(ChartDataEntry * _Nonnull)e;
/**

  returns:
  The fieldname that represents the “y-values” in the realm-data.
*/
@property (nonatomic, readonly, copy) NSString * _Nullable yValueField;
/**

  returns:
  The fieldname that represents the “x-values” in the realm-data.
*/
@property (nonatomic, readonly, copy) NSString * _Nullable xValueField;
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
@end

@class NSColor;

SWIFT_CLASS("_TtC11ChartsRealm38RealmBarLineScatterCandleBubbleDataSet")
@interface RealmBarLineScatterCandleBubbleDataSet : RealmBaseDataSet <IBarLineScatterCandleBubbleChartDataSet>
@property (nonatomic, strong) NSColor * _Nonnull highlightColor;
@property (nonatomic) CGFloat highlightLineWidth;
@property (nonatomic) CGFloat highlightLineDashPhase;
@property (nonatomic, copy) NSArray<NSNumber *> * _Nullable highlightLineDashLengths;
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11ChartsRealm15RealmBarDataSet")
@interface RealmBarDataSet : RealmBarLineScatterCandleBubbleDataSet <IBarChartDataSet>
- (void)initialize SWIFT_METHOD_FAMILY(none);
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField stackValueField:(NSString * _Nonnull)stackValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField stackValueField:(NSString * _Nonnull)stackValueField;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results yValueField:(NSString * _Nonnull)yValueField stackValueField:(NSString * _Nonnull)stackValueField label:(NSString * _Nonnull)label;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results yValueField:(NSString * _Nonnull)yValueField stackValueField:(NSString * _Nonnull)stackValueField;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField stackValueField:(NSString * _Nonnull)stackValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField stackValueField:(NSString * _Nonnull)stackValueField;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere yValueField:(NSString * _Nonnull)yValueField stackValueField:(NSString * _Nonnull)stackValueField label:(NSString * _Nullable)label;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere yValueField:(NSString * _Nonnull)yValueField stackValueField:(NSString * _Nonnull)stackValueField;
- (void)notifyDataSetChanged;
- (void)calcMinMax;
/**

  returns:
  The maximum number of bars that can be stacked upon another in this DataSet.
*/
@property (nonatomic, readonly) NSInteger stackSize;
/**

  returns:
  \code
  true
  \endcode if this DataSet is stacked (stacksize > 1) or not.
*/
@property (nonatomic, readonly) BOOL isStacked;
/**
  array of labels used to describe the different values of the stacked bars
*/
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull stackLabels;
/**
  the color used for drawing the bar-shadows. The bar shadows is a surface behind the bar that indicates the maximum value
*/
@property (nonatomic, strong) NSColor * _Nonnull barShadowColor;
/**
  the width used for drawing borders around the bars. If borderWidth == 0, no border will be drawn.
*/
@property (nonatomic) CGFloat barBorderWidth;
/**
  the color drawing borders around the bars.
*/
@property (nonatomic, strong) NSColor * _Nonnull barBorderColor;
/**
  the alpha value (transparency) that is used for drawing the highlight indicator bar. min = 0.0 (fully transparent), max = 1.0 (fully opaque)
*/
@property (nonatomic) CGFloat highlightAlpha;
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
@end




SWIFT_CLASS("_TtC11ChartsRealm18RealmBubbleDataSet")
@interface RealmBubbleDataSet : RealmBarLineScatterCandleBubbleDataSet <IBubbleChartDataSet>
- (void)initialize SWIFT_METHOD_FAMILY(none);
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nonnull)xValueField yValueField:(NSString * _Nonnull)yValueField sizeField:(NSString * _Nonnull)sizeField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nonnull)xValueField yValueField:(NSString * _Nonnull)yValueField sizeField:(NSString * _Nonnull)sizeField;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nonnull)xValueField yValueField:(NSString * _Nonnull)yValueField sizeField:(NSString * _Nonnull)sizeField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic, readonly) CGFloat maxSize;
@property (nonatomic) BOOL normalizeSizeEnabled;
@property (nonatomic, readonly) BOOL isNormalizeSizeEnabled;
- (void)calcMinMax;
/**
  Sets/gets the width of the circle that surrounds the bubble when highlighted
*/
@property (nonatomic) CGFloat highlightCircleWidth;
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC11ChartsRealm34RealmLineScatterCandleRadarDataSet")
@interface RealmLineScatterCandleRadarDataSet : RealmBarLineScatterCandleBubbleDataSet <ILineScatterCandleRadarChartDataSet>
/**
  Enables / disables the horizontal highlight-indicator. If disabled, the indicator is not drawn.
*/
@property (nonatomic) BOOL drawHorizontalHighlightIndicatorEnabled;
/**
  Enables / disables the vertical highlight-indicator. If disabled, the indicator is not drawn.
*/
@property (nonatomic) BOOL drawVerticalHighlightIndicatorEnabled;
/**

  returns:
  \code
  true
  \endcode if horizontal highlight indicator lines are enabled (drawn)
*/
@property (nonatomic, readonly) BOOL isHorizontalHighlightIndicatorEnabled;
/**

  returns:
  \code
  true
  \endcode if vertical highlight indicator lines are enabled (drawn)
*/
@property (nonatomic, readonly) BOOL isVerticalHighlightIndicatorEnabled;
/**
  Enables / disables both vertical and horizontal highlight-indicators.
  :param: enabled
*/
- (void)setDrawHighlightIndicators:(BOOL)enabled;
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11ChartsRealm18RealmCandleDataSet")
@interface RealmCandleDataSet : RealmLineScatterCandleRadarDataSet <ICandleChartDataSet>
- (void)initialize SWIFT_METHOD_FAMILY(none);
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nonnull)xValueField highField:(NSString * _Nonnull)highField lowField:(NSString * _Nonnull)lowField openField:(NSString * _Nonnull)openField closeField:(NSString * _Nonnull)closeField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nonnull)xValueField highField:(NSString * _Nonnull)highField lowField:(NSString * _Nonnull)lowField openField:(NSString * _Nonnull)openField closeField:(NSString * _Nonnull)closeField;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nonnull)xValueField highField:(NSString * _Nonnull)highField lowField:(NSString * _Nonnull)lowField openField:(NSString * _Nonnull)openField closeField:(NSString * _Nonnull)closeField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (void)calcMinMax;
/**
  the space that is left out on the left and right side of each candle,
  <em>default</em>: 0.1 (10%), max 0.45, min 0.0
*/
@property (nonatomic) CGFloat barSpace;
/**
  should the candle bars show?
  when false, only “ticks” will show
  <em>default</em>: true
*/
@property (nonatomic) BOOL showCandleBar;
/**
  the width of the candle-shadow-line in pixels.
  <em>default</em>: 3.0
*/
@property (nonatomic) CGFloat shadowWidth;
/**
  the color of the shadow line
*/
@property (nonatomic, strong) NSColor * _Nullable shadowColor;
/**
  use candle color for the shadow
*/
@property (nonatomic) BOOL shadowColorSameAsCandle;
/**
  Is the shadow color same as the candle color?
*/
@property (nonatomic, readonly) BOOL isShadowColorSameAsCandle;
/**
  color for open == close
*/
@property (nonatomic, strong) NSColor * _Nullable neutralColor;
/**
  color for open > close
*/
@property (nonatomic, strong) NSColor * _Nullable increasingColor;
/**
  color for open < close
*/
@property (nonatomic, strong) NSColor * _Nullable decreasingColor;
/**
  Are increasing values drawn as filled?
  increasing candlesticks are traditionally hollow
*/
@property (nonatomic) BOOL increasingFilled;
/**
  Are increasing values drawn as filled?
*/
@property (nonatomic, readonly) BOOL isIncreasingFilled;
/**
  Are decreasing values drawn as filled?
  descreasing candlesticks are traditionally filled
*/
@property (nonatomic) BOOL decreasingFilled;
/**
  Are decreasing values drawn as filled?
*/
@property (nonatomic, readonly) BOOL isDecreasingFilled;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
@end

@class ChartFill;

SWIFT_CLASS("_TtC11ChartsRealm21RealmLineRadarDataSet")
@interface RealmLineRadarDataSet : RealmLineScatterCandleRadarDataSet <ILineRadarChartDataSet>
/**
  The color that is used for filling the line surface area.
*/
@property (nonatomic, strong) NSColor * _Nonnull fillColor;
/**
  The object that is used for filling the area below the line.
  <em>default</em>: nil
*/
@property (nonatomic, strong) ChartFill * _Nullable fill;
/**
  The alpha value that is used for filling the line surface,
  <em>default</em>: 0.33
*/
@property (nonatomic) CGFloat fillAlpha;
/**
  line width of the chart (min = 0.2, max = 10)
  <em>default</em>: 1
*/
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) BOOL drawFilledEnabled;
@property (nonatomic, readonly) BOOL isDrawFilledEnabled;
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
@end

@protocol IChartFillFormatter;

SWIFT_CLASS("_TtC11ChartsRealm16RealmLineDataSet")
@interface RealmLineDataSet : RealmLineRadarDataSet <ILineChartDataSet>
- (void)initialize SWIFT_METHOD_FAMILY(none);
/**
  The drawing mode for this line dataset
  <em>default</em>: Linear
*/
@property (nonatomic) enum LineChartMode mode;
/**
  Intensity for cubic lines (min = 0.05, max = 1)
  <em>default</em>: 0.2
*/
@property (nonatomic) CGFloat cubicIntensity;
@property (nonatomic) BOOL drawCubicEnabled;
@property (nonatomic, readonly) BOOL isDrawCubicEnabled;
@property (nonatomic) BOOL drawSteppedEnabled;
@property (nonatomic, readonly) BOOL isDrawSteppedEnabled;
/**
  The radius of the drawn circles.
*/
@property (nonatomic) CGFloat circleRadius;
/**
  The hole radius of the drawn circles
*/
@property (nonatomic) CGFloat circleHoleRadius;
@property (nonatomic, copy) NSArray<NSColor *> * _Nonnull circleColors;
/**

  returns:
  The color at the given index of the DataSet’s circle-color array.
  Performs a IndexOutOfBounds check by modulus.
*/
- (NSColor * _Nullable)getCircleColorAtIndex:(NSInteger)index;
/**
  Sets the one and ONLY color that should be used for this DataSet.
  Internally, this recreates the colors array and adds the specified color.
*/
- (void)setCircleColor:(NSColor * _Nonnull)color;
/**
  Resets the circle-colors array and creates a new one
*/
- (void)resetCircleColors:(NSInteger)index;
/**
  If true, drawing circles is enabled
*/
@property (nonatomic) BOOL drawCirclesEnabled;
/**

  returns:
  \code
  true
  \endcode if drawing circles for this DataSet is enabled, \code
  false
  \endcode ifnot
*/
@property (nonatomic, readonly) BOOL isDrawCirclesEnabled;
/**
  The color of the inner circle (the circle-hole).
*/
@property (nonatomic, strong) NSColor * _Nullable circleHoleColor;
/**
  \code
  true
  \endcode if drawing circles for this DataSet is enabled, \code
  false
  \endcode ifnot
*/
@property (nonatomic) BOOL drawCircleHoleEnabled;
/**

  returns:
  \code
  true
  \endcode if drawing the circle-holes is enabled, \code
  false
  \endcode ifnot.
*/
@property (nonatomic, readonly) BOOL isDrawCircleHoleEnabled;
/**
  This is how much (in pixels) into the dash pattern are we starting from.
*/
@property (nonatomic) CGFloat lineDashPhase;
/**
  This is the actual dash pattern.
  I.e. [2, 3] will paint [–   –   ]
  [1, 3, 4, 2] will paint [-   ––  -   ––  ]
*/
@property (nonatomic, copy) NSArray<NSNumber *> * _Nullable lineDashLengths;
/**
  Line cap type, default is CGLineCap.Butt
*/
@property (nonatomic) CGLineCap lineCapType;
/**
  Sets a custom IFillFormatter to the chart that handles the position of the filled-line for each DataSet. Set this to null to use the default logic.
*/
@property (nonatomic, strong) id <IChartFillFormatter> _Nullable fillFormatter;
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
@end



@class NSFont;

SWIFT_CLASS("_TtC11ChartsRealm15RealmPieDataSet")
@interface RealmPieDataSet : RealmBaseDataSet <IPieChartDataSet>
- (void)initialize SWIFT_METHOD_FAMILY(none);
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results yValueField:(NSString * _Nonnull)yValueField labelField:(NSString * _Nullable)labelField OBJC_DESIGNATED_INITIALIZER;
/**
  the space in pixels between the pie-slices
  <em>default</em>: 0
  <em>maximum</em>: 20
*/
@property (nonatomic) CGFloat sliceSpace;
/**
  When enabled, slice spacing will be 0.0 when the smallest value is going to be smaller than the slice spacing itself.
*/
@property (nonatomic) BOOL automaticallyDisableSliceSpacing;
/**
  indicates the selection distance of a pie slice
*/
@property (nonatomic) CGFloat selectionShift;
@property (nonatomic) enum PieChartValuePosition xValuePosition;
@property (nonatomic) enum PieChartValuePosition yValuePosition;
/**
  When valuePosition is OutsideSlice, indicates line color
*/
@property (nonatomic, strong) NSColor * _Nullable valueLineColor;
/**
  When valuePosition is OutsideSlice, indicates line width
*/
@property (nonatomic) CGFloat valueLineWidth;
/**
  When valuePosition is OutsideSlice, indicates offset as percentage out of the slice size
*/
@property (nonatomic) CGFloat valueLinePart1OffsetPercentage;
/**
  When valuePosition is OutsideSlice, indicates length of first half of the line
*/
@property (nonatomic) CGFloat valueLinePart1Length;
/**
  When valuePosition is OutsideSlice, indicates length of second half of the line
*/
@property (nonatomic) CGFloat valueLinePart2Length;
/**
  When valuePosition is OutsideSlice, this allows variable line length
*/
@property (nonatomic) BOOL valueLineVariableLength;
/**
  the font for the slice-text labels
*/
@property (nonatomic, strong) NSFont * _Nullable entryLabelFont;
/**
  the color for the slice-text labels
*/
@property (nonatomic, strong) NSColor * _Nullable entryLabelColor;
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC11ChartsRealm17RealmRadarDataSet")
@interface RealmRadarDataSet : RealmLineRadarDataSet <IRadarChartDataSet>
- (void)initialize SWIFT_METHOD_FAMILY(none);
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results yValueField:(NSString * _Nonnull)yValueField;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
/**
  flag indicating whether highlight circle should be drawn or not
  <em>default</em>: false
*/
@property (nonatomic) BOOL drawHighlightCircleEnabled;
/**

  returns:
  \code
  true
  \endcode if highlight circle should be drawn, \code
  false
  \endcode ifnot
*/
@property (nonatomic, readonly) BOOL isDrawHighlightCircleEnabled;
@property (nonatomic, strong) NSColor * _Nullable highlightCircleFillColor;
/**
  The stroke color for highlight circle.
  If \code
  nil
  \endcode, the color of the dataset is taken.
*/
@property (nonatomic, strong) NSColor * _Nullable highlightCircleStrokeColor;
@property (nonatomic) CGFloat highlightCircleStrokeAlpha;
@property (nonatomic) CGFloat highlightCircleInnerRadius;
@property (nonatomic) CGFloat highlightCircleOuterRadius;
@property (nonatomic) CGFloat highlightCircleStrokeWidth;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label SWIFT_UNAVAILABLE;
@end

@protocol IShapeRenderer;

SWIFT_CLASS("_TtC11ChartsRealm19RealmScatterDataSet")
@interface RealmScatterDataSet : RealmLineScatterCandleRadarDataSet <IScatterChartDataSet>
/**
  The size the scatter shape will have
*/
@property (nonatomic) CGFloat scatterShapeSize;
/**
  The radius of the hole in the shape (applies to Square, Circle and Triangle)
  <em>default</em>: 0.0
*/
@property (nonatomic) CGFloat scatterShapeHoleRadius;
/**
  Color for the hole in the shape. Setting to \code
  nil
  \endcode will behave as transparent.
  <em>default</em>: nil
*/
@property (nonatomic, strong) NSColor * _Nullable scatterShapeHoleColor;
/**
  Sets the ScatterShape this DataSet should be drawn with.
  This will search for an available IShapeRenderer and set this renderer for the DataSet
*/
- (void)setScatterShape:(enum ScatterShape)shape;
/**
  The IShapeRenderer responsible for rendering this DataSet.
  This can also be used to set a custom IShapeRenderer aside from the default ones.
  <em>default</em>: \code
  SquareShapeRenderer
  \endcode
*/
@property (nonatomic, strong) id <IShapeRenderer> _Nullable shapeRenderer;
- (void)initialize SWIFT_METHOD_FAMILY(none);
- (id _Nonnull)copyWithZone:(struct _NSZone * _Nullable)zone;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithLabel:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithResults:(RLMResults<RLMObject *> * _Nullable)results xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithRealm:(RLMRealm * _Nullable)realm modelName:(NSString * _Nonnull)modelName resultsWhere:(NSString * _Nonnull)resultsWhere xValueField:(NSString * _Nullable)xValueField yValueField:(NSString * _Nonnull)yValueField label:(NSString * _Nullable)label OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
