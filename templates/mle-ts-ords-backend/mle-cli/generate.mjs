import '../rest/config.mjs';
import { ords } from './ords.mjs';
import fs from 'fs';
import { fileURLToPath } from 'url';
import path from 'path';

const sql = ords.generatePLSQL();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const outPath = path.resolve(__dirname, '../rest/ords.sql');
fs.writeFileSync(outPath, sql, 'utf-8');
console.log('ORDS config written to ../rest/ords.sql');