#include <IOKit/hidsystem/IOHIDEventSystemClient.h>
#include <Foundation/Foundation.h>
#include <stdio.h>

// Declarations from other IOKit source code

typedef struct __IOHIDEvent *IOHIDEventRef;
typedef struct __IOHIDServiceClient *IOHIDServiceClientRef;
#ifdef __LP64__
typedef double IOHIDFloat;
#else
typedef float IOHIDFloat;
#endif

IOHIDEventSystemClientRef IOHIDEventSystemClientCreate(CFAllocatorRef allocator);
int IOHIDEventSystemClientSetMatching(IOHIDEventSystemClientRef client, CFDictionaryRef match);
int IOHIDEventSystemClientSetMatchingMultiple(IOHIDEventSystemClientRef client, CFArrayRef match);
IOHIDEventRef IOHIDServiceClientCopyEvent(IOHIDServiceClientRef, int64_t , int32_t, int64_t);
CFStringRef IOHIDServiceClientCopyProperty(IOHIDServiceClientRef service, CFStringRef property);
IOHIDFloat IOHIDEventGetFloatValue(IOHIDEventRef event, int32_t field);

CFDictionaryRef matching(int page, int usage)
{
    CFNumberRef nums[2];
    CFStringRef keys[2];
    
    keys[0] = CFStringCreateWithCString(0, "PrimaryUsagePage", 0);
    keys[1] = CFStringCreateWithCString(0, "PrimaryUsage", 0);
    nums[0] = CFNumberCreate(0, kCFNumberSInt32Type, &page);
    nums[1] = CFNumberCreate(0, kCFNumberSInt32Type, &usage);
    
    CFDictionaryRef dict = CFDictionaryCreate(0, (const void**)keys, (const void**)nums, 2, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    return dict;
}

CFArrayRef getProductNames(CFDictionaryRef sensors) {
    IOHIDEventSystemClientRef system = IOHIDEventSystemClientCreate(kCFAllocatorDefault);
    
    IOHIDEventSystemClientSetMatching(system, sensors);
    CFArrayRef matchingsrvs = IOHIDEventSystemClientCopyServices(system);
    
    long count = CFArrayGetCount(matchingsrvs);
    CFMutableArrayRef array = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    
    for (int i = 0; i < count; i++) {
        IOHIDServiceClientRef sc = (IOHIDServiceClientRef)CFArrayGetValueAtIndex(matchingsrvs, i);
        CFStringRef name = IOHIDServiceClientCopyProperty(sc, CFSTR("Product"));
        if (name) {
            CFArrayAppendValue(array, name);
        } else {
            CFArrayAppendValue(array, @"noname");
        }
    }
    return array;
}

#define IOHIDEventFieldBase(type)   (type << 16)
#define kIOHIDEventTypeTemperature  15
#define kIOHIDEventTypePower        25

CFArrayRef getPowerValues(CFDictionaryRef sensors) {
    IOHIDEventSystemClientRef system = IOHIDEventSystemClientCreate(kCFAllocatorDefault);
    IOHIDEventSystemClientSetMatching(system, sensors);
    CFArrayRef matchingsrvs = IOHIDEventSystemClientCopyServices(system);
    
    long count = CFArrayGetCount(matchingsrvs);
    CFMutableArrayRef array = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    for (int i = 0; i < count; i++) {
        IOHIDServiceClientRef sc = (IOHIDServiceClientRef)CFArrayGetValueAtIndex(matchingsrvs, i);
        IOHIDEventRef event = IOHIDServiceClientCopyEvent(sc, kIOHIDEventTypePower, 0, 0);
        
        CFNumberRef value;
        if (event != 0) {
            double temp = IOHIDEventGetFloatValue(event, IOHIDEventFieldBase(kIOHIDEventTypePower));
            value = CFNumberCreate(kCFAllocatorDefault, kCFNumberDoubleType, &temp);
        } else {
            double temp = 0;
            value = CFNumberCreate(kCFAllocatorDefault, kCFNumberDoubleType, &temp);
        }
        CFArrayAppendValue(array, value);
    }
    return array;
}

CFArrayRef getThermalValues(CFDictionaryRef sensors) {
    IOHIDEventSystemClientRef system = IOHIDEventSystemClientCreate(kCFAllocatorDefault);
    IOHIDEventSystemClientSetMatching(system, sensors);
    CFArrayRef matchingsrvs = IOHIDEventSystemClientCopyServices(system);
    
    long count = CFArrayGetCount(matchingsrvs);
    CFMutableArrayRef array = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    for (int i = 0; i < count; i++) {
        IOHIDServiceClientRef sc = (IOHIDServiceClientRef)CFArrayGetValueAtIndex(matchingsrvs, i);
        IOHIDEventRef event = IOHIDServiceClientCopyEvent(sc, kIOHIDEventTypeTemperature, 0, 0);
        
        CFNumberRef value;
        if (event != 0) {
            double temp = IOHIDEventGetFloatValue(event, IOHIDEventFieldBase(kIOHIDEventTypeTemperature));
            value = CFNumberCreate(kCFAllocatorDefault, kCFNumberDoubleType, &temp);
        } else {
            double temp = 0;
            value = CFNumberCreate(kCFAllocatorDefault, kCFNumberDoubleType, &temp);
        }
        CFArrayAppendValue(array, value);
    }
    return array;
}

void dumpValues(CFArrayRef values)
{
    long count = CFArrayGetCount(values);
    for (int i = 0; i < count; i++) {
        CFNumberRef value = CFArrayGetValueAtIndex(values, i);
        double temp = 0.0;
        CFNumberGetValue(value, kCFNumberDoubleType, &temp);
         //NSLog(@"value = %lf\n", temp);
        printf(", %lf", temp);
    }
}

void dumpNames(CFArrayRef names, CFArrayRef values)
{
    long count = CFArrayGetCount(names);
    for (int i = 0; i < count; i++) {
        NSString *name = (NSString *)CFArrayGetValueAtIndex(names, i);
        printf("%s = ", [name UTF8String]);
        CFNumberRef value = CFArrayGetValueAtIndex(values, i);
        double temp = 0.0;
        CFNumberGetValue(value, kCFNumberDoubleType, &temp);
        printf("%lf;\n", temp);
    }
}

int main(int argc, char *argv[]) {
    if (argc!=1)
    {
        printf("Usage: sensors \n");
        exit(1);
    }
    typedef struct __IOHIDEvent *IOHIDEventRef;
    typedef struct __IOHIDServiceClient *IOHIDServiceClientRef;
    #ifdef __LP64__
    typedef double IOHIDFloat;
    #else
    typedef float IOHIDFloat;
    #endif
    
    #define IOHIDEventFieldBase(type)   (type << 16)
    #define kIOHIDEventTypeTemperature  15
    #define kIOHIDEventTypePower        25

    IOHIDEventSystemClientRef IOHIDEventSystemClientCreate(CFAllocatorRef allocator);
    int IOHIDEventSystemClientSetMatching(IOHIDEventSystemClientRef client, CFDictionaryRef match);
    int IOHIDEventSystemClientSetMatchingMultiple(IOHIDEventSystemClientRef client, CFArrayRef match);
    IOHIDEventRef IOHIDServiceClientCopyEvent(IOHIDServiceClientRef, int64_t , int32_t, int64_t);
    CFStringRef IOHIDServiceClientCopyProperty(IOHIDServiceClientRef service, CFStringRef property);
    IOHIDFloat IOHIDEventGetFloatValue(IOHIDEventRef event, int32_t field);

    printf("\nIOKit Sensors Info >>\n\n");
    
    printf("\n=> Current sensors (A): ");
    CFDictionaryRef currentSensors = matching(0xff08, 2);
    CFArrayRef currentNames = getProductNames(currentSensors);
    CFArrayRef currentValues = getPowerValues(currentSensors);
    long countCurrent = CFArrayGetCount(currentNames);
    printf("(%ld current sensors found)\n-------------------------\n", countCurrent);
    dumpNames(currentNames, currentValues);
    
    printf("\n=> Voltage sensors (V): ");
    CFDictionaryRef voltageSensors = matching(0xff08, 3);
    CFArrayRef voltageNames = getProductNames(voltageSensors);
    CFArrayRef voltageValues = getPowerValues(voltageSensors);
    long countVoltage = CFArrayGetCount(voltageNames);
    printf("(%ld voltage sensors found)\n-------------------------\n", countVoltage);
    dumpNames(voltageNames, voltageValues);

    printf("\n=> Thermal sensors (°C): ");
    CFDictionaryRef thermalSensors = matching(0xff00, 5);
    CFArrayRef thermalNames = getProductNames(thermalSensors);
    CFArrayRef thermalValues = getThermalValues(thermalSensors);
    long countThermal = CFArrayGetCount(thermalNames);
    printf("(%ld thermal sensors found)\n-------------------------\n", countThermal);
    dumpNames(thermalNames, thermalValues);

    return 0;

}
