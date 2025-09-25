// src/polyfill.ts
import { webcrypto } from 'crypto';

if (!globalThis.crypto) {
  globalThis.crypto = webcrypto as any;
}

// También asegurar que esté disponible en el objeto global
if (!global.crypto) {
  (global as any).crypto = webcrypto;
}