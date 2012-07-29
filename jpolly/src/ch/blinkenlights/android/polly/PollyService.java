/*
**
** (C) 2012 Adrian Ulrich
**
** Licensed under the Apache License, Version 2.0 (the "License");
** you may not use this file except in compliance with the License.
** You may obtain a copy of the License at
**
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS,
** WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
** See the License for the specific language governing permissions and
** limitations under the License.
**
**
*/

package ch.blinkenlights.android.polly;

import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;
import android.content.Intent;
import android.content.IntentFilter;

import android.media.AudioManager;
import android.net.LocalSocket;
import android.net.LocalSocketAddress;


public class PollyService extends Service {
	private final IBinder ply_binder = new LocalBinder();
	private final String  rild_socket = "/dev/socket/rild-audio-gsm";
	private AudioManager aMgr;
	private int lastvol = -1;
	
	@Override
	public IBinder onBind(Intent i) {
		return ply_binder;
	}
	
	public class LocalBinder extends Binder {
		public PollyService getService() {
			return PollyService.this;
		}
	}
	
	@Override
	public void onCreate() {
		registerReceiver(ply_receiver, new IntentFilter("android.media.VOLUME_CHANGED_ACTION")); /* undocumented */
		aMgr = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
	}
	
	public void onDestroy() {
		unregisterReceiver(ply_receiver);
	}
	
	
	private final BroadcastReceiver ply_receiver = new BroadcastReceiver() {
		@Override
		public void onReceive(Context ctx, Intent intent) {
			int curvol = aMgr.getStreamVolume(aMgr.STREAM_VOICE_CALL);
			
			if(lastvol != curvol) {
				lastvol = curvol;
				setIncallVolumeTo(curvol);
			}
			
		}
		
		private void setIncallVolumeTo(int avol) {
			/* android volumes go from 0-5
			** but the modem expects 44-94
			*/
			
			String vparam = "volo,40,8,3,"+(44+avol*10);
			
			Log.d("PollyService", "android_volume="+avol+", polly_command="+vparam);
			
			
			LocalSocket lsock = new LocalSocket();
			try {
				lsock.connect(new LocalSocketAddress(rild_socket, LocalSocketAddress.Namespace.FILESYSTEM));
				lsock.getOutputStream().write(vparam.getBytes());
			}
			catch (Exception e) {}
			
			try {
				lsock.close();
			} catch(Exception e) {}
		}
		
	};
}
