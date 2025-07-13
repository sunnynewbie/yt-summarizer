// scripts/exportSwagger.js
import swaggerSpec from '../docs/swagger.js'
import fs from 'fs';

fs.writeFileSync('openapi.json', JSON.stringify(swaggerSpec, null, 2));
