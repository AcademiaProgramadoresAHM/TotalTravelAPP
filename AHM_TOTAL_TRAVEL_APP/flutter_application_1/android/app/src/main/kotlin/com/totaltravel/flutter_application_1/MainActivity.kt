package com.totaltravel.flutter_application_1

import android.content.Intent
import android.os.Bundle
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.messaging.FirebaseMessaging

import com.totaltravel.flutter_application_1.services.NotificationActionService
import com.totaltravel.flutter_application_1.services.DeviceInstallationService
import com.totaltravel.flutter_application_1.services.NotificationRegistrationService
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private lateinit var deviceInstallationService: DeviceInstallationService

    private fun processNotificationActions(intent: Intent, launchAction: Boolean = false) {
        if (intent.hasExtra("action")) {
            var action = intent.getStringExtra("action");

            if (action != null) {
                if (action.isNotEmpty()) {
                    if (launchAction) {
                        PushNotificationsFirebaseMessagingService.notificationActionService?.launchAction = action
                    }
                    else {
                        PushNotificationsFirebaseMessagingService.notificationActionService?.triggerAction(action)
                    }
                }
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        processNotificationActions(intent)
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine?.let {
            deviceInstallationService = DeviceInstallationService(context, it)
            PushNotificationsFirebaseMessagingService.notificationActionService = NotificationActionService(it)
            PushNotificationsFirebaseMessagingService.notificationRegistrationService = NotificationRegistrationService(it)
            if(deviceInstallationService?.playServicesAvailable) {
                FirebaseMessaging.getInstance().token
                        .addOnCompleteListener(OnCompleteListener { task ->
                            if (!task.isSuccessful)
                                return@OnCompleteListener

                            PushNotificationsFirebaseMessagingService.token = task.result
                            PushNotificationsFirebaseMessagingService.notificationRegistrationService?.refreshRegistration()
                        })
            }
        }

        processNotificationActions(this.intent, true)
    }

    //@override public void onBackPressed() { }
}
