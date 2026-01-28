package com.example.random.tiles

import android.content.Context
import android.graphics.drawable.Icon
import android.provider.Settings
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService

class ScreenTimeoutTileService : TileService() {
    
    companion object {
        private const val PREF_NAME = "screen_timeout_prefs"
        private const val KEY_CURRENT_INDEX = "current_timeout_index"
        private const val SETTING = Settings.System.SCREEN_OFF_TIMEOUT
        
        // Timeout values in milliseconds
        private val TIMEOUT_VALUES = listOf(
            60000,      // 1 minute
            1800000,    // 30 minutes
        )
    }
    
    override fun onStartListening() {
        super.onStartListening()
        updateTileState()
    }
    
    private fun updateTileState() {
        val currentTimeout = getCurrentTimeout()
        
        qsTile?.apply {
            state = Tile.STATE_ACTIVE
            label = getTimeoutLabel(currentTimeout)
            icon = getTimeoutIcon(currentTimeout)
            updateTile()
        }
    }
    
    override fun onClick() {
        super.onClick()
        
        // Check if we have WRITE_SETTINGS permission
        if (!Settings.System.canWrite(this)) {
            showPermissionDialog()
            return
        }
        
        // Cycle to next timeout value
        val currentTimeout = getCurrentTimeout()
        val currentIndex = TIMEOUT_VALUES.indexOf(currentTimeout)
        val nextIndex = (currentIndex + 1) % TIMEOUT_VALUES.size
        val nextTimeout = TIMEOUT_VALUES[nextIndex]
        
        // Save the new timeout
        try {
            Settings.System.putInt(contentResolver, SETTING, nextTimeout)
            saveCurrentIndex(nextIndex)
            updateTileState()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
    
    private fun getCurrentTimeout(): Int {
        return try {
            Settings.System.getInt(contentResolver, SETTING)
        } catch (e: Exception) {
            // Default to 30 seconds if unable to read
            30000
        }
    }
    
    private fun saveCurrentIndex(index: Int) {
        val prefs = getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)
        prefs.edit().putInt(KEY_CURRENT_INDEX, index).apply()
    }
    
    private fun getTimeoutLabel(timeout: Int): String {
        val timeoutInSeconds = timeout / 1000
        val minutes = timeoutInSeconds / 60
        
        return "${minutes}m"
    }
    
    private fun getTimeoutIcon(timeout: Int): Icon {
        return Icon.createWithResource(applicationContext, android.R.drawable.ic_lock_idle_alarm)
    }
    
    private fun showPermissionDialog() {
        // Show dialog to request WRITE_SETTINGS permission
        val intent = android.content.Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)
        intent.data = android.net.Uri.parse("package:$packageName")
        intent.addFlags(android.content.Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivityAndCollapse(intent)
    }
}