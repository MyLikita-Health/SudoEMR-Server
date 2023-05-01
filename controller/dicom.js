const multer = require("multer");
const { localUpload } = require("../config/multer");

exports.dicomSingleUpload = (req, res) => {
  localUpload.single("files")(req, res, (err) => {
    if (err instanceof multer.MulterError) {
      return res.status(500).json({ success: false, err });
    } else if (err) {
      return res.status(500).json({ success: false, err });
    }

    return res.json({ success: true, url: req.file });
  });
};

exports.dicomMultipleUpload = (req, res) => {
  localUpload.array("files")(req, res, (err) => {
    if (err instanceof multer.MulterError) {
      return res.status(500).json({ success: false, err });
    } else if (err) {
      return res.status(500).json({ success: false, err });
    }
    return res.json({ success: true, url: req.file });
  });
};
