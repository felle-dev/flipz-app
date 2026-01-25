package com.example.random

import android.app.Activity
import android.os.Bundle
import android.widget.Toast

class ShortcutHandlerActivity : Activity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        when (intent?.action) {
            "com.example.random.LOCK_SCREEN" -> {
                lockScreen()
            }
        }
        
        // Finish immediately, we don't need to show any UI
        finish()
    }
    
    private fun lockScreen() {
        if (CustomAccessibilityService.getInstance() != null) {
            CustomAccessibilityService.lockScreen()
        } else {
            Toast.makeText(
                this,
                "Please enable accessibility service first",
                Toast.LENGTH_LONG
            ).show()
        }
    }
}