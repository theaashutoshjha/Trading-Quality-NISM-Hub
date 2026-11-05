import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// Admin portal -> dist/admin-app/ (served by the Worker ONLY to authenticated admins)
export default defineConfig({
  root: 'web/admin',
  publicDir: false,
  base: '/admin-app/',
  plugins: [react()],
  build: { outDir: '../../dist/admin-app', emptyOutDir: true, chunkSizeWarningLimit: 900 },
});
