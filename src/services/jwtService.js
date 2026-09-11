// Serviço de emissão/verificação de JWT
const jwt = require('jsonwebtoken');
const env = require('../config/env');

exports.assinar = (payload) =>
  jwt.sign(payload, env.jwt.secret, { expiresIn: env.jwt.expiresIn });

exports.verificar = (token) => jwt.verify(token, env.jwt.secret);
