import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.example.app',
  appName: 'Explora Nicaragua',
  webDir: 'dist/nicatourism-web-app/browser',
  // Para que funcione en Android 9+ sin HTTPS
  // server: {
  //   androidScheme: 'http',
  //   cleartext: true
  // }
};

export default config;
