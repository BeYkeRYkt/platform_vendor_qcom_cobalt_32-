DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8998_32/overlay
TARGET_KERNEL_VERSION := 4.4
BOARD_HAVE_QCOM_FM := true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# enable the SVA in UI area
TARGET_USE_UI_SVA := true

# Video codec configuration files
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8998/media_profiles.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8998/media_codecs.xml:system/etc/media_codecs.xml
endif #TARGET_ENABLE_QC_AV_ENHANCEMENTS

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk


$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := msm8998_32
PRODUCT_DEVICE := msm8998_32
PRODUCT_BRAND := Android

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

# WLAN chipset
WLAN_CHIPSET := qca_cld3

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android
PRODUCT_BOOT_JARS += tcmiface
PRODUCT_BOOT_JARS += telephony-ext

PRODUCT_PACKAGES += telephony-ext

ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += WfdCommon
#Android oem shutdown hook
PRODUCT_BOOT_JARS += oem-services
endif

ifeq ($(strip $(BOARD_HAVE_QCOM_FM)),true)
PRODUCT_BOOT_JARS += qcom.fmradio
endif #BOARD_HAVE_QCOM_FM

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8998/msm8998.mk

PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res \
        $(QCPATH)/qrdplus/globalization/multi-language/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/qcom/msm8998_32/sensors/hals.conf:system/etc/sensors/hals.conf

# WLAN host driver
ifneq ($(WLAN_CHIPSET),)
PRODUCT_PACKAGES += $(WLAN_CHIPSET)_wlan.ko
endif

# WLAN driver configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8998_32/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener


# Sensor features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:system/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:system/etc/permissions/android.hardware.sensor.hifi_sensors.xml

# FBE support
PRODUCT_COPY_FILES += \
    device/qcom/msm8998_32/init.qti.qseecomd.sh:system/bin/init.qti.qseecomd.sh

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += device/qcom/msm8998_32/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml
