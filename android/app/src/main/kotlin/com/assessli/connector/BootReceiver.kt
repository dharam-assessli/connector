// package com.assessli.connector

// import android.content.BroadcastReceiver
// import android.content.Context
// import android.content.Intent
// import android.util.Log
// import androidx.work.*
// import java.util.concurrent.TimeUnit

// class BootReceiver : BroadcastReceiver() {
//     override fun onReceive(context: Context, intent: Intent) {
//         if (
//             intent.action == Intent.ACTION_BOOT_COMPLETED ||
//             intent.action == Intent.ACTION_MY_PACKAGE_REPLACED
//         ) {
//             Log.d("BootReceiver", "Re-registering WorkManager tasks")
//             registerTasks(context)
//         }
//     }

//     private fun registerTasks(context: Context) {
//         val workManager = WorkManager.getInstance(context)

//         @Suppress("UNCHECKED_CAST")
//         val workerClass = Class.forName("be.tramckrijte.workmanager.BackgroundWorker")
//             .asSubclass(ListenableWorker::class.java)

//         val constraints = Constraints.Builder()
//             .setRequiredNetworkType(NetworkType.NOT_REQUIRED)
//             .setRequiresBatteryNotLow(false)
//             .setRequiresCharging(false)
//             .setRequiresDeviceIdle(false)
//             .setRequiresStorageNotLow(false)
//             .build()

//         // One-off task
//         val oneOffRequest = OneTimeWorkRequest.Builder(workerClass)
//             .setConstraints(constraints)
//             .setInputData(
//                 workDataOf(
//                     "be.tramckrijte.workmanager.DART_TASK" to "androidOneOffTask"
//                 )
//             )
//             .build()

//         workManager.enqueueUniqueWork(
//             "androidOneOffTask",
//             ExistingWorkPolicy.KEEP,
//             oneOffRequest
//         )

//         // Periodic task
//         val periodicRequest = PeriodicWorkRequest.Builder(
//             workerClass,
//             15, TimeUnit.MINUTES
//         )
//             .setConstraints(constraints)
//             .setInputData(
//                 workDataOf(
//                     "be.tramckrijte.workmanager.DART_TASK" to "androidPeriodicTask"
//                 )
//             )
//             .build()

//         workManager.enqueueUniquePeriodicWork(
//             "androidPeriodicTask",
//             ExistingPeriodicWorkPolicy.KEEP,
//             periodicRequest
//         )

//         Log.d("BootReceiver", "Tasks re-registered successfully")
//     }
// }