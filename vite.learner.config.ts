import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// Learner portal -> dist/ (public)
export default defineConfig({
  root: 'web/learner',
  publicDir: '../../public',
  base: '/',
  plugins: [react()],
  build: { outDir: '../../dist', emptyOutDir: true, chunkSizeWarningLimit: 900 },
});
