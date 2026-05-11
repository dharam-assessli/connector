import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    val keystoreProperties = Properties()
    val keystorePropertiesFile = rootProject.file("key.properties")
    if (keystorePropertiesFile.exists()) {
        keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    }

    namespace = "com.assessli.connector"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.assessli.connector"
        minSdk = 26
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            if (keystorePropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            }
        }
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
        }
        getByName("profile") {
            isMinifyEnabled = false
            isShrinkResources = false
            if (keystorePropertiesFile.exists()) {
                signingConfig = signingConfigs.getByName("release")
            }
            matchingFallbacks += listOf("release")
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("development") {
            dimension = "default"
            resValue("string", "app_name", "Dotsin Connector Development")
            applicationIdSuffix = ".development"
            manifestPlaceholders["MAPS_API_KEY"] = "AIzaSyDf7k7tRdUZvGS0ehW-VB19kFwPxzQj5v0"
        }

        create("staging") {
            dimension = "default"
            resValue("string", "app_name", "Dotsin Connector Staging")
            applicationIdSuffix = ".staging"
            manifestPlaceholders["MAPS_API_KEY"] = "AIzaSyDf7k7tRdUZvGS0ehW-VB19kFwPxzQj5v0"
        }
        
        create("production") {
            dimension = "default"
            resValue("string", "app_name", "Dotsin Connector")
            applicationIdSuffix = ""
            manifestPlaceholders["MAPS_API_KEY"] = "AIzaSyDf7k7tRdUZvGS0ehW-VB19kFwPxzQj5v0"
        }
    }

    packaging {
        resources {
            excludes += setOf(
                "/META-INF/{AL2.0,LGPL2.1}",
                "/META-INF/DEPENDENCIES",
                "/META-INF/LICENSE",
                "/META-INF/LICENSE.txt",
                "/META-INF/NOTICE",
                "/META-INF/NOTICE.txt"
            )
        }
        jniLibs {
            useLegacyPackaging = true
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    implementation("androidx.window:window:1.3.0")
    implementation("androidx.window:window-java:1.3.0")

    implementation("androidx.multidex:multidex:2.0.1")

    implementation("androidx.health.connect:connect-client:1.1.0-alpha07")

    implementation("androidx.work:work-runtime-ktx:2.10.0")

    implementation(platform("com.google.firebase:firebase-bom:33.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-crashlytics")
    implementation("com.google.firebase:firebase-messaging")
}
