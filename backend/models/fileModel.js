const mongoose = require('mongoose');

const fileSchema = new mongoose.Schema({
    originalname: String,
    filename: String,
    path: String,
    project: String,
    version: String,
    commitMessage: String,
    commitId: String,
    timestamp: { type: Date, default: Date.now },
    hash: String,
    tag: String,
    latest_user: String
});

const FileModel = mongoose.model('File', fileSchema);

module.exports = { FileModel }