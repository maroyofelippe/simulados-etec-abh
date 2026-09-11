// Config do multer para uploads (logo de unidade e CSVs em memória)
const multer = require('multer');
const path = require('path');

const storageDisco = multer.diskStorage({
  destination: path.join(__dirname, '..', 'public', 'uploads'),
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    cb(null, `logo_${Date.now()}${ext}`);
  }
});

exports.uploadLogo = multer({ storage: storageDisco, limits: { fileSize: 2 * 1024 * 1024 } });
exports.uploadCsv = multer({ storage: multer.memoryStorage(), limits: { fileSize: 5 * 1024 * 1024 } });
