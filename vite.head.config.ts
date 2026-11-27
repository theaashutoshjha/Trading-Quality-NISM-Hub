import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// Head portal -> dist/head-app/ (served by the Worker ONLY to authenticated team heads / admins)
export default defineConfig({
  root: 'web/head',
  publicDir: false,
  base: '/head-app/',
  plugins: [react()],
  build: { outDir: '../../dist/head-app', emptyOutDir: true, chunkSizeWarningLimit: 900 },
});
