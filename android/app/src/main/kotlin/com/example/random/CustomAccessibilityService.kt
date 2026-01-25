package com.example.random

import android.accessibilityservice.AccessibilityService
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import android.view.accessibility.AccessibilityEvent
import android.widget.Toast

class CustomAccessibilityService : AccessibilityService() {
    
    companion object {
        private const val TAG = "CustomAccessibility"
        const val ACTION_TAKE_SCREENSHOT = "com.example.random.TAKE_SCREENSHOT"
        const val ACTION_LOCK_SCREEN = "com.example.random.LOCK_SCREEN"
        
        @Volatile
        private var instance: CustomAccessibilityService? = null
        
        fun isRunning(): Boolean = instance != null
        
        fun lockScreen() {
            instance?.performLockScreen()
        }
        
        fun getInstance(): CustomAccessibilityService? = instance
    }
    
    private val actionReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            Log.d(TAG, "Broadcast received: ${intent?.action}")
            when (intent?.action) {
                ACTION_TAKE_SCREENSHOT -> takeScreenshot()
                ACTION_LOCK_SCREEN -> performLockScreen()
            }
        }
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        instance = this
        Log.d(TAG, "Accessibility service connected")
        
        try {
            val filter = IntentFilter().apply {
                addAction(ACTION_TAKE_SCREENSHOT)
                addAction(ACTION_LOCK_SCREEN)
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                registerReceiver(actionReceiver, filter, RECEIVER_NOT_EXPORTED)
            } else {
                registerReceiver(actionReceiver, filter)
            }
            Log.d(TAG, "Broadcast receiver registered")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to register receiver", e)
        }
    }
    
    private fun performLockScreen() {
        try {
            Log.d(TAG, "Attempting to lock screen...")
            val result = performGlobalAction(GLOBAL_ACTION_LOCK_SCREEN)
            Log.d(TAG, "Lock screen action result: $result")
            if (!result) {
                Toast.makeText(this, "Failed to lock screen", Toast.LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error locking screen", e)
            Toast.makeText(this, "Error: ${e.message}", Toast.LENGTH_SHORT).show()
        }
    }
    
    private fun takeScreenshot() {
        try {
            Log.d(TAG, "Attempting to take screenshot...")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                val result = performGlobalAction(GLOBAL_ACTION_TAKE_SCREENSHOT)
                Log.d(TAG, "Screenshot action result: $result")
                if (!result) {
                    Toast.makeText(this, "Failed to take screenshot", Toast.LENGTH_SHORT).show()
                }
            } else {
                Toast.makeText(this, "Screenshot not supported on Android 8 and below", Toast.LENGTH_SHORT).show()
                Log.e(TAG, "Screenshot not supported on this Android version")
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error taking screenshot", e)
            Toast.makeText(this, "Error: ${e.message}", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        // Not needed for screenshot/lock functionality
    }

    override fun onInterrupt() {
        Log.d(TAG, "Accessibility service interrupted")
    }

    override fun onDestroy() {
        super.onDestroy()
        instance = null
        try {
            unregisterReceiver(actionReceiver)
            Log.d(TAG, "Broadcast receiver unregistered")
        } catch (e: Exception) {
            Log.e(TAG, "Error unregistering receiver", e)
        }
    }
}